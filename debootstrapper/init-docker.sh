#!/usr/bin/env bash

TAG="debian-bootstrapper"

mkdir -p ./.dockerctx
docker build -t "${TAG}" -f debootstrapper-v2.Dockerfile .
