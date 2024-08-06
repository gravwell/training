#!/bin/bash
set -e
TGT="/tmp/nflow.tar.gz"
docker pull networkstatic/nflow-generator:latest
docker save networkstatic/nflow-generator:latest | gzip > $TGT
echo "Done saving"
docker rmi networkstatic/nflow-generator:latest
rm -f nflow-generator
echo "done cleaning"

echo "your image is at $TGT"
