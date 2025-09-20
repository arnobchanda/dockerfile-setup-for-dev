FROM ubuntu:24.04

RUN userdel -r ubuntu

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    gawk wget git diffstat unzip texinfo gcc build-essential \
    chrpath socat cpio python3-full python3-pip python3-pexpect xz-utils \
    debianutils iputils-ping python3-git python3-jinja2 \
    libsdl1.2-dev xterm locales screen sudo vim rsync curl \
    libssl-dev tcl libncurses5-dev tmux file procps duf net-tools \
    lua5.1 liblua5.1-0-dev dotnet-sdk-8.0 aspnetcore-runtime-8.0 zlib1g \
    cmake liblz4-tool zstd \
    && apt-get clean

RUN locale-gen en_US.UTF-8 && \
    update-locale LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8

RUN curl -o /usr/bin/repo https://storage.googleapis.com/git-repo-downloads/repo && \
    chmod a+x /usr/bin/repo

RUN useradd -ms /bin/bash -G sudo overlord && \
    echo "overlord ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER overlord
WORKDIR /home/overlord

CMD ["/bin/bash"]
