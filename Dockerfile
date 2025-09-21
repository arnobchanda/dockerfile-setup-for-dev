ARG UBUNTU_VERSION=24.04
ARG NEOVIM_VERSION=0.11.4

FROM ubuntu:${UBUNTU_VERSION}

RUN userdel -r ubuntu
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y --no-install-recommends \
    gawk \
    wget \
    git \
    diffstat \
    unzip \
    texinfo \
    gcc \
    build-essential \
    chrpath \
    socat \
    cpio \
    xz-utils \
    debianutils \
    iputils-ping \
    libsdl1.2-dev \
    xterm \
    locales \
    screen \
    sudo \
    vim \
    nano \
    rsync \
    curl \
    libssl-dev \
    tcl \
    libncurses5-dev \
    tmux \
    file \
    procps \
    duf \
    net-tools \
    zlib1g \
    cmake \
    liblz4-tool \
    zstd \
    ripgrep \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y --no-install-recommends \
    python3-full \
    python3-dev \
    python3-pip \
    python3-pexpect \
    python3-git \
    python3-jinja2 \
    lua5.1 \
    liblua5.1-0-dev \
    dotnet-sdk-8.0 \
    aspnetcore-runtime-8.0 \
    nodejs \
    && apt-get clean

RUN locale-gen en_US.UTF-8 && \
    update-locale LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8

RUN curl -o /usr/bin/repo https://storage.googleapis.com/git-repo-downloads/repo && \
    chmod a+x /usr/bin/repo

RUN curl -LO https://github.com/neovim/neovim/releases/download/v0.11.4/nvim-linux-x86_64.tar.gz && \
    tar -xzf "nvim-linux-x86_64.tar.gz" --strip-components=1 -C /usr/local && \
    rm "nvim-linux-x86_64.tar.gz"

RUN useradd -ms /bin/bash -G sudo overlord && \
    echo "overlord ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER overlord
WORKDIR /home/overlord

RUN mkdir -p /home/overlord/.config/nvim

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --default-toolchain stable -y
ENV PATH="/home/overlord/.cargo/bin:${PATH}"

CMD ["/bin/bash"]
