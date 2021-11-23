FROM ubuntu:latest
MAINTAINER training@gravwell.io

COPY network_capture.sh /tmp/network_capture.sh
COPY network_capture.conf /tmp/network_capture.conf
COPY zoneinfo /usr/share/zoneinfo

RUN /bin/bash /tmp/network_capture.sh --no-questions --no-start --no-crash-report --use-config /tmp/network_capture.conf
RUN rm /tmp/network_capture.sh /tmp/network_capture.conf
ENV GRAVWELL_INGEST_AUTH=IngestSecrets
ENV GRAVWELL_INGEST_SECRET=IngestSecrets
ENV GRAVWELL_CONTROL_AUTH=ControlSecrets
ENV GRAVWELL_SEARCHAGENT_AUTH=SearchAgentSecrets
CMD ["/opt/gravwell/bin/gravwell_network_capture"]
