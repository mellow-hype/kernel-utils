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

cp -a "${LINUXPATH}/arch/arm/boot/dts" "${OUTPATH}"/.
cp "${LINUXPATH}/arch/arm/boot/zImage" "${OUTPATH}"/.
cp "${LINUXPATH}/vmlinux" "${OUTPATH}"/.
cp "${LINUXPATH}/System.map" "${OUTPATH}"/.

if [ -e "${LINUXPATH}/.config" ]; then
    cp "${LINUXPATH}/.config" "${OUTPATH}/defconfig"
fi
if [ -e "${LINUXPATH}/defconfig" ]; then
    cp "${LINUXPATH}/defconfig" "${OUTPATH}/defconfig"
fi

echo "[+] moved files to: $OUTPATH"

