
DOCKER_BASE_DIR:=./base
UBUNTU18_BASE_DOCKERFILE=$(DOCKER_BASE_DIR)/ubuntu_18.04-BUILDER-BASE.Dockerfile
UBUNTU20_BASE_DOCKERFILE=$(DOCKER_BASE_DIR)/ubuntu_20.04-BUILDER-BASE.Dockerfile
UBUNTU22_BASE_DOCKERFILE=$(DOCKER_BASE_DIR)/ubuntu_22.04-BUILDER-BASE.Dockerfile
UBUNTU24_BASE_DOCKERFILE=$(DOCKER_BASE_DIR)/ubuntu_24.04-BUILDER-BASE.Dockerfile
BASE_IMAGE_POSTFIX:=kbuild-base
BASES := ubuntu18_base ubuntu20_base ubuntu22_base ubuntu24_base

all: $(BASES) generic_builders cross_builders

ubuntu18_base:
	sudo docker build -t ubuntu18-$(BASE_IMAGE_POSTFIX) -f $(UBUNTU18_BASE_DOCKERFILE) $(DOCKER_BASE_DIR)

ubuntu20_base:
	sudo docker build -t ubuntu20-$(BASE_IMAGE_POSTFIX) -f $(UBUNTU20_BASE_DOCKERFILE) $(DOCKER_BASE_DIR)

ubuntu22_base:
	sudo docker build -t ubuntu22-$(BASE_IMAGE_POSTFIX) -f $(UBUNTU22_BASE_DOCKERFILE) $(DOCKER_BASE_DIR)

ubuntu24_base:
	sudo docker build -t ubuntu24-$(BASE_IMAGE_POSTFIX) -f $(UBUNTU24_BASE_DOCKERFILE) $(DOCKER_BASE_DIR)

arm64_builders: $(BASES)
	sudo docker build -t ubuntu18-kbuild-arm64 -f ubuntu18-arm64-builder.Dockerfile .
	sudo docker build -t ubuntu20-kbuild-arm64 -f ubuntu20-arm64-builder.Dockerfile .

arm_builders: $(BASES)
	sudo docker build -t ubuntu18-kbuild-armhf -f ubuntu18-armhf-builder.Dockerfile .
	sudo docker build -t ubuntu20-kbuild-armhf -f ubuntu20-armhf-builder.Dockerfile .

cross_builders: arm64_builders arm_builders

generic_builders: $(BASES)
	sudo docker build -t ubuntu18-kbuild-generic -f ubuntu18-generic-builder.Dockerfile .
	sudo docker build -t ubuntu20-kbuild-generic -f ubuntu20-generic-builder.Dockerfile .
	sudo docker build -t ubuntu22-kbuild-generic -f ubuntu22-generic-builder.Dockerfile .
	sudo docker build -t ubuntu24-kbuild-generic -f ubuntu24-generic-builder.Dockerfile .