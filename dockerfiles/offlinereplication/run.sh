#!/bin/bash
set -e
TGT="/tmp/offlinereplication.tar.gz"
$GOPATH/bin/gencert -host offlinereplicator
pushd $GOPATH/src/gravwell/offlineReplicationServer
CGO_ENABLED=0 go build --ldflags "-s -w"
popd
cp $GOPATH/src/gravwell/offlineReplicationServer/offlineReplicationServer .
docker build -t gravwell:offlinereplication .
docker save gravwell:offlinereplication | gzip > $TGT
rm -f *.pem offlineReplicationServer
rm -f installer.sh
echo "Offline replication image is at $TGT"
