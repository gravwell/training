FROM busybox:latest
MAINTAINER training@gravwell.io

COPY simple_relay.sh /tmp/simple_relay.sh
COPY file_follow.sh /tmp/file_follow.sh
COPY netflow.sh /tmp/netflow.sh
COPY network_capture.sh /tmp/network_capture.sh
COPY federator.sh /tmp/federator.sh
COPY jsonGenerator /opt/gravwell/bin/
COPY csvGenerator /opt/gravwell/bin
COPY reimport /opt/gravwell/bin

COPY simple_relay.conf /tmp/simple_relay.conf
COPY file_follow.conf /tmp/file_follow.conf
COPY federator.conf /tmp/federator.conf
COPY network_capture.conf /tmp/network_capture.conf

COPY zoneinfo /usr/share/zoneinfo

RUN /bin/sh /tmp/simple_relay.sh --no-questions --no-start --no-crash-report --use-config /tmp/simple_relay.conf
RUN /bin/sh /tmp/file_follow.sh --no-questions --no-start --no-crash-report --use-config /tmp/file_follow.conf
RUN /bin/sh /tmp/netflow.sh --no-questions --no-start --no-crash-report
RUN /bin/sh /tmp/network_capture.sh --no-questions --no-start --no-crash-report --use-config /tmp/network_capture.conf
RUN /bin/sh /tmp/federator.sh --no-questions --no-start --no-crash-report --use-config /tmp/federator.conf
ENV GRAVWELL_INGEST_AUTH=IngestSecrets
ENV GRAVWELL_INGEST_SECRET=IngestSecrets
ENV GRAVWELL_CONTROL_AUTH=ControlSecrets
ENV GRAVWELL_SEARCHAGENT_AUTH=SearchAgentSecrets
CMD ["/bin/sh"]
