#!/bin/bash
set -e
TGT="/tmp/offlinereplication.tar.gz"
$GOPATH/bin/gencert -host offlinereplicator
docker build -t gravwell:offlinereplication --build-arg VER=$VER .
docker save gravwell:offlinereplication | gzip > $TGT
rm -f *.pem offlineReplicationServer
rm -f installer.sh
echo "Offline replication image is at $TGT"
