#!/bin/bash
if [ "$VER" == "" ]; then
	echo "Missing version"
	exit -1
fi

SIMPLE_RELAY=/tmp/gravwell_simple_relay_installer_$VER.sh
FILE_FOLLOW=/tmp/gravwell_file_follow_installer_$VER.sh
NETFLOW=/tmp/gravwell_netflow_capture_installer_$VER.sh
PCAP=/tmp/gravwell_network_capture_installer_$VER.sh
FEDERATOR=/tmp/gravwell_federator_installer_$VER.sh
if [ "$FILE_FOLLOW" == "" ]; then
	echo "File follower missing"
	exit -1
fi
if [ "$SIMPLE_RELAY" == "" ]; then
	echo "simple relay missing"
	exit -1
fi
if [ "$NETFLOW" == "" ]; then
	echo "netflow missing"
	exit -1
fi
if [ "$PCAP" == "" ]; then
	echo "network_capture missing"
	exit -1
fi
if [ "$FEDERATOR" == "" ]; then
	echo "federator missing"
	exit -1
fi

if [ ! -f "$FILE_FOLLOW" ]; then
	echo "$FILE_FOLLOW is not a file"
	exit -1
fi

if [ ! -f "$SIMPLE_RELAY" ]; then
	echo "$SIMPLE_RELAY is not a file"
	exit -1
fi
if [ ! -f "$NETFLOW" ]; then
	echo "$NETFLOW is not a file"
	exit -1
fi
if [ ! -f "$PCAP" ]; then
	echo "$PCAP is not a file"
	exit -1
fi
if [ ! -f "$FEDERATOR" ]; then
	echo "$FEDERATOR is not a file"
	exit -1
fi
cp $SIMPLE_RELAY simple_relay.sh
cp $FILE_FOLLOW file_follow.sh
cp $NETFLOW netflow.sh
cp $PCAP network_capture.sh
cp $FEDERATOR federator.sh
cp -r /usr/share/zoneinfo .

# Install the JSON generator
GO111MODULE=on CGO_ENABLED=0 go install --ldflags "-w -s" github.com/gravwell/gravwell/v3/generators/jsonGenerator
cp $GOPATH/bin/jsonGenerator .

# Install the CSV generator
GO111MODULE=on CGO_ENABLED=0 go install --ldflags "-w -s" github.com/gravwell/gravwell/v3/generators/csvGenerator
cp $GOPATH/bin/csvGenerator .

# Build the reimport ingester
GO111MODULE=on CGO_ENABLED=0 go install --ldflags "-w -s" github.com/gravwell/gravwell/v3/ingesters/reimport
cp $GOPATH/bin/reimport .


TGT="/tmp/ingesters.tar.gz"
docker build -t gravwell:ingesters --no-cache .
docker save gravwell:ingesters | gzip > $TGT
echo "Ingesters image is at $TGT"

rm simple_relay.sh
rm file_follow.sh
rm netflow.sh
rm network_capture.sh
rm federator.sh
rm jsonGenerator
rm csvGenerator
rm reimport
rm -r zoneinfo
