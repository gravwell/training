#!/bin/bash
set -e
#note, gravwell:slim needs to be built
if [[ "$(docker images -q gravwell:slim 2> /dev/null)" == "" ]]; then
	echo "missing gravwell:slim"
	exit -1
fi
TGT="/tmp/base.tar.gz"
docker build -t gravwell:base .
docker save gravwell:base | gzip > $TGT
echo "Base image is at $TGT"
