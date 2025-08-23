FROM ubuntu18-kbuild-base:latest

RUN sudo apt-get update && sudo apt-get install -y --no-install-recommends \
    gcc-aarch64-linux-gnu \
    libc6-dev-arm64-cross && \
    sudo apt-get clean && sudo rm -rf /var/lib/apt/lists/*

USER builder

