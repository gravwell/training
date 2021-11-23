#!/bin/bash
set -e
TGT="/tmp/indexer.tar.gz"
docker build -t gravwell:indexer .
docker save gravwell:indexer | gzip > $TGT
echo "Indexer image is at $TGT"
