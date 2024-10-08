#!/bin/bash
# Create a new buildroot kernel module build

if [ "$#" -ne 2 ]; then
    echo "usage: $0 <name> <buildroot-version>"
    exit 1
fi

NAME=$1
BUILDROOT_VERSION=$2
BUILDROOT_NAME="buildroot-$BUILDROOT_VERSION"
BUILDROOT_PATH="/tmp/$BUILDROOT_NAME"

# buildroot output directory
BROUT="${PWD}/${NAME}/build"
# buildroot external tree directory
EXT_PATH="${PWD}/${NAME}/ext-tree"
# the base dir where actual code is stored
SRCBASE=$NAME/src

# download the buildroot archive now if it's not in /tmp so we can bail early if that fails too
if [ ! -d $BUILDROOT_PATH ]; then
    echo "buildroot path not found"
    wget -c "https://buildroot.org/downloads/buildroot-${BUILDROOT_VERSION}.tar.gz" -O - | tar xz -C /tmp > /dev/null 2>&1
    if [ ! -d $BUILDROOT_PATH ]; then
        echo "failed to download buildroot version '$BUILDROOT_VERSION'"
        exit 1
    fi
fi

### SET UP THE BUILDROOT EXTERNAL TREE STRUCTURE
# create the base dirs for the build
mkdir -p $BROUT
mkdir -p $EXT_PATH

# copy over the template ext-tree directory
cp -a template/ext-tree $NAME/.

# copy in the build script (just runs make in the build dir, assumes everything else has been set)
cp template/build.sh $NAME/.
cp template/qemu-run.sh $NAME/.
chmod +x $NAME/build.sh
chmod +x $NAME/qemu-run.sh

# copy config fragments and the buildroot tree into the project dir
cp configs/*FRAG $NAME/.
cp -a $BUILDROOT_PATH $NAME/$BUILDROOT_NAME
cd $NAME/$BUILDROOT_NAME

# stick to using relative paths so the project dir can be relocated without breaking builds (mostly)
make O=../build BR2_EXTERNAL=../ext-tree ARCH=arm CROSS_COMPILE=aarch64-linux-gnu- qemu_aarch64_virt_defconfig

# move back out to the build dir to update the generated .config with the fragments
cd $BROUT
cat ../defconfig-FRAG >> .config
make olddefconfig

# kick off menuconfig to allow user to enable the building of the custom package
make menuconfig

