#!/bin/bash
set -e
TGT="/tmp/nflow.tar.gz"
docker pull networkstatic/nflow-generator:latest
docker save networkstatic/nflow-generator:latest | gzip > $TGT
echo "Done saving"

echo "your image is at $TGT"
