#!/bin/bash
set -e
TGT="data/syslog.tar.gz"
CONF="config/gravwell.conf"
LIC=$1
CLIENT=$GOPATH/bin/client

if [ ! -f "$CONF" ]; then
	echo "Missing $CONF"
	exit -1
fi

if [ ! -f "$LIC" ]; then
	echo "I need path to a license as an argument"
	echo "EXAMPLE: bash $0 /tmp/test.license"
	exit -1
fi

if [ ! -f "$CLIENT" ]; then
	echo "I need the client installed in $GOPATH/bin"
	exit -1
fi

GO111MODULE=on CGO_ENABLED=0 go install --ldflags "-w -s" github.com/gravwell/gravwell/v3/generators/syslogGenerator
SYSGEN=$GOPATH/bin/syslogGenerator
if [ ! -f "$SYSGEN" ]; then
	echo "Failed to build syslog generator"
	exit -1
fi

docker pull gravwell/gravwell:latest
docker create --name syslogdata gravwell/gravwell:latest
docker cp $CONF syslogdata:/opt/gravwell/etc/
docker cp $LIC syslogdata:/opt/gravwell/etc/license
docker start syslogdata
IP=$(docker inspect --format '{{.NetworkSettings.IPAddress}}' syslogdata)
sleep 1
$SYSGEN -clear-conns $IP:4023 -duration 30d -entry-count=20000 -tag-name=syslog
if [ "$?" != 0 ]; then
	echo "Failed to ingest data"
	exit -1
fi

sleep 1
docker exec syslogdata killall gravwell_indexer #cycle the indexer to get it to flush its data
sleep 1

# Use the client to download the data
(echo admin; sleep 1; echo changeme) | client -s $IP -insecure-no-https -t -time -721h -query 'tag=syslog raw' -download data/syslogdata -download-format json search

# clean up the container
docker stop syslogdata
docker rm syslogdata

echo "data is at $TGT"
