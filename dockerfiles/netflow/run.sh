#!/bin/bash
set -e
if [ "$VER" == "" ]; then
	echo "Missing version"
	exit -1
fi
cp -r /usr/share/zoneinfo .

TGT="/tmp/netflow.tar.gz"
docker build -t gravwell:netflow --no-cache --build-arg VER=$VER .
docker save gravwell:netflow | gzip > $TGT
echo "netflow image is at $TGT"

rm -rf zoneinfo
