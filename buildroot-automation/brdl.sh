#!/bin/bash
VERS=$1
if [ $# -ne 1 ]; then
    echo "usage: dlbr.sh <version>"
    echo -e "example: \n\t./dlbr.sh 2022.08"
    exit 1
fi

wget -c "https://buildroot.org/downloads/buildroot-${VERS}.tar.gz" -O - | tar xz
