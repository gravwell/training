FROM busybox:latest
MAINTAINER training@gravwell.io
ARG BIN=nflow-generator

RUN mkdir /go
COPY $BIN /go/

WORKDIR /go
ENTRYPOINT ["/go/nflow-generator"]
