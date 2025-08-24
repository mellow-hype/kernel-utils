
DOCKER_BASE_DIR:=./base
UBUNTU18_BASE_DOCKERFILE=$(DOCKER_BASE_DIR)/ubuntu_18.04-BUILDER-BASE.Dockerfile
UBUNTU20_BASE_DOCKERFILE=$(DOCKER_BASE_DIR)/ubuntu_20.04-BUILDER-BASE.Dockerfile
UBUNTU22_BASE_DOCKERFILE=$(DOCKER_BASE_DIR)/ubuntu_22.04-BUILDER-BASE.Dockerfile
UBUNTU24_BASE_DOCKERFILE=$(DOCKER_BASE_DIR)/ubuntu_24.04-BUILDER-BASE.Dockerfile
DEBIAN11_BASE_DOCKERFILE=$(DOCKER_BASE_DIR)/debian_11-BUILDER-BASE.Dockerfile
DEBIAN12_BASE_DOCKERFILE=$(DOCKER_BASE_DIR)/debian_12-BUILDER-BASE.Dockerfile
BASE_IMAGE_POSTFIX:=kbuild-base
BASES := ubuntu18_base ubuntu20_base ubuntu22_base ubuntu24_base debian11_base debian12_base

all: $(BASES) generic_builders cross_builders
cross: arm_builders arm64_builders cross_builders

# Base images
debian11_base:
	sudo docker build -t debian11-$(BASE_IMAGE_POSTFIX) -f $(DEBIAN11_BASE_DOCKERFILE) $(DOCKER_BASE_DIR)

debian12_base:
	sudo docker build -t debian12-$(BASE_IMAGE_POSTFIX) -f $(DEBIAN12_BASE_DOCKERFILE) $(DOCKER_BASE_DIR)

ubuntu18_base:
	sudo docker build -t ubuntu18-$(BASE_IMAGE_POSTFIX) -f $(UBUNTU18_BASE_DOCKERFILE) $(DOCKER_BASE_DIR)

ubuntu20_base:
	sudo docker build -t ubuntu20-$(BASE_IMAGE_POSTFIX) -f $(UBUNTU20_BASE_DOCKERFILE) $(DOCKER_BASE_DIR)

ubuntu22_base:
	sudo docker build -t ubuntu22-$(BASE_IMAGE_POSTFIX) -f $(UBUNTU22_BASE_DOCKERFILE) $(DOCKER_BASE_DIR)

ubuntu24_base:
	sudo docker build -t ubuntu24-$(BASE_IMAGE_POSTFIX) -f $(UBUNTU24_BASE_DOCKERFILE) $(DOCKER_BASE_DIR)

# cross-architecture build images
arm64_builders: $(BASES)
	sudo docker build -t ubuntu18-kbuild-arm64 -f ubuntu18-arm64-builder.Dockerfile .
	sudo docker build -t ubuntu20-kbuild-arm64 -f ubuntu20-arm64-builder.Dockerfile .

arm_builders: $(BASES)
	sudo docker build -t ubuntu18-kbuild-armhf -f ubuntu18-armhf-builder.Dockerfile .
	sudo docker build -t ubuntu20-kbuild-armhf -f ubuntu20-armhf-builder.Dockerfile .

cross_builders: arm64_builders arm_builders

ubuntu_builders_generic: $(BASES)
	sudo docker build -t ubuntu18-kbuild-generic -f ubuntu18-generic-builder.Dockerfile .
	sudo docker build -t ubuntu20-kbuild-generic -f ubuntu20-generic-builder.Dockerfile .
	sudo docker build -t ubuntu22-kbuild-generic -f ubuntu22-generic-builder.Dockerfile .
	sudo docker build -t ubuntu24-kbuild-generic -f ubuntu24-generic-builder.Dockerfile .

debian_builders_generic: $(BASES)
	sudo docker build -t debian11-kbuild-generic -f debian11-generic-builder.Dockerfile .
	sudo docker build -t debian12-kbuild-generic -f debian12-generic-builder.Dockerfile .

generic_builders: debian_builders_generic ubuntu_builders_generic
    $(info All done building generic kernel builder containers!)