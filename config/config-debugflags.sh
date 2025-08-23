#!/usr/bin/env bash

set -e

# Handle arguments to get the kernel directory
if [ "$#" -eq 1 ]; then
    KERNEL_DIR="$1"
elif [ "$#" -gt 1 ]; then
    echo "usage: $0 [<kernel-dir>]"
    exit 1
fi

# Execute the script/config script to set the debug flags

CONFIG_SCRIPT="scripts/config"

cd ${KERNEL_DIR:-$(pwd)}
if [ -f "scripts/config" ]; then
    ./"$CONFIG_SCRIPT" \
        -d WERROR \
        -e DEBUG_INFO \
        -d DEBUG_INFO_REDUCED \
        -e DEBUG_KERNEL \
        -e DEBUG_FS \
        -e KALLSYMS \
        -e KALLSYMS_ALL \
        -e KGDB \
        -e KGDB_KDB \
        -e HARDENED_USERCOPY \
        -e HARDENED_USERCOPY_FALLBACK \
        -e RANDOMIZE_BASE \
        -e MAGIC_SYSRQ \
        -e EARLY_PRINTK
fi
