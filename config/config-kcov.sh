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
        -d DEBUG_INFO_SPLIT \
        -d DEBUG_INFO_REDUCED \
        -d DEBUG_INFO_DWARF4 \
        -e ARCH_HAS_KCOV \
        -e KCOV \
        -e KCOV_INSTRUMENT_ALL \
        -e KCOV_ENABLE_COMPARISONS \
        --set-val KCOV_IRQ_AREA_SIZE 0x40000 \
        -e STACKTRACE_SUPPORT
fi
