#!/bin/bash
set -e

TGT="/tmp/datastore.tar.gz"
docker build --build-arg version=$VER -t gravwell:datastore .
docker save gravwell:datastore | gzip > $TGT
echo "Base image is at $TGT"
