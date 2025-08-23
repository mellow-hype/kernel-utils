FROM ubuntu20-kbuild-base:latest

# Install OpenWrt/Lede specific dependencies
RUN sudo apt-get update && sudo apt-get install -y --no-install-recommends \
    swig \
    automake \
    xsltproc \
    gcc-aarch64-linux-gnu \
    libc6-dev-arm64-cross \
    && sudo apt-get clean \
    && sudo rm -rf /var/lib/apt/lists/*

WORKDIR /home/builder
USER builder
