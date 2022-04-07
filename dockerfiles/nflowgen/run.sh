#!/bin/bash
set -e
TGT="/tmp/nflow.tar.gz"
go get -u github.com/nerdalert/nflow-generator
CGO_ENABLED=0 go install --ldflags "-w -s" github.com/nerdalert/nflow-generator
NFGEN=$(readlink -f $GOPATH/bin/nflow-generator)

if [ ! -f "$NFGEN" ]; then
	echo "couldn't get/build the nflow-generator $NFGEN"
	exit -1
fi

cp $NFGEN .

docker build -t networkstatic/nflow-generator:latest .
echo "done building"
docker save networkstatic/nflow-generator:latest | gzip > $TGT
echo "Done saving"
docker rmi networkstatic/nflow-generator:latest
rm -f nflow-generator
echo "done cleaning"

echo "your image is at $TGT"
