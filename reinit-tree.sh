#!/bin/bash
# script to re-init a build directory after it's been moved since makefile paths will be broken

if [ "$#" -ne 1 ]; then
    echo "usage: $0 <path/to/proj>"
    exit 1
fi

cd $1/buildroot-20*
make O=../build BR2_EXTERNAL=../ext-tree defconfig BR2_DEFCONFIG=../build/.config
cd ../build
mv -f images images.bk
make clean
