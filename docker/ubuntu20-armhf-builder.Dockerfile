FROM ubuntu20-kbuild-base:latest

# Install aarch64 toolchain
RUN sudo apt-get update && sudo apt-get install -y --no-install-recommends \
    gcc-arm-linux-gnueabihf \
    libc6-dev-armhf-cross && \
    sudo apt-get clean && sudo rm -rf /var/lib/apt/lists/*

WORKDIR /home/builder
USER builder
