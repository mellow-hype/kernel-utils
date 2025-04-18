#!/usr/bin/env bash

#set -eux

SEEK=4096

# Display help function
display_help() {
    echo "Usage: $0 [option...] " >&2
    echo
    echo "   -d, --distdir              Set on which existing debian dir to operate"
    echo "   -s, --seek                 Image size (MB) for new image, default $SEEK"
    echo "   -h, --help                 Display help message"
    echo
}

while true; do
    if [ $# -eq 0 ];then
	echo $#
	break
    fi
    case "$1" in
        -h | --help)
            display_help
            exit 0
            ;;
        -d | --dir)
	    DIR=$2
            shift 2
            ;;
        -s | --seek)
	    SEEK=$(($2 - 1))
            shift 2
            ;;
        -*)
            echo "Error: Unknown option: $1" >&2
            exit 1
            ;;
        *)  # No more options
            break
            ;;
    esac
done

if [ -z $DIR ]; then
    display_help
    exit 1
fi

if ! [ -d $DIR ]; then
    echo "$DIR not found"
    exit 1
fi

DIR=$(basename $DIR)
rm -f ${DIR}.img

# Build the disk image
dd if=/dev/zero of=$DIR.img bs=1M seek=$SEEK count=1
sudo mkfs.ext4 -F $DIR.img
sudo mkdir -p /mnt/$DIR
sudo mount -o loop $DIR.img /mnt/$DIR
sudo cp -a $DIR/. /mnt/$DIR/.
sudo umount /mnt/$DIR
