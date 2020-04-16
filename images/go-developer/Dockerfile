FROM milldr/base:latest

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

# Verify
RUN go version

# Give local user Go permission
RUN sudo chown -R $USER $GOROOT

# Install Terraform
ARG TERRAFORM_VERSION=0.12.20
RUN \
    sudo mkdir /opt/terraform_install && cd /opt/terraform_install && \
    sudo wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    sudo unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    sudo mv terraform /usr/local/bin/

# Verify
RUN terraform version
