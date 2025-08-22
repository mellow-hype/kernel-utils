# NOTE: Run with --privileged (required for chroot in the container)

FROM debian:bullseye-slim
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    debootstrap \
    qemu-user-static \
    binfmt-support \
    openssh-client \
    tar \
    unzip \
    rsync \
    fakeroot \
    bzip2 \
    git-core \
    gzip \
    lzop \
    gawk \
    gettext \
    wget \
    curl \
    sudo \
    cpio \
    bc \
    python3 \
    libelf-dev \
    libssl-dev \
    zlib1g-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


# add non-root user with passwordless sudo priv
RUN useradd -m builder &&\
    echo 'builder ALL=NOPASSWD: ALL' > /etc/sudoers.d/builder
USER builder

COPY ./create-image-debian.sh /opt/create-image.sh
WORKDIR /home/builder/out

VOLUME [ "/home/builder/out" ]
ENTRYPOINT [ "/opt/create-image.sh" ]

