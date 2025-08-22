#!/usr/bin/env bash

if [ "$#" != 2 ]; then
    echo "usage: $0 <linux/path> <out/path>"
    exit 1
fi

LINUXPATH=$1
OUTPATH=$2

if ! [ -d "${OUTPATH}" ]; then
    mkdir -p "${OUTPATH}"
    echo "created: $OUTPATH"
fi

cp "${LINUXPATH}/arch/x86/boot/bzImage" "${OUTPATH}"/.
cp "${LINUXPATH}/vmlinux" "${OUTPATH}"/.
cp "${LINUXPATH}/System.map" "${OUTPATH}"/.
cp "${LINUXPATH}/.config" "${OUTPATH}/defconfig"

echo "[+] moved files to: $OUTPATH"

