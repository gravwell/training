#!/bin/bash
set -e

GO111MODULE=on CGO_ENABLED=0 go install --ldflags "-w -s" github.com/gravwell/gravwell/v3/manager
GO111MODULE=on CGO_ENABLED=0 go install --ldflags "-w -s" github.com/gravwell/gravwell/v3/generators/fieldsGenerator
GO111MODULE=on CGO_ENABLED=0 go install --ldflags "-w -s" github.com/gravwell/gravwell/v3/generators/csvGenerator
GO111MODULE=on CGO_ENABLED=0 go install --ldflags "-w -s" github.com/gravwell/gravwell/v3/generators/binaryGenerator
GO111MODULE=on CGO_ENABLED=0 go install --ldflags "-w -s" github.com/gravwell/gravwell/v3/generators/regexGenerator
GO111MODULE=on CGO_ENABLED=0 go install --ldflags "-w -s" github.com/gravwell/gravwell/v3/generators/jsonGenerator

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
