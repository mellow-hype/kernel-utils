#!/usr/bin/env bash

TAG="debian-boostrapper"

mkdir -p ./.dockerctx
docker build -t "${TAG}" -f debian-bullseye-debootstrap.Dockerfile .dockerctx/.
