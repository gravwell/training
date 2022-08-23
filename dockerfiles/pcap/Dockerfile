ARG VER=latest
FROM gravwell/network_capture:${VER}
MAINTAINER training@gravwell.io
ARG CONFIG=network_capture.conf
COPY $CONFIG /opt/gravwell/etc/$CONFIG

ENV GRAVWELL_INGEST_AUTH=IngestSecrets
ENV GRAVWELL_INGEST_SECRET=IngestSecrets
ENV GRAVWELL_CONTROL_AUTH=ControlSecrets
ENV GRAVWELL_SEARCHAGENT_AUTH=SearchAgentSecrets
CMD ["/opt/gravwell/bin/gravwell_network_capture"]
