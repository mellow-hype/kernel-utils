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
        -e DEBUG_INFO \
        -d DEBUG_INFO_REDUCED \
        -e DEBUG_KERNEL \
        -e DEBUG_MISC \
        -e DEBUG_FS \
        -e KALLSYMS \
        -e KALLSYMS_ALL \
        -e KASAN \
        -e KASAN_INLINE \
        -e ARCH_HAS_KCOV \
        -e KCOV \
        -e KCOV_INSTRUMENT_ALL \
        -e STACKTRACE_SUPPORT \
        -e KGDB \
        -e BLOCK \
        -e KGDB_KDB \
        -e STACKPROTECTOR \
        -e HARDENED_USERCOPY \
        -e HARDENED_USERCOPY_FALLBACK \
        -d RANDOMIZE_BASE \
        -e EARLY_PRINTK \
        -d SLAB_FREELIST_RANDOM \
        -d SLAB_FREELIST_HARDENED \
        -e USERFAULTFD \
        -e SLAB \
        -e DEBUG_SLAB \
        -e NETFILTER \
        -e NETFILTER_XTABLES \
        -e NETFILTER_INGRESS \
        -e NETFILTER_NETLINK \
        -e NETFILTER_NETLINK_LOG \
        -e NET \
        -e MAGIC_SYSRQ
fi