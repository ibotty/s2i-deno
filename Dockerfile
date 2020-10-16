FROM registry.access.redhat.com/ubi8/s2i-core

EXPOSE 8080

ARG DENO_VERSION

ENV DENO_VERSION=${DENO_VERSION} \
    DEBUG_PORT=5858 \
    SUMMARY="Platform for building and running Deno ${DENO_VERSION} applications" \
    DESCRIPTION="TBD"

LABEL io.k8s.description="$DESCRIPTION" \
      io.k8s.display-name="Deno $DENO_VERSION" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="builder,deno" \
      com.redhat.deployments-dir="/opt/app-root/src" \
      com.redhat.dev-mode="DEV_MODE:false" \
      com.redhat.dev-mode.port="DEBUG_PORT:5858" \
      maintainer="Daniel Bevenius <daniel.bevenius@gmail.com>" \
      summary="$SUMMARY" \
      description="$DESCRIPTION" \
      version="$DENO_VERSION" \
      name="nodeshift/ubi8-s2i-deno" \
      usage="s2i build . nodeshift/ubi8-s2i-deno myapp"

COPY ./s2i/ $STI_SCRIPTS_PATH
COPY ./contrib/ /opt/app-root
RUN /opt/app-root/etc/install_deno.sh
ENV PATH="/opt/app-root/src/.deno/bin:${PATH}"

USER 1001

# Set the default CMD to print the usage
CMD ${STI_SCRIPTS_PATH}/usage
