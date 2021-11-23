FROM gravwell:base
MAINTAINER training@gravwell.io
ARG MANAGE_CONF=manager.cfg
RUN /bin/rm -rf /opt/gravwell/storage/*
RUN /bin/rm -f /opt/gravwell/bin/gravwell_simple_relay
RUN /bin/rm -f /opt/gravwell/bin/gencert
RUN /bin/rm -f /opt/gravwell/bin/gravwell_crash_report
RUN /bin/rm -f /opt/gravwell/bin/gravwell_indexer
RUN /bin/rm -f /opt/gravwell/bin/gravwell_webserver
RUN /bin/rm -f /opt/gravwell/bin/gravwell_searchagent

COPY $MANAGE_CONF /opt/gravwell/etc/
COPY datastore.sh /tmp
RUN /bin/sh /tmp/datastore.sh --no-questions --no-crash-report --no-start
ENV GRAVWELL_INGEST_AUTH=IngestSecrets
ENV GRAVWELL_INGEST_SECRET=IngestSecrets
ENV GRAVWELL_CONTROL_AUTH=ControlSecrets
ENV GRAVWELL_SEARCHAGENT_AUTH=SearchAgentSecrets
ENV GRAVWELL_PIPE_TARGETS="/opt/gravwell/comms/pipe"
CMD ["/opt/gravwell/bin/manager"]
