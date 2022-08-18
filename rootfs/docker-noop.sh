#!/bin/sh

# trap SIGINT
trap '/run/s6/basedir/bin/halt' SIGINT

# noop
while true; do sleep 30; done;
