#!/bin/bash
set -e
TGT="/tmp/webserver.tar.gz"
docker build -t gravwell:webserver .
docker save gravwell:webserver | gzip > $TGT
echo "Base image is at $TGT"
