FROM ubuntu:latest

# Do not exclude man pages & other documentation
# Reinstall all currently installed packages in order to get the man pages back
RUN rm /etc/dpkg/dpkg.cfg.d/excludes && apt-get update && \
    dpkg -l | grep ^ii | cut -d' ' -f3 | xargs apt-get install -y --reinstall && \
    rm -r /var/lib/apt/lists/*
    
# prepare for "add-apt-repository" and use of "curl"
RUN apt-get update && apt-get install -y \
    software-properties-common \
    apt-transport-https \
    curl \
    ca-certificates \
    apt-utils

RUN apt-get clean && apt-get update && apt-get install -y \
    locales \
    language-pack-fi  \
    language-pack-en && \
    export LANGUAGE=en_US.UTF-8 && \
    export LANG=en_US.UTF-8 && \
    export LC_ALL=en_US.UTF-8 && \
    locale-gen en_US.UTF-8 && \
    dpkg-reconfigure locales

# Set up Docker repository
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
  add-apt-repository \
  "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Update since we just installed repos
# Install apt pacakges
RUN apt-get update \
    && apt-get install -y \
       sudo \
       man \
       iputils-ping \
       software-properties-common \
       file \
       build-essential checkinstall libssl-dev \
       vim git nmap dtrx tree wget net-tools groff less jq xclip \
       docker-ce \
       python3-pip && \
       pip3 install --upgrade pip setuptools virtualenv

ENV USER=developer
ENV HOME=/home/$USER
RUN useradd -m -d $HOME $USER && \
    mkdir -p /etc/sudoers.d && \
    echo "$USER ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/$USER
RUN usermod -aG docker $USER

RUN chown -R $USER:$USER $HOME
RUN chown -R $USER:$USER $HOME/.*
RUN chown -R $USER:$USER $HOME/.[^.]*

USER $USER

