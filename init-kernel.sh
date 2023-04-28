#!/bin/bash
# Create a new buildroot kernel build

if [ "$#" -ne 2 ]; then
    echo "usage: $0 <name> <buildroot-version>"
    exit 1
fi

NAME=$1
BUILDROOT_VERSION=$2
BUILDROOT_NAME="buildroot-$BUILDROOT_VERSION"
BUILDROOT_PATH="/tmp/$BUILDROOT_NAME"


if [ -z "${BR2_EXTERNAL+x}" ]; then
    BREXT=""
    echo "no BR2_EXTERNAL env var found, not setting this for the buildroot init"
else
    BREXT="BR2_EXTERNAL=$BR2_EXTERNAL"
fi

# download the buildroot archive now if it's not in /tmp so we can bail early if that fails too
if [ ! -d $BUILDROOT_PATH ]; then
    echo "buildroot path not found"
    wget -c "https://buildroot.org/downloads/buildroot-${BUILDROOT_VERSION}.tar.gz" -O - | tar xz -C /tmp > /dev/null 2>&1
    if [ ! -d $BUILDROOT_PATH ]; then
        echo "failed to download buildroot version '$BUILDROOT_VERSION'"
        exit 1
    fi
fi


mkdir -p ./builds
ODIR=./builds/$NAME
mkdir -p $ODIR/build
cp configs/*FRAG $ODIR/.
cp -a $BUILDROOT_PATH $ODIR/.
cp template/build.sh $ODIR/.
cp template/qemu-run.sh $ODIR/.

cd $ODIR/$BUILDROOT_NAME
make O=../build "$BREXT" qemu_x86_64_defconfig

cd ../build
cat ../defconfig-FRAG >> .config
make olddefconfig
