FROM busybox
MAINTAINER support@gravwell.io
ARG BIN=offlineReplicationServer
ARG CONFIG=replication.conf
RUN mkdir /opt/
RUN mkdir /opt/gravwell
RUN mkdir /opt/gravwell/log
RUN mkdir /opt/gravwell/etc
RUN mkdir /opt/gravwell/bin
COPY $BIN /opt/gravwell/bin/gravwell_offline_replication
COPY $CONFIG /opt/gravwell/etc/$CONFIG
CMD ["/opt/gravwell/bin/gravwell_offline_replication"]
