# Warning: automatically generated file
# Please edit script generate/make_complete_toolset.py


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
         mock

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

# Install GCP CloudSDK
RUN sudo echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list  \
  && sudo curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg  add - \
  && sudo apt-get update -y \
  && sudo apt-get install google-cloud-sdk -y

# Install Go
ENV GOLANG_VERSION 1.13.7
ENV GOLANG_REL_ARCH linux-amd64
RUN \
    cd $HOME && \
    curl -O https://storage.googleapis.com/golang/go${GOLANG_VERSION}.${GOLANG_REL_ARCH}.tar.gz && \
    sha256sum go${GOLANG_VERSION}.${GOLANG_REL_ARCH}.tar.gz && \
    tar -xvf go${GOLANG_VERSION}.${GOLANG_REL_ARCH}.tar.gz && \
    sudo chown -R root:root ./go

# Set required GO paths. GOROOT must not equal GOPATH
ENV GOROOT $HOME/go
ENV GOPATH $HOME/go-workspace
ENV PATH $PATH:/usr/local/go/bin:$GOROOT/bin:$GOPATH/bin

RUN echo $GOROOT && \
    echo $GOPATH && \
    echo $PATH

# Verify
# RUN go version

# Give local user Go permission
# RUN sudo chown -R $USER $GOROOT

# Install Terraform
ARG TERRAFORM_VERSION=0.12.20
RUN \
    sudo mkdir /opt/terraform_install && cd /opt/terraform_install && \
    sudo wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    sudo unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    sudo mv terraform /usr/local/bin/

# Verify
RUN terraform version
