FROM localhost/nodeshift/ubi8-s2i-deno:latest

ARG MAIN
ARG PERMISSIONS
ARG TSCONFIG
ENV MAIN=${MAIN}
ENV PERMISSIONS=${PERMISSIONS}
ENV TSCONFIG=${TSCONFIG}
ADD src /opt/app-root/src
ADD tsconfig.json /opt/app-root/src
RUN /usr/libexec/s2i/assemble
CMD /usr/libexec/s2i/run
