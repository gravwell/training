#!/bin/bash
if [ "$VER" == "" ]; then
	echo "Missing version"
	exit -1
fi
rm -f license

TGT="/tmp/perms.tar.gz"
INSTALLER="/tmp/gravwell_$VER.sh"
if [ ! -f "$LICENSE" ]; then
	echo "I need the training license, set LICENSE variable"
	exit -1
fi
if [ ! -f "$INSTALLER" ]; then
        echo "$INSTALLER is not a valid file"
        echo "EXAMPLE: bash build.sh /tmp/gravwell_2.2.8.sh"
        exit -1
fi
SQUASH="--squash"
exp=`docker version -f '{{.Server.Experimental}}'`
if [ "$exp" == "false" ]; then
	echo "your docker instance isn't running with experimental features"
	echo "We need this in order to squash the image during build"
	SQUASH=""
fi
GO111MODULE=on CGO_ENABLED=0 go install -ldflags="-s -w" github.com/gravwell/gravwell/v3/manager
cp $GOPATH/bin/manager .
installer=$(basename $INSTALLER)
cp $INSTALLER $installer

cp $LICENSE license

docker build --no-cache --shm-size=256m $SQUASH --ulimit nofile=32000:32000 \
	--compress --build-arg INSTALLER=$installer \
	--build-arg MANAGE=manager \
	--build-arg MANAGE_CONF=manager.cfg \
	--build-arg LICENSE=license \
	-t gravwell:perms .

docker save gravwell:perms | gzip > $TGT
rm manager
rm -f license
echo "Base image is at $TGT"
