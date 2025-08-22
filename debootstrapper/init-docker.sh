#!/usr/bin/env bash
SRCDIR="./src"
TAG="debian-bootstrapper"
TAG_CROSS="debian-bootstrapper-cross"
DFILE="$SRCDIR/debootstrapper.Dockerfile"
DFILE_CROSS="$SRCDIR/debootstrapper-cross.Dockerfile"

echo "[*] building docker image for standard version"
sudo docker build -t "${TAG}" -f "${DFILE}" "${SRCDIR}"

echo "[*] building docker image for cross-compile version"
sudo docker build -t "${TAG_CROSS}" -f "${DFILE_CROSS}" "${SRCDIR}"

echo "[*] creating symlinks to util scripts in ~/.local/bin"
mkdir -p $HOME/.local/bin
test -f $HOME/.local/bin/debootstrap-dock || ln -s $PWD/util/debootstrapper-dock.sh $HOME/.local/bin/debootstrap-dock
test -f $HOME/.local/bin/debootstrap-cross-dock || ln -s $PWD/util/debootstrapper-cross-dock.sh $HOME/.local/bin/debootstrap-cross-dock
test -f $HOME/.local/bin/debootstrap-rebuild-img || ln -s $PWD/util/rebuild-img.sh $HOME/.local/bin/debootstrap-rebuild-img
