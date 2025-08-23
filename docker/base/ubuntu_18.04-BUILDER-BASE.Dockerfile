FROM ubuntu:18.04
ENV TZ=America/Los_Angeles
ENV TERM=xterm-256color
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    automake \
    ocaml-nox \
    bison \
    flex \
    fakeroot \
    ccache \
    ecj \
    gettext \
    git-core \
    bzip2 \
    gzip \
    gawk \
    lzop \
    python \
    python2.7-dev \
    python3 \
    python-lzo \
    python3-pip \
    python3-setuptools \
    python3-dev \
    squashfs-tools \
    srecord \
    tar \
    unzip \
    perl \
    rsync \
    git \
    java-propose-classpath \
    rsync \
    subversion \
    pkg-config \
    wget \
    sudo \
    tmux \
    cpio \
    bc \
    vim \
    libelf-dev \
    libncurses-dev \
    libssl-dev \
    liblzma-dev \
    liblzo2-dev \
    zlib1g-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# add non-root user required for buildroot
RUN useradd -m builder &&\
    echo 'builder ALL=NOPASSWD: ALL' > /etc/sudoers.d/builder
USER builder

VOLUME [ "/home/builder/images" ]
VOLUME [ "/home/builder/src" ]

WORKDIR /home/builder

ENTRYPOINT [ "/bin/bash" ]
