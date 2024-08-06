#!/bin/bash
set -e
if [ "$VER" == "" ]; then
	echo "Missing version"
	exit -1
fi
cp -r /usr/share/zoneinfo .

TGT="/tmp/pcap.tar.gz"
docker build -t gravwell:pcap --no-cache .
docker save gravwell:pcap | gzip > $TGT
echo "PCAP image is at $TGT"

rm -rf zoneinfo
