#!/bin/bash
set -e

$GOPATH/bin/gencert -host cloudarchive

# Build the server
SERVER_DIR=$GOPATH/src/gravwell/cloudarchive/server
if [ ! -d "$SERVER_DIR" ]; then
        echo "cloud archive server directory not found"
        echo "looking for $SERVER_DIR"
        exit -1
fi
pushd $SERVER_DIR
CGO_ENABLED=0 go build
popd
SERVER=$SERVER_DIR/server
if [ ! -f "$SERVER" ]; then
        echo "Failed to build cloud archive server"
        exit -1
fi
cp $SERVER cloudarchive_server

# Build the usertool
USERTOOL_DIR=$GOPATH/src/gravwell/cloudarchive/usertool
if [ ! -d "$USERTOOL_DIR" ]; then
        echo "cloud archive usertool directory not found"
        echo "looking for $USERTOOL_DIR"
        exit -1
fi
pushd $USERTOOL_DIR
CGO_ENABLED=0 go build
popd
USERTOOL=$USERTOOL_DIR/usertool
if [ ! -f "$USERTOOL" ]; then
        echo "Failed to build cloud archive usertool"
        exit -1
fi
cp $USERTOOL .

# Build the configtool
CONFIGTOOL_DIR=$GOPATH/src/gravwell/cloudarchive/configtool
if [ ! -d "$CONFIGTOOL_DIR" ]; then
        echo "cloud archive configtool directory not found"
        echo "looking for $CONFIGTOOL_DIR"
        exit -1
fi
pushd $CONFIGTOOL_DIR
CGO_ENABLED=0 go build
popd
CONFIGTOOL=$CONFIGTOOL_DIR/configtool
if [ ! -f "$CONFIGTOOL" ]; then
        echo "Failed to build cloud archive configtool"
        exit -1
fi
cp $CONFIGTOOL .

TGT="/tmp/cloudarchive_server.tar.gz"
docker build -t gravwell:cloudarchive .
docker save gravwell:cloudarchive | gzip > $TGT
echo "Base image is at $TGT"

rm -f cloudarchive_server
rm -f usertool
rm -f configtool
rm -f *.pem
