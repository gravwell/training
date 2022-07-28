ARG VER=latest
FROM gravwell/offline_replication:${VER}
MAINTAINER support@gravwell.io
ARG CONFIG=replication.conf
COPY $CONFIG /opt/gravwell/etc/$CONFIG
CMD ["/opt/gravwell/bin/gravwell_offline_replication"]
