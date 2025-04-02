# NOTE: Run with --privileged (required for chroot in the container)
FROM debian:bullseye
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    debootstrap \
    openssh-client \
    build-essential \
    tar \
    unzip \
    perl \
    rsync \
    bison \
    flex \
    fakeroot \
    bzip2 \
    cmake \
    git-core \
    gzip \
    lzop \
    gawk \
    ccache \
    ninja-build \
    meson \
    ecj \
    gettext \
    pkg-config \
    wget \
    sudo \
    cpio \
    bc \
    vim \
    python2.7-dev \
    python3 \
    python3-lzo \
    python3-pip \
    python3-setuptools \
    python3-dev \
    liblzma-dev \
    liblzo2-dev \
    libelf-dev \
    libssl-dev \
    zlib1g-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# add non-root user required for buildroot
RUN useradd -m builder &&\
    echo 'builder ALL=NOPASSWD: ALL' > /etc/sudoers.d/builder
USER builder

# this is where images produced by buildroot will be copied for export to the host
VOLUME [ "/home/builder/src" ]
WORKDIR /home/builder/src

ENTRYPOINT [ "/bin/bash" ]


