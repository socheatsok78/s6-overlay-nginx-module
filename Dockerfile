FROM nginx:alpine

ARG S6_OVERLAY_VERSION=3.1.1.2
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-noarch.tar.xz /tmp
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-noarch.tar.xz.sha256 /tmp
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-x86_64.tar.xz /tmp
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-x86_64.tar.xz.sha256 /tmp
RUN cd /tmp && sha256sum -c *.sha256 && \
    tar -C / -Jxpf /tmp/s6-overlay-noarch.tar.xz && \
    tar -C / -Jxpf /tmp/s6-overlay-x86_64.tar.xz && \
    rm -rf /tmp/*.tar*

ARG S6_NGINX_MODULE_VERSION=1.0.0
ADD https://github.com/socheatsok78/s6-overlay-nginx-module/releases/download/v${S6_NGINX_MODULE_VERSION}/s6-overlay-nginx-module.tar.zx /tmp
ADD https://github.com/socheatsok78/s6-overlay-nginx-module/releases/download/v${S6_NGINX_MODULE_VERSION}/s6-overlay-nginx-module.tar.zx.sha256 /tmp
RUN cd /tmp && sha256sum -c *.sha256 && \
    tar -C / -Jxpf /tmp/s6-overlay-nginx-module.tar.zx && \
    rm -rf /tmp/*.tar*

STOPSIGNAL SIGTERM

ENTRYPOINT ["/init"]
CMD [ "/docker-noop.sh" ]
