#!/bin/bash

set -e

if [ ! -e "libpcap-1.4.0.tar.gz" ]; then
	echo "Downloading libpcap-1.4.0.tar.gz"
	curl -O http://www.tcpdump.org/release/libpcap-1.4.0.tar.gz
fi

tar zxf libpcap-1.4.0.tar.gz -C .
cd "libpcap-1.4.0"

rm -f *.a

./configure --disable-shared --enable-static --with-pcap=bpf

cp -rf ../include/net .
cp -rf ../include/netinet .

cp -f ../Makefile.ios Makefile 
make clean
make

cp -f ../Makefile.simulator Makefile 
make clean
make

xcrun -sdk iphoneos lipo \
	  -arch armv7 libpcap-ios.a \
	  -arch i386 libpcap-simulator.a \
	  -create -output libpcap.a