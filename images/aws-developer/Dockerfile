FROM milldr/base:latest

# Install apt packages
RUN sudo apt-get update && \
    sudo apt-get install -y \
         ranger \
         python-gitlab
         yamllint \
         npm

# Node Configuration and "hacks" for readying environment
RUN sudo npm install -g \
    bundle yo
RUN yo; exit 0
RUN sudo chmod g+rwx /$HOME /$HOME/.config /$HOME/.config/insight-nodejs


# Python and Pip Configuration
RUN sudo pip3 install --upgrade pip && \
    sudo pip3 install pipenv \
         awscli boto boto3 \
         pylint black yapf \
         cookiecutter \
         mock

# Ruby Configuration
# RUN gem install bundler awspec

# VIM configuration
COPY vimrc $HOME/.vimrc
RUN mkdir -p $HOME/.vim/bundle && \
    git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim && \
    vim -c 'PluginInstall' -c 'qa!'

# ZSH configuration
RUN sudo apt-get -y install \
    zsh zsh-syntax-highlighting
ENV XTERM xterm-256color
ENV ZSH_THEME awesomepanda
RUN wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -0 - | zsh || true && \
    echo "source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting/zsh" >> ~/.zshrc

# Color scheme zsh
# TODO: do I need this? better zsh config WIP
# RUN git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
# RUN brew install zsh-syntax-highlighting
# cd Downloads
# curl -O https://raw.githubusercontent.com/MartinSeeler/iterm2-material-design/master/material-design-colors.itermcolors
# # swap to material-design-colors.itermcolors in iterm
# # add the following to zshrc
# ZSH_THEME="powerlevel10k/powerlevel10k"
# source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Preferred alias shortcuts
RUN echo "alias tree=\"tree -a -I 'node_modules|.git|__pycache__|.pytest_cache|jest_*|coverage'\"" >> ~/.zshrc
RUN echo "alias pbcopy=\"xclip -selection clipboard\""
RUN echo "alias pbpaste=\"xclip -selection clipboard -o\""

WORKDIR $HOME/shared

