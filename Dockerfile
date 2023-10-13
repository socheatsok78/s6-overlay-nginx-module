FROM nginx:alpine

# https://github.com/socheatsok78/s6-overlay-installer
ARG S6_OVERLAY_VERSION=v3.1.5.0\
    S6_OVERLAY_INSTALLER=main/s6-overlay-installer-minimal.sh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/socheatsok78/s6-overlay-installer/${S6_OVERLAY_INSTALLER})"

ARG S6_VERBOSITY=0
ENV S6_VERBOSITY=${S6_VERBOSITY} \
    S6_BEHAVIOUR_IF_STAGE2_FAILS=2

ENTRYPOINT [ "/init" ]
CMD [ "sleep", "infinity" ]

# https://github.com/socheatsok78/s6-overlay-nginx-module
ARG S6_NGINX_MODULE_VERSION=1.0.0
ADD https://github.com/socheatsok78/s6-overlay-nginx-module/releases/download/v${S6_NGINX_MODULE_VERSION}/s6-overlay-nginx-module.tar.zx /tmp
ADD https://github.com/socheatsok78/s6-overlay-nginx-module/releases/download/v${S6_NGINX_MODULE_VERSION}/s6-overlay-nginx-module.tar.zx.sha256 /tmp
RUN cd /tmp && sha256sum -c *.sha256 && \
    tar -C / -Jxpf /tmp/s6-overlay-nginx-module.tar.zx && \
    rm -rf /tmp/*.tar*
