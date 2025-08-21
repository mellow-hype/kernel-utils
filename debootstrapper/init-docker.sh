#!/usr/bin/env bash
SRCDIR="./src"
TAG="debian-bootstrapper"
DFILE="src/debootstrapper.Dockerfile"

echo "[*] building docker image"
docker build -t "${TAG}" -f "${DFILE}" "${SRCDIR}"

echo "[*] creating symlinks to util scripts in ~/.local/bin"
mkdir -p $HOME/.local/bin
test -f $HOME/.local/bin/debootstrap-dock || ln -s $PWD/util/debootstrapper-dock.sh $HOME/.local/bin/debootstrap-dock
test -f $HOME/.local/bin/debootstrap-rebuild-img || ln -s $PWD/util/rebuild-img.sh $HOME/.local/bin/debootstrap-rebuild-img
