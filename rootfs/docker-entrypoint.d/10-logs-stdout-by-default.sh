#!/bin/sh
# vim:sw=4:ts=4:et

set -e

entrypoint_log() {
    if [ -z "${NGINX_ENTRYPOINT_QUIET_LOGS:-}" ]; then
        echo "$@"
    fi
}

ME=$(basename $0)
DEFAULT_CONF_FILE="etc/nginx/conf.d/default.conf"

# enable ipv6 on default.conf listen sockets
sed -i -E 's,access_log  /var/log/nginx/access.log  main;,access_log /dev/stdout main;,' /$DEFAULT_CONF_FILE
