#!/bin/bash
set -e
if [ "$VER" == "" ]; then
	echo "Missing version"
	exit -1
fi
cp -r /usr/share/zoneinfo .

TGT="/tmp/federator.tar.gz"
docker build -t gravwell:federator --no-cache --build-arg VER=$VER .
docker save gravwell:federator | gzip > $TGT
echo "federator image is at $TGT"

rm -rf zoneinfo
