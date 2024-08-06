#!/bin/bash
set -e

CGO_ENABLED=0 go install --ldflags "-w -s" github.com/gravwell/gravwell/v3/manager@dev
CGO_ENABLED=0 go install --ldflags "-w -s" github.com/gravwell/gravwell/v3/generators/gravwellGenerator@dev

cp $GOPATH/bin/manager .
cp $GOPATH/bin/fieldsGenerator .
cp $GOPATH/bin/csvGenerator .
cp $GOPATH/bin/binaryGenerator .
cp $GOPATH/bin/regexGenerator .
cp $GOPATH/bin/jsonGenerator .


TGT="/tmp/generators.tar.gz"
docker build --compress -t gravwell:generators .
docker save gravwell:generators | gzip > $TGT
echo "Base image is at $TGT"

rm *Generator
rm manager
