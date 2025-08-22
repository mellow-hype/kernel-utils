#!/usr/bin/env bash

sudo docker run --privileged -v "$PWD":/home/builder/out --rm -it debian-bootstrapper-cross "$@"
