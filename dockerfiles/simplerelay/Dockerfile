ARG VER=latest
FROM gravwell/simple_relay:${VER}
MAINTAINER training@gravwell.io
COPY simple_relay.conf /opt/gravwell/etc/

ENV GRAVWELL_INGEST_AUTH=IngestSecrets
ENV GRAVWELL_INGEST_SECRET=IngestSecrets
ENV GRAVWELL_CONTROL_AUTH=ControlSecrets
ENV GRAVWELL_SEARCHAGENT_AUTH=SearchAgentSecrets
CMD ["/opt/gravwell/bin/gravwell_simple_relay"]
