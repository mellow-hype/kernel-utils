FROM ubuntu:bionic
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    bzip2 \
    git-core \
    gzip \
    liblzma-dev \
    liblzo2-dev \
    liblzo2-dev \
    ocaml-nox gawk \
    lzop \
    python3 \
    python-lzo \
    python3-pip \
    squashfs-tools \
    srecord \
    tar \
    unzip \
    perl \
    rsync \
    bison \
    flex \
    fakeroot \
	ccache ecj fastjar \
    gettext git java-propose-classpath libelf-dev libncurses5-dev \
    libncursesw5-dev libssl-dev python python2.7-dev \
    python3-setuptools python3-dev rsync subversion \
    gcc-mips-linux-gnu \
    pkg-config \
    wget \
    sudo \
    cpio \
    bc \
    vim \
    zlib1g-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# add non-root user required for buildroot
RUN useradd -m builder &&\
    echo 'builder ALL=NOPASSWD: ALL' > /etc/sudoers.d/builder
USER builder

# this is where images produced by buildroot will be copied for export to the host
VOLUME [ "/home/builder/images" ]

# download buildroot and copy the orbi-qemu-vexpress-a7 tree
WORKDIR /home/builder

ENTRYPOINT [ "/bin/bash" ]
