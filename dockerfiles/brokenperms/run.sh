#!/bin/bash
TGT="/tmp/brokenperms.tar.gz"
base=`docker images -q gravwell:perms`
if [ "$base" == "" ]; then
	echo "we need the gravwell:perms image as a base"
	exit -1
fi

SQUASH="--squash"
exp=`docker version -f '{{.Server.Experimental}}'`
if [ "$exp" == "false" ]; then
	echo "your docker instance isn't running with experimental features"
	echo "We need this in order to squash the image during build"
	SQUASH=""
fi

docker build --compress $SQUASH -t gravwell:brokenperms .
docker save gravwell:brokenperms | gzip > $TGT
echo "Base image is at $TGT"
