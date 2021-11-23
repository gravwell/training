#!/bin/bash
TGT="/tmp/brokenperms.tar.gz"
base=`docker images -q gravwell:perms`
if [ "$base" == "" ]; then
	echo "we need the gravwell:perms image as a base"
	exit -1
fi
docker build --compress --squash -t gravwell:brokenperms .
docker save gravwell:brokenperms | gzip > $TGT
echo "Base image is at $TGT"
