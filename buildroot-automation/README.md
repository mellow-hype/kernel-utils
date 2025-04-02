# kernel dev workflow automation and tools

this repo contains a set of scripts i've created to simplify and somewhat automate the setup for a kernel module development workflow and for building kernel images in general using buildroot.

## repo structure

- `configs/`: the config fragments for the defconfig and linux kernel config
- `docker/`: dockerfiles for portable builder images
- `template/`: static files, scripts, and template files for easy generation of new projects

## building kernel images - init-kernel.sh

a script to automate the process of setting up a new build directory for building a kernel image and rootfs only has been created. it will create a named directory containing a buildroot tree and will initialize the build using the named dir as the buildroot output directory.
along with this initialization, it appends a custom defconfig fragment to the default `qemu_x86_64_defconfig` to some common settings that will make the VM a bit more usable (adding some packages, custom kernel config fragment to enable debug, etc).

script summary:
* create a named directory to store everything
* copy in an existing buildroot tree into the directory
* add some baseline configuration settings to the defconfig and kernel configs for common settings
* download a buildroot tree automatically if it isn't already downloaded

Example:

```
./init-kernel.sh linux-5.15_build 2022.08
cd linux-5.15_build
make -j8 all
```

## kernel module dev - init-kmod.sh

at a high level, the workflow for kernel module development includes:
* set up a buildroot external tree to contain the package definition for the kernel module
* set up the necessary files (Makefile, buildroot tree files) to have buildroot automatically build the kernel module package and make it availavle in the rootfs
* set up a buildroot build using the external tree and prepare for build: create the defconfig, enable the kernel module package, 
* run the buildroot build to create the kernel image, rootfs, and kernel module

a script has been created to automate the creation of most of the necessary files, including downloading the desired buildroot version into the project directory to be used for the build.

Example:

```
./init-kmod.sh newpkg 2022.08
<enable new package in 'make menuconfig'>
cd newpkg
./build.sh
```

