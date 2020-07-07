FROM milldr/base:latest

# Install apt packages
RUN sudo apt-get update && \
    sudo apt-get install -y \
         python-gitlab \
         yamllint \
         npm

# Ensure latest node
RUN curl -sL https://deb.nodesource.com/setup_13.x | sudo -E bash -
RUN sudo apt-get install -y nodejs

# Node Configuration and "hacks" for readying environment
RUN sudo npm install -g \
    bundle yo
RUN yo; exit 0

# Python and Pip Configuration
RUN sudo -H pip3 install --upgrade pip && \
    sudo -H pip3 install pipenv \
         awscli boto boto3 \
         pylint black yapf \
         cookiecutter \
         mock \
         wheel uwsgi flask

# Ruby Configuration
# RUN gem install bundler awspec

# Install Ansible
RUN sudo apt-add-repository --yes --update ppa:ansible/ansible && \
    sudo apt install -y ansible
RUN pip3 install ansible lxml

# Install homebrew
RUN git clone https://github.com/Homebrew/brew ~/.linuxbrew/Homebrew && \
    mkdir ~/.linuxbrew/bin && \
    ln -s ~/.linuxbrew/Homebrew/bin/brew ~/.linuxbrew/bin && \
    eval $(~/.linuxbrew/bin/brew shellenv) && \
    brew install hugo
