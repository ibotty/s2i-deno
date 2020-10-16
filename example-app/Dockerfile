FROM localhost/ubi8-s2i-deno:latest

ARG MAIN
ENV MAIN=${MAIN}
ADD src /opt/app-root/src
RUN /usr/libexec/s2i/assemble
CMD /usr/libexec/s2i/run
