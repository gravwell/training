FROM gravwell:slim
MAINTAINER training@gravwell.io
ARG MANAGE_CONF=manager.cfg
ARG CONF=gravwell.conf
RUN /bin/rm -rf /opt/gravwell/storage/*
RUN /bin/rm -f /opt/gravwell/bin/gravwell_simple_relay
RUN /bin/rm -f /opt/gravwell/bin/gencert
RUN /bin/rm -f /opt/gravwell/bin/gravwell_crash_report

COPY reimport /opt/gravwell/bin/
COPY $MANAGE_CONF /opt/gravwell/etc/
COPY $CONF /opt/gravwell/etc/
ENV GRAVWELL_INGEST_AUTH=IngestSecrets
ENV GRAVWELL_INGEST_SECRET=IngestSecrets
ENV GRAVWELL_CONTROL_AUTH=ControlSecrets
ENV GRAVWELL_SEARCHAGENT_AUTH=SearchAgentSecrets
ENV GRAVWELL_PIPE_TARGETS="/opt/gravwell/comms/pipe"
CMD ["/opt/gravwell/bin/manager"]
