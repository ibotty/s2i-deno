FROM localhost/nodeshift/ubi8-s2i-deno:latest

ARG MAIN
ARG PERMISSIONS
ENV MAIN=${MAIN}
ENV PERMISSIONS=${PERMISSIONS}
ADD src /opt/app-root/src
RUN /usr/libexec/s2i/assemble
CMD /usr/libexec/s2i/run
