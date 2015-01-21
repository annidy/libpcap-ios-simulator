#!/bin/bash

set -e

if [ ! -e "libpcap-1.4.0.tar.gz" ]; then
	echo "Downloading libpcap-1.4.0.tar.gz"
	curl -O http://www.tcpdump.org/release/libpcap-1.4.0.tar.gz
fi

tar zxf libpcap-1.4.0.tar.gz -C .
cd "libpcap-1.4.0"

./configure --disable-shared --enable-static --with-pcap=bpf

cp -f ../Makefile.ios Makefile 

make