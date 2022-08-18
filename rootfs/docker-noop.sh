#!/bin/sh

function gracefull_shutdown() {
    exec nginx -s quit
}

# trap SIGINT
trap 'gracefull_shutdown' SIGINT

# noop
while true; do sleep 5; done;
