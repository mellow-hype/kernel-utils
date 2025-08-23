#!/usr/bin/env bash

set -e
CONFIG_SCRIPT="scripts/config"

# Handle arguments to get the kernel directory
if [ "$#" -eq 1 ]; then
    KERNEL_DIR="$1"
elif [ "$#" -gt 1 ]; then
    echo "usage: $0 [<kernel-dir>]"
    exit 1
fi

cd ${KERNEL_DIR:-$(pwd)}
if [ -f "scripts/config" ]; then
    ./"$CONFIG_SCRIPT" \
        -d WERROR \
        -e DEBUG_INFO \
        -d DEBUG_INFO_SPLIT \
        -d DEBUG_INFO_REDUCED \
        -d DEBUG_INFO_DWARF4 \
        -e DEBUG_KERNEL \
        -e GDB_SCRIPTS \
        -e BLOCK \
        -e EXT4_FS \
        -e EXT4_FS_POSIX_ACL \
        -e EXT2_FS \
        -e EXT2_FS_XATTR \
        -e EXT2_FS_SECURITY \
        -e EXT2_FS_POSIX_ACL \
        -e KALLSYMS \
        -e KALLSYMS_ALL \
        -e HARDENED_USERCOPY \
        -e HARDENED_USERCOPY_FALLBACK \
        -e RANDOMIZE_BASE \
        -e MAGIC_SYSRQ \
        -e EARLY_PRINTK \
        -d SLAB_FREELIST_RANDOM \
        -d SLAB_FREELIST_HARDENED
fi
