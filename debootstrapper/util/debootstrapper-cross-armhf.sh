#!/usr/bin/env bash

sudo docker run \
    --privileged \
    --platform linux/arm \
    -v "$PWD":/home/builder/out \
    --rm -it debian-bootstrapper-armhf -a armv7l "$@"
