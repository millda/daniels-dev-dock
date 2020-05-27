FROM ubuntu:latest

# Avoid warnings by switching to noninteractive
ENV DEBIAN_FRONTEND=noninteractive

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
# Install apt-utils + build tools
# Suppress package configuration warning
RUN add-apt-repository ppa:jonathonf/vim 
RUN apt-get update \
    && apt-get -y install --no-install-recommends apt-utils dialog 2>&1 \
    && apt-get install -y \
      bc \
      unzip \
      wget \
      g++ \
      gcc \
      libc6-dev \
      make \
      pkg-config \
      gnupg-agent \
      sudo \
      man \
      iputils-ping \
      software-properties-common \
      file \
      build-essential \
      checkinstall \
      libssl-dev \
      vim \
      git \
      nmap \
      dtrx \
      tree \
      wget \
      net-tools \
      groff \
      less \
      jq \
      xclip \
      docker-ce \
      python3-pip \
      ranger \
      zsh zsh-syntax-highlighting \
    && pip3 install --upgrade pip setuptools virtualenv \
    && rm -rf /var/lib/apt/lists/*

# Create and set up developer USER
ENV USER=developer
ENV HOME=/home/$USER
ENV GROUP=$USER
RUN groupadd $GROUP
RUN useradd -m -g $GROUP $USER
RUN chown -R $USER:$GROUP $HOME

# Add user as a sudoer
RUN mkdir -p /etc/sudoers.d && \
    echo "$USER ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/$USER

# Swap to developer user
USER $USER

# User env config
ENV XTERM xterm-256color
ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive

# Copy configuration files 
# copy with chown for a given user must be run after USER {{given user}}
COPY --chown=$USER:$GROUP gitconfig $HOME/.gitconfig
COPY --chown=$USER:$GROUP vimrc $HOME/.vimrc
COPY --chown=$USER:$GROUP zshrc $HOME/.zshrc

# Windows file conversions
RUN sudo apt-get update && sudo apt-get install -y dos2unix \
    && dos2unix $HOME/.zshrc \
    && dos2unix $HOME/.vimrc \
    && dos2unix $HOME/.gitconfig

# Vim config
RUN git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim && \
    mkdir -p $HOME/.vim/pack/default/start && \
    vim +PluginInstall +qall

# Install ZSH theme and configure
# This has to be run in a single intermediate container, but git needs root. So sudo it
ENV ZSH_CUSTOM=$HOME/zsh-custom
RUN mkdir $ZSH_CUSTOM
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
RUN git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/zsh-syntax-highlighting
RUN \
    sudo echo "source ${ZSH_CUSTOM}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> $HOME/.zshrc && \
    echo "ZSH_THEME=\"powerlevel10k/powerlevel10k\"" >> $HOME/.zshrc

WORKDIR $HOME/shared
RUN sudo chown -R $USER:$GROUP .
