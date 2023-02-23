FROM registry.access.redhat.com/ubi9/s2i-base

EXPOSE 8080

ARG DENO_VERSION

ENV DENO_VERSION=${DENO_VERSION} \
    DEBUG_PORT=5858 \
    SUMMARY="Platform for building and running Deno ${DENO_VERSION} applications" \
    DESCRIPTION="" \
    PATH="/opt/app-root/src/.deno/bin:${PATH}"

LABEL io.k8s.description="$DESCRIPTION" \
      io.k8s.display-name="Deno $DENO_VERSION" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="builder,deno" \
      com.redhat.deployments-dir="/opt/app-root/src" \
      com.redhat.dev-mode="DEV_MODE:false" \
      com.redhat.dev-mode.port="DEBUG_PORT:5858" \
      maintainer="Tobias Florek <tob@butter.sh>" \
      summary="$SUMMARY" \
      description="$DESCRIPTION" \
      version="$DENO_VERSION" \
      name="quay.io/ibotty/s2i-deno" \
      usage="s2i build . quay.io/ibotty/s2i-deno myapp"

RUN curl -fsSL https://deno.land/install.sh | sh -s $DENO_VERSION
COPY ./s2i/ $STI_SCRIPTS_PATH

USER 1001

# Set the default CMD to print the usage
CMD ${STI_SCRIPTS_PATH}/usage
