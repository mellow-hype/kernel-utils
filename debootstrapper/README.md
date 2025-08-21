
## debootstrapper utils

NOTE: `init-docker.sh` will symlinks to the `debootstrap-dock` script under `$HOME/.local/bin`.

### setup steps

1. Run `./init-docker.sh` to create the bundled docker images
2. Run `./util/debootstrap-dock.sh` to create the rootfs image using the containers

### other utils

- `./util/rebuild-img.sh` will rebuild the filesystem image from the source files produced from a
    previous build to allow for editing the files directly and re-"baking" the image
- `qemu-run.sh` quick wrapper script around QEMU to run a VM with a kernel image and rootfs
