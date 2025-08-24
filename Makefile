
BIN_DIR := $(HOME)/.local/bin

# Install symlinks to the build utility scripts in $PATH
install_build_utils:
	ln -sf build-utils/kerneldl.sh $(BIN_DIR)/kerneldl
	ln -sf build-utils/export-kernel-img.sh $(BIN_DIR)/export-kernel-img
	ln -sf build-utils/export-kernel-img-arm.sh $(BIN_DIR)/export-kernel-img-arm

# Initialize the debootstrap containers and install the helper scripts
init_debootstrap:
	make -C debootstrapper init_docker
	make -C debootstrapper install

init_docker_kbuilders:
	make -C docker all