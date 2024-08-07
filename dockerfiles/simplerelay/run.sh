#!/bin/bash
set -e
if [ "$VER" == "" ]; then
	echo "Missing version"
	exit -1
fi
cp -r /usr/share/zoneinfo .

TGT="/tmp/simplerelay.tar.gz"
docker build -t gravwell:simplerelay --no-cache --build-arg VER=$VER .
docker save gravwell:simplerelay | gzip > $TGT
echo "simplerelay image is at $TGT"

rm -rf zoneinfo
