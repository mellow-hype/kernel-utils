#!/usr/bin/env bash

sudo docker run \
    --privileged \
    --platform linux/aarch64 \
    -v "$PWD":/home/builder/out \
    --rm -it debian-bootstrapper-aarch64 "$@"
