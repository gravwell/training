FROM ubuntu:latest
MAINTAINER training@gravwell.io
ARG MANAGE_CONF=manager.cfg
ARG CONF=gravwell.conf
ARG INSTALLER=gravwell_installer.sh
ARG MANAGE=/tmp/manager
ARG LICENSE=license

RUN apt update
RUN apt install -y libcap2 libcap2-bin
RUN apt clean
RUN apt autoclean
RUN rm -rf /var/lib/apt/lists/*

COPY $INSTALLER /tmp/installer.sh
RUN /bin/bash /tmp/installer.sh --no-questions
RUN rm -f /tmp/installer.sh
RUN usermod -u 1000 gravwell
RUN groupmod -g 1000 gravwell

COPY $MANAGE_CONF /opt/gravwell/etc/
COPY $MANAGE /opt/gravwell/bin/
COPY $CONF /opt/gravwell/etc/
COPY $LICENSE /opt/gravwell/etc/license

RUN chown gravwell:gravwell -R /opt/gravwell
RUN /sbin/setcap cap_net_bind_service=+ep /opt/gravwell/bin/gravwell_webserver
USER 1000:1000

ENV GRAVWELL_INGEST_AUTH=IngestSecrets
ENV GRAVWELL_INGEST_SECRET=IngestSecrets
ENV GRAVWELL_CONTROL_AUTH=ControlSecrets
ENV GRAVWELL_SEARCHAGENT_AUTH=SearchAgentSecrets
ENV GRAVWELL_PIPE_TARGETS="/opt/gravwell/comms/pipe"
CMD ["/opt/gravwell/bin/manager"]
