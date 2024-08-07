#!/bin/bash
set -e
LOGFILE=/tmp/build.log
OUTDIR=../dockerimages/
VER=${VERSION:-latest}

if [ ! -d "$GOPATH" ]; then
	echo "Must set GOPATH"
	exit -1
fi

if [ "$VER" == "" ]; then
	echo "Missing verison information"
	exit -1
fi

if [ ! -f "createslim.sh" ]; then
	echo "Missing createslim.sh script"
	exit -1
fi

if [ ! -f "$LICENSE" ]; then
	echo "Missing license file"
	exit -1
fi

if [ ! -d "$OUTDIR" ]; then
	mkdir -p $OUTDIR
fi

echo >> $LOGFILE
echo "Creating slim container"
echo "Creating slim container as our base" >> $LOGFILE
/bin/bash createslim.sh >> $LOGFILE

if [ "$?" != "0" ]; then
	echo "Failed to create slim container"
	exit -1
fi

function build() {
	d=$1
	if [ "$d" == "" ]; then
		echo "Missing argument"
		exit -1
	fi
	if [ ! -d "$d" ]; then
		echo "$d is not a directory"
		exit -1
	fi

	pushd $d > /dev/null
	if [ -f "run.sh" ]; then
		echo "building $d"
		echo >> $LOGFILE
		echo "building $d" >> $LOGFILE
		VER=$VER bash run.sh >> $LOGFILE
		if [ "$?" != "0" ]; then
			echo "Failed to build $d"
			exit -1
		fi
	else
		echo "$d is missing a run.sh"
		exit -1
	fi
	popd > /dev/null
}

function moveTarget() {
	tgt=$1
	if [ ! -f "$tgt" ]; then
		echo "Missing $tgt"
		exit -1
	fi
	mv "$tgt" $OUTDIR/
}

build "test"
moveTarget "/tmp/test.tar.gz"
build "base"
moveTarget "/tmp/base.tar.gz"
build "indexer"
moveTarget "/tmp/indexer.tar.gz"
build "webserver"
moveTarget "/tmp/webserver.tar.gz"
build "ingesters"
moveTarget "/tmp/ingesters.tar.gz"
build "nflowgen"
moveTarget "/tmp/nflow.tar.gz"
build "offlinereplication"
moveTarget "/tmp/offlinereplication.tar.gz"
build "datastore"
moveTarget "/tmp/datastore.tar.gz"
build "pcap"
moveTarget "/tmp/pcap.tar.gz"
build "netflow"
moveTarget "/tmp/netflow.tar.gz"
build "federator"
moveTarget "/tmp/federator.tar.gz"
build "filefollow"
moveTarget "/tmp/filefollow.tar.gz"
build "simplerelay"
moveTarget "/tmp/simplerelay.tar.gz"
