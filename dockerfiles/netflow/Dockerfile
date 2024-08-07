ARG VER=latest
FROM gravwell/netflow_capture:${VER}
MAINTAINER training@gravwell.io

ENV GRAVWELL_INGEST_AUTH=IngestSecrets
ENV GRAVWELL_INGEST_SECRET=IngestSecrets
ENV GRAVWELL_CONTROL_AUTH=ControlSecrets
ENV GRAVWELL_SEARCHAGENT_AUTH=SearchAgentSecrets
CMD ["/opt/gravwell/bin/gravwell_netflow_capture"]
