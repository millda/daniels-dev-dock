FROM milldr/base:latest

# ENV Config
ENV XTERM xterm-256color
ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8

# Install apt packages
RUN sudo apt-get update && \
    sudo apt-get install -y \
         ranger \
         python-gitlab \
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
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" && \
    sudo git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k && \
    sudo git clone https://github.com/zsh-users/zsh-syntax-highlighting.git && \
    echo "source ${PWD}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc && \
    echo "ZSH_THEME=\"powerlevel10k/powerlevel10k\"" >> ${ZDOTDIR:-$HOME}/.zshrc

# TODO swap to material-design-colors.itermcolors in iterm
# RUN sudo curl -O https://raw.githubusercontent.com/MartinSeeler/iterm2-material-design/master/material-design-colors.itermcolors

# Preferred alias shortcuts
RUN echo "alias tree=\"tree -a -I 'node_modules|.git|__pycache__|.pytest_cache|jest_*|coverage'\"" >> ~/.zshrc
RUN echo "alias pbcopy=\"xclip -selection clipboard\"" >> ~/.zshrc
RUN echo "alias pbpaste=\"xclip -selection clipboard -o\"" >> ~/.zshrc

WORKDIR $HOME/shared

