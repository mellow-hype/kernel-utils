#!/usr/bin/env bash

if [ "$#" != 2 ]; then
    echo "$0 <kernel> <rootfs.img>"
    exit 1
fi

if [ ! -z ${QEMU_SSH_PORT} ]; then
    echo "[*] Using port ${QEMU_SSH_PORT} for SSH forwarding to localhost"
else
    echo "[*] Using default port 10021 for SSH forwarding to localhost"
    QEMU_SSH_PORT="10021"
fi

KERNEL="$1"
ROOTFS="$2"

qemu-system-x86_64 \
        -m 2G \
        -smp 2 \
        -kernel "$KERNEL" \
        -append "console=ttyS0 root=/dev/sda earlyprintk=serial panic_on_oops=0 net.ifnames=0 nokaslr" \
        -drive file="$ROOTFS",format=raw \
        -net user,host=10.0.2.10,hostfwd=tcp:127.0.0.1:"$QEMU_SSH_PORT"-:22 \
        -net nic,model=e1000 \
        -enable-kvm \
        -nographic
