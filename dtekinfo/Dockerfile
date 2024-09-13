### Build DTEKInfo
ARG BUILD_FROM
FROM $BUILD_FROM

# Packages
RUN \
  apk add --no-cache \
    python3 \
    py3-pip \
    build-base

# Python
COPY requirements.txt /

RUN pip install  --break-system-packages -r requirements.txt && \
    rm requirements.txt

# Build arguments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_DESCRIPTION
ARG BUILD_NAME
ARG BUILD_REF
ARG BUILD_REPOSITORY
ARG BUILD_VERSION

# Add Label
LABEL \
    io.hass.name="${BUILD_NAME}" \
    io.hass.description="${BUILD_DESCRIPTION}" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Andrew J.Swan <andrewjswan@addons.community>" \
    org.opencontainers.image.title="${BUILD_NAME}" \
    org.opencontainers.image.description="${BUILD_DESCRIPTION}" \
    org.opencontainers.image.vendor="Andrew J.Swan" \
    org.opencontainers.image.authors="Andrew J.Swan <andrewjswan@addons.community>" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.revision=${BUILD_REF} \
    org.opencontainers.image.version=${BUILD_VERSION}

# Copy data for add-on
COPY *.py /
COPY run.sh /
RUN chmod a+x /run.sh

# Start DTEKInfo

CMD ["/run.sh"]
