#!/bin/bash
set -e
if [ "$VER" == "" ]; then
	echo "Missing version"
	exit -1
fi
PCAP=/tmp/gravwell_network_capture_installer_$VER.sh
if [ "$PCAP" == "" ]; then
	echo "network_capture missing"
	exit -1
fi
if [ ! -f "$PCAP" ]; then
	echo "$PCAP is not a file"
	exit -1
fi
cp $PCAP network_capture.sh
cp -r /usr/share/zoneinfo .

TGT="/tmp/pcap.tar.gz"
docker build -t gravwell:pcap --no-cache .
docker save gravwell:pcap | gzip > $TGT
echo "PCAP image is at $TGT"

rm network_capture.sh
rm -rf zoneinfo
