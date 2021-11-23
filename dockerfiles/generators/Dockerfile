FROM busybox:latest
MAINTAINER training@gravwell.io
ARG MANAGE_CONF=manager.cfg

RUN /bin/mkdir -p /opt/gravwell/etc
RUN /bin/mkdir -p /opt/gravwell/log
COPY $MANAGE_CONF /opt/gravwell/etc/
COPY manager /
COPY fieldsGenerator /
COPY csvGenerator /
COPY binaryGenerator /
COPY regexGenerator /
COPY jsonGenerator /

CMD ["/manager"]
