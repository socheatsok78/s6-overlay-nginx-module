# s6-overlay-nginx-module [![release](https://github.com/socheatsok78/s6-overlay-nginx-module/actions/workflows/release.yml/badge.svg)](https://github.com/socheatsok78/s6-overlay-nginx-module/actions/workflows/release.yml)

Add support for running `nginx` as a service managed by `s6-overlay` with respect to the official `docker-entrypoint.d` directory for initialization.

## Quickstart

Build the following Dockerfile and try it out:

```Dockerfile
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

```
```
docker-host $ docker build -t demo .
docker-host $ docker run --name s6demo -d -p 80:80 demo
docker-host $ docker top s6demo acxf
PID                 TTY                 STAT                TIME                COMMAND
13201               ?                   Ss                  0:00                \_ s6-svscan
13237               ?                   Ss+                 0:00                \_ rc.init
13323               ?                   S+                  0:00                | \_ docker-noop.sh
13324               ?                   S+                  0:00                | \_ sleep
13238               ?                   S                   0:00                \_ s6-supervise
13239               ?                   Ss                  0:00                | \_ s6-linux-init-s
13247               ?                   S                   0:00                \_ s6-supervise
13304               ?                   Ss                  0:00                | \_ nginx
13314               ?                   S                   0:00                | \_ nginx
13315               ?                   S                   0:00                | \_ nginx
13316               ?                   S                   0:00                | \_ nginx
13317               ?                   S                   0:00                | \_ nginx
13248               ?                   S                   0:00                \_ s6-supervise
13255               ?                   Ss                  0:00                | \_ s6-ipcserverd
13249               ?                   S                   0:00                \_ s6-supervise

docker-host $ curl --head http://127.0.0.1:8080
HTTP/1.1 200 OK
Server: nginx/1.23.1
Date: Thu, 18 Aug 2022 11:33:12 GMT
Content-Type: text/html
Content-Length: 615
Last-Modified: Tue, 19 Jul 2022 15:23:19 GMT
Connection: keep-alive
ETag: "62d6cc67-267"
Accept-Ranges: bytes
```

## Loggings

You might want to redirect `nginx` loggings to `/dev/stdout` for `logutil-service` to capture them.

```sh
# By default nginx container already symlinked the log files to /dev/stdout
# So you can just add the following lines to your nginx.conf or server block.

access_log  /var/log/nginx/access.log  main;
error_log   /var/log/nginx/error.log   warn;
```

Or alternatively, you can redirect them to `/dev/stdout` directly.

```sh
access_log  /dev/stdout  main;
error_log   /dev/stdout  warn;
```

## Notice

This module is heavily inspired by the [just-containers/s6-overlay](https://github.com/just-containers/s6-overlay) design.

## License

Licensed under [Apache-2.0 license](LICENSE)
