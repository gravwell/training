#!/bin/bash
set -e
#note, gravwell:slim needs to be built
if [[ "$(docker images -q gravwell:slim 2> /dev/null)" == "" ]]; then
	echo "missing gravwell:slim"
	exit -1
fi
TGT="/tmp/base.tar.gz"
GO111MODULE=on CGO_ENABLED=0 go install --ldflags "-w -s" github.com/gravwell/gravwell/v3/ingesters/reimport
cp $GOPATH/bin/reimport .
docker build -t gravwell:base .
docker save gravwell:base | gzip > $TGT
echo "Base image is at $TGT"
rm reimport
