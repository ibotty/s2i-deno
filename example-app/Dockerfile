FROM localhost/ubi8-s2i-deno:latest

ARG MAIN
ENV MAIN=${MAIN}
ADD src /opt/app-root/src
CMD /usr/libexec/s2i/run
