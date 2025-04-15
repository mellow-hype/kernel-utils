#!/usr/bin/env bash

docker run --privileged -v "$PWD":/home/builder/out --rm -it debian-bootstrapper "$@"
