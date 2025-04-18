#!/usr/bin/env bash

if [ "$#" != 2 ]; then
    echo "$0 <kernel> <rootfs.img>"
    exit 1
fi

KERNEL="$1"
ROOTFS="$2"

qemu-system-x86_64 \
        -m 2G \
        -smp 2 \
        -kernel "$KERNEL" \
        -append "console=ttyS0 root=/dev/sda earlyprintk=serial net.ifnames=0 nokaslr" \
        -drive file="$ROOTFS",format=raw \
        -net user,host=10.0.2.10,hostfwd=tcp:127.0.0.1:10021-:22 \
        -net nic,model=e1000 \
        -enable-kvm \
        -nographic
