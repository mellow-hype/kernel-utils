
SRC_DIR:=./src
UTIL_DIR:=./util
TAG:=debian-debootstrapper
DOCKERFILE:=$(SRC_DIR)/debootstrapper.Dockerfile
DOCKERFILE_ARM32:=$(SRC_DIR)/debootstrapper-cross-armhf.Dockerfile
DOCKERFILE_ARM64:=$(SRC_DIR)/debootstrapper-cross-aarch64.Dockerfile

odir_check:
ifndef odir
	$(error odir is not set. Usage: 'make odir=output/dir <...> $@')
	exit 1
endif

init_docker:
	sudo docker build -t $(TAG) -f $(DOCKERFILE) $(SRC_DIR)

init_docker_cross:
	sudo docker build -t $(TAG)-armhf --platform linux/arm -f $(DOCKERFILE_ARM32) $(SRC_DIR)
	sudo docker build -t $(TAG)-aarch64 --platform linux/aarch64 -f $(DOCKERFILE_ARM64) $(SRC_DIR)

install:
	mkdir -p $(HOME)/.local/bin
	ln -sf $(PWD)/util/debootstrap-dock.sh $(HOME)/.local/bin/debootstrap-dock
	ln -sf $(PWD)/util/debootstrap-cross-armhf.sh $(HOME)/.local/bin/debootstrap-cross-armhf
	ln -sf $(PWD)/util/debootstrap-cross-aarch64.sh $(HOME)/.local/bin/debootstrap-cross-aarch64
	ln -sf $(PWD)/util/rebuild-img.sh $(HOME)/.local/bin/debootstrap-rebuild-img

buster_amd64: odir_check
	mkdir -p $(odir)/$@ && \
	sudo docker run --privileged -v $(odir)/$@/:/home/builder/out --rm -it debian-bootstrapper buster

bullseye_amd64: odir_check
	mkdir -p $(odir) && \
	sudo docker run --privileged -v $(odir)/$@/:/home/builder/out --rm -it debian-bootstrapper bullseye

sid_amd64: odir_check
	mkdir -p $(odir) && \
	sudo docker run --privileged -v $(odir)/$@/:/home/builder/out --rm -it debian-bootstrapper sid
