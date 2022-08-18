#!/bin/sh

function gracefull_shutdown() {
    # exec /run/s6/basedir/bin/halt
    exec nginx -s quit
}

# trap SIGINT
trap 'gracefull_shutdown' SIGTERM SIGINT

# noop
while true; do sleep 5; done;
