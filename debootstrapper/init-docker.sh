#!/usr/bin/env bash
SRCDIR="./src"
TAG="debian-bootstrapper"
DFILE="$SRCDIR/debootstrapper.Dockerfile"
DFILE_CROSS_ARM32="$SRCDIR/debootstrapper-cross-armhf.Dockerfile"
DFILE_CROSS_ARM64="$SRCDIR/debootstrapper-cross-aarch64.Dockerfile"

echo "[*] building docker image for standard version"
sudo docker build -t "${TAG}" -f "${DFILE}" "${SRCDIR}"

echo "[*] building docker image for cross-compile version: armhf"
sudo docker build -t "${TAG}-armhf" --platform linux/arm -f "${DFILE_CROSS_ARM32}" "${SRCDIR}"

echo "[*] building docker image for cross-compile version: aarch64"
sudo docker build -t "${TAG}-aarch64" --platform linux/aarch64 -f "${DFILE_CROSS_ARM64}" "${SRCDIR}"

echo "[*] creating symlinks to util scripts in ~/.local/bin"
mkdir -p $HOME/.local/bin
test -f $HOME/.local/bin/debootstrap-dock || ln -s $PWD/util/debootstrapper-dock.sh $HOME/.local/bin/debootstrap-dock
test -f $HOME/.local/bin/debootstrap-cross-armhf || ln -s $PWD/util/debootstrapper-cross-armhf.sh $HOME/.local/bin/debootstrap-cross-armhf
test -f $HOME/.local/bin/debootstrap-cross-aarch64 || ln -s $PWD/util/debootstrapper-cross-aarch64.sh $HOME/.local/bin/debootstrap-cross-aarch64
test -f $HOME/.local/bin/debootstrap-rebuild-img || ln -s $PWD/util/rebuild-img.sh $HOME/.local/bin/debootstrap-rebuild-img
