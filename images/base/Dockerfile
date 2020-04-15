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
    && pip3 install --upgrade pip setuptools virtualenv \
		&& rm -rf /var/lib/apt/lists/*

# Create and set up developer USER
ENV USER=developer
ENV HOME=/home/$USER
ENV GROUP=$USER
RUN groupadd $GROUP
RUN useradd -m -g $GROUP $USER

VOLUME $HOME
RUN chown -R $USER:$GROUP $HOME

# Add user as a sudoer
RUN mkdir -p /etc/sudoers.d && \
    echo "$USER ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/$USER

# Copy configuration files 
COPY gitconfig $HOME/.gitconfig
COPY vimrc $HOME/.vimrc
COPY zshrc $HOME/.zshrc

# If any of these files already exist, chown doesnt work correctly. Run it again
RUN sudo chown -R $USER:$GROUP $HOME/.gitconfig
RUN sudo chown -R $USER:$GROUP $HOME/.vimrc
RUN sudo chown -R $USER:$GROUP $HOME/.zshrc

# Vim config
RUN git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim && \
    mkdir -p $HOME/.vim/pack/default/start && \
    git clone https://github.com/sheerun/vim-polyglot $HOME/.vim/pack/default/start/vim-polyglot && \
    vim -c 'PluginInstall' -c 'qa!'  &>/dev/null

# ZSH configuration
RUN apt-get -y update && \
    apt-get -y install \
    zsh zsh-syntax-highlighting

# Install ZSH theme
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" && \
    git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k && \
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git && \
    echo "source ${PWD}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc && \
    echo "ZSH_THEME=\"powerlevel10k/powerlevel10k\"" >> ${ZDOTDIR:-$HOME}/.zshrc

USER $USER

# User env config
ENV XTERM xterm-256color
ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive

WORKDIR $HOME/shared
