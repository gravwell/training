#!/bin/bash
if [ ! -f "$LICENSE" ]; then
	echo "I need the training license, set LICENSE variable"
	exit -1
fi

docker rmi gravwell:slim #remove existing slim image
docker pull gravwell/gravwell:${VER} # grabs latest gw image from dockerhub
docker create --name slim gravwell/gravwell:latest #create temp container from latest image
docker cp $LICENSE slim:/opt/gravwell/etc/license
docker export slim | docker import - gravwell:slim #trick to squash. export to stdio then re-import under new tag to create "final" slim container
docker rm slim #destroy tmp container
