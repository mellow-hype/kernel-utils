FROM focal-builder-base:latest

USER root
# install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc-arm-linux-gnueabihf && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

VOLUME [ "/home/builder/images" ]
VOLUME [ "/home/builder/src" ]

USER builder
WORKDIR /home/builder

ENTRYPOINT [ "/bin/bash" ]
