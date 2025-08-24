#!/usr/bin/env bash
#set -eux

SEEK=4096
ROOTFS_IMG=""
PRESERVE=0

# Display help function
display_help() {
    echo "Usage: $0 [option...] <rootfs.img>" >&2
    echo
    echo "   -s, --seek                 Amount to increment size by (MB), default: 4096"
    echo "   -p, --preveserve           Preserve original image file"
    echo "   -h, --help                 Display help message"
    echo
}

while true; do
    if [ $# -eq 0 ];then
    display_help
    exit 1
    break
    fi
    case "$1" in
        -h | --help)
            display_help
            exit 0
            ;;
        -s | --seek)
        SEEK=$(($2 - 1))
            shift 2
            ;;
        -p | --preserve)
            PRESERVE=1
            shift 1
            ;;
        -*)
            echo "Error: Unknown option: $1" >&2
            exit 1
            ;;
        *)  # No more options
            ROOTFS_IMG=$1
            break
            ;;
    esac
done

if [ -z $ROOTFS_IMG ]; then
    display_help
    exit 1
fi

if ! [ -f $ROOTFS_IMG ]; then
    echo "$ROOTFS_IMG not found"
    exit 1
fi

# preserve the original image file
if [ $PRESERVE -eq 1 ]; then
    cp $ROOTFS_IMG ${ROOTFS_IMG}.bak
    echo "Preserved original image file as ${ROOTFS_IMG}.bak"
fi

# expand the image file by SEEK MB
echo "Expanding $ROOTFS_IMG by $((SEEK + 1)) MB"
dd if=/dev/zero of=${ROOTFS_IMG} oflag=append bs=1M count=$SEEK conv=notrunc

# mount the image to a loop device
ROOTFS_LO=$(sudo losetup -f --show $ROOTFS_IMG)

# check and resize the partition
sudo e2fsck -f $ROOTFS_LO
sudo resize2fs $ROOTFS_LO

# unmount the loop device
sudo losetup -d $ROOTFS_LO

echo "Done!"