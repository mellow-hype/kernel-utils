#!/usr/bin/env bash

if [ -z $1 ]; then
    echo "usage: $0 [arm|arm64|x86]"
    exit 1
fi

ARCH=$1

case $ARCH in
    arm)
      make ARCH="${ARCH}" CROSS_COMPILE=arm-linux-gnueabihf- "${@:2}"
    ;;

    arm64)
      make ARCH="${ARCH}" CROSS_COMPILE=aarch64-linux-gnueabi- "${@:2}"
    ;;

    x86)
      make $@
      ;;

    *)
      echo "unknown ARCH"
      exit 1
    ;;

esac

