FROM busybox:latest
MAINTAINER training@gravwell.io

COPY gravwellGenerator /opt/gravwell/bin/
COPY reimport /opt/gravwell/bin

COPY zoneinfo /usr/share/zoneinfo

ENV GRAVWELL_INGEST_AUTH=IngestSecrets
ENV GRAVWELL_INGEST_SECRET=IngestSecrets
ENV GRAVWELL_CONTROL_AUTH=ControlSecrets
ENV GRAVWELL_SEARCHAGENT_AUTH=SearchAgentSecrets
CMD ["/bin/sh"]
