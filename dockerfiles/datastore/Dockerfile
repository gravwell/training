ARG version
FROM gravwell/datastore:${version}
MAINTAINER training@gravwell.io
ARG MANAGE_CONF=manager.cfg

COPY $MANAGE_CONF /opt/gravwell/etc/
ENV GRAVWELL_INGEST_AUTH=IngestSecrets
ENV GRAVWELL_INGEST_SECRET=IngestSecrets
ENV GRAVWELL_CONTROL_AUTH=ControlSecrets
ENV GRAVWELL_SEARCHAGENT_AUTH=SearchAgentSecrets
ENV GRAVWELL_PIPE_TARGETS="/opt/gravwell/comms/pipe"
CMD ["/opt/gravwell/bin/manager"]
