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
    python3 \
    python3-dev \
    liblzma-dev \
    liblzo2-dev \
    libelf-dev \
    libssl-dev \
    zlib1g-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


# add non-root user with passwordless sudo priv
RUN useradd -m builder &&\
    echo 'builder ALL=NOPASSWD: ALL' > /etc/sudoers.d/builder
USER builder

COPY ./create-image-debian-v2.sh /opt/create-image.sh

VOLUME [ "/home/builder/out" ]
WORKDIR /home/builder
RUN mkdir -p out

ENTRYPOINT [ "/home/builder/out/create-image.sh" ]

