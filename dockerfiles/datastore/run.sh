#!/bin/bash
set -e
INSTALLER=`ls /tmp/gravwell_datastore_installer_*.sh | head -n 1`
if [ "$1" != "" ]; then
	INSTALLER=$1
fi

if [ ! -f "$INSTALLER" ]; then
	echo "I need an installer"
	exit -1
fi

cp $INSTALLER datastore.sh

TGT="/tmp/datastore.tar.gz"
docker build -t gravwell:datastore .
docker save gravwell:datastore | gzip > $TGT
echo "Base image is at $TGT"

rm datastore.sh
