#!/bin/bash
cp -r /usr/share/zoneinfo .

# Install the generator
CGO_ENABLED=0 go install --ldflags "-w -s" github.com/gravwell/gravwell/v3/generators/gravwellGenerator@dev
cp $GOPATH/bin/gravwellGenerator .

# Build the reimport ingester
CGO_ENABLED=0 go install --ldflags "-w -s" github.com/gravwell/gravwell/v3/ingesters/reimport@dev
cp $GOPATH/bin/reimport .


TGT="/tmp/ingesters.tar.gz"
docker build -t gravwell:ingesters --no-cache .
docker save gravwell:ingesters | gzip > $TGT
echo "Ingesters image is at $TGT"

rm gravwellGenerator
rm reimport
rm -r zoneinfo
