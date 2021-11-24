FROM gravwell:perms
MAINTAINER training@gravwell.io
USER root
RUN chown root:root /opt/gravwell/storage
RUN chown gravwell:gravwell -R /opt/gravwell/bin
USER 1000:1000

ENV GRAVWELL_INGEST_AUTH=IngestSecrets
ENV GRAVWELL_INGEST_SECRET=IngestSecrets
ENV GRAVWELL_CONTROL_AUTH=ControlSecrets
ENV GRAVWELL_SEARCHAGENT_AUTH=SearchAgentSecrets
ENV GRAVWELL_PIPE_TARGETS="/opt/gravwell/comms/pipe"
CMD ["/opt/gravwell/bin/manager"]
