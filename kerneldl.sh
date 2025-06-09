#!/usr/bin/env bash

if [ -z $1 ]; then
    echo "usage: kerneldl.sh <version>"
    exit 1
fi

KERNEL_FULL="$1"
KERNEL_SHORT=$(echo "$KERNEL_FULL" | cut -d '.' -f 1)
KERNEL_URL="https://www.kernel.org/pub/linux/kernel/v$KERNEL_SHORT.x/linux-$KERNEL_FULL.tar.gz"

echo "kernel: $KERNEL_FULL"
echo "short: $KERNEL_SHORT.x"

wget "${KERNEL_URL}"

