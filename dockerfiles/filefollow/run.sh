#!/bin/bash
set -e
if [ "$VER" == "" ]; then
	echo "Missing version"
	exit -1
fi
cp -r /usr/share/zoneinfo .

TGT="/tmp/filefollow.tar.gz"
docker build -t gravwell:filefollow --no-cache --build-arg VER=$VER .
docker save gravwell:filefollow | gzip > $TGT
echo "filefollow image is at $TGT"

rm -rf zoneinfo
