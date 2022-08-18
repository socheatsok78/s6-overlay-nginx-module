# s6-overlay-nginx-module [![release](https://github.com/socheatsok78/s6-overlay-nginx-module/actions/workflows/release.yml/badge.svg)](https://github.com/socheatsok78/s6-overlay-nginx-module/actions/workflows/release.yml)
nginx module for s6 overlay v3



## Quickstart

Build the following Dockerfile and try it out:

```Dockerfile
FROM nginx:alpine

ARG S6_OVERLAY_VERSION=3.1.1.2
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-noarch.tar.xz /tmp
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-noarch.tar.xz.sha256 /tmp
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-x86_64.tar.xz /tmp
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-x86_64.tar.xz.sha256 /tmp
RUN cd /tmp && sha256sum -c *.sha256 && \
    tar -C / -Jxpf /tmp/s6-overlay-noarch.tar.xz && \
    tar -C / -Jxpf /tmp/s6-overlay-x86_64.tar.xz && \
    rm -rf /tmp/*.tar.xz

ARG S6_NGINX_MODULE_VERSION=0.1.2
ADD https://github.com/socheatsok78/s6-overlay-nginx-module/releases/download/v${S6_NGINX_MODULE_VERSION}/s6-overlay-nginx-module.tar.zx /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-nginx-module.tar.zx && \
    rm -rf /tmp/*.tar.xz

STOPSIGNAL SIGTERM

ENTRYPOINT ["/init"]
CMD [ "/docker-noop.sh" ]
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

## Notice

This module is heavily inspired by the [just-containers/s6-overlay](https://github.com/just-containers/s6-overlay) design.

## License

Licensed under [Apache-2.0 license](LICENSE)
