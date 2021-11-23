FROM gravwell:base
MAINTAINER training@gravwell.io
ARG MANAGE_CONF=manager.cfg
RUN /bin/mkdir -p /opt/gravwell/etc
RUN /bin/mkdir -p /opt/gravwell/log
RUN /bin/mkdir -p /opt/gravwell/bin
RUN /bin/mkdir -p /opt/gravwell/cloud_archive

COPY $MANAGE_CONF /opt/gravwell/etc/
COPY cert.pem /opt/gravwell/etc/
COPY key.pem /opt/gravwell/etc
COPY cloudarchive_server /opt/gravwell/bin/
COPY usertool /opt/gravwell/bin/
COPY configtool /opt/gravwell/bin/
COPY cloudarchive.conf /opt/gravwell/etc/

RUN /bin/touch /opt/gravwell/etc/cloud.passwd

CMD ["/opt/gravwell/bin/manager"]
