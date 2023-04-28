#!/bin/bash

IMAGE_DIR="build/images"

qemu-system-x86_64                                                                      \
        -m 512M                                                                         \
        -M pc                                                                           \
        -cpu qemu64                                                                     \
        -kernel ${IMAGE_DIR}/bzImage                                                    \
        -drive file="${IMAGE_DIR}"/rootfs.ext2,if=virtio,format=raw                     \
        -append "rw nokaslr panic=1 root=/dev/vda console=tty1 console=ttyS0"           \
        -no-reboot                                                                      \
        -nographic                                                                      \
        -serial mon:stdio                                                               \
        -s                                                                              \
        -net nic,model=virtio -net user
