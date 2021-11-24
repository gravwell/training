#!/bin/bash
TGT="/tmp/test.tar.gz"
docker rmi gravwell:test

set -e
docker pull busybox:latest
docker create --name test busybox:latest
docker export test | docker import - gravwell:test
docker rm test
docker save gravwell:test | gzip > $TGT
echo "Test image is at $TGT"
