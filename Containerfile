ARG PARENT_IMAGE=registry.access.redhat.com/ubi9-minimal
FROM $PARENT_IMAGE

# this has to be specified again after "FROM"
ARG PARENT_IMAGE
ARG DENO_VERSION

EXPOSE 8080

ENV DENO_VERSION=${DENO_VERSION} \
    DEBUG_PORT=5858 \
    SUMMARY="Platform for building and running Deno ${DENO_VERSION} applications" \
    DESCRIPTION="" \
    STI_SCRIPTS_PATH="/usr/libexec/s2i" \
    STI_SCRIPTS_URL="image:///usr/libexec/s2i" \
    APP_ROOT="/opt/app-root" \
    HOME="/opt/app-root/src" \
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
      usage="s2i build . quay.io/ibotty/s2i-deno myapp" \
      parent_image=$PARENT_IMAGE

RUN echo 'default:x:1001:0:Default Application User:/opt/app-root/src:/bin/bash' >> /etc/passwd \
 && chmod 0666 /etc/passwd \
 && chmod 0777 /etc \
 && mkdir -p /opt/app-root/src \
 && chown 1001:0 /opt/app-root/src \
 && microdnf install -y unzip \
 && microdnf clean all

USER 1001
WORKDIR /opt/app-root/src

RUN curl -fsSL https://deno.land/install.sh | sh -s $DENO_VERSION

COPY ./s2i/ $STI_SCRIPTS_PATH

# Set the default CMD to print the usage
CMD ${STI_SCRIPTS_PATH}/usage
