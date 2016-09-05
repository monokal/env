#
# docker run --rm -ti -v ~/:/host/ monokal/env:latest
#

FROM ubuntu:latest
MAINTAINER Daniel Middleton <@monokal.io>

# APT packages to install.
ENV APT_PACKAGES \
    git \
    ruby-dev \
    gcc \
    make \
    curl \
    wget \
    python \
    python3 \
    vim \
    zsh

# Gems to install.
ENV GEM_PACKAGES \
    fpm

# Change to /tmp so we can clean-up later.
WORKDIR /tmp

# Install APT packages.
RUN apt-get update && \
    apt-get -y install $APT_PACKAGES && \
    mkdir /host

# Install oh-my-zsh.
RUN git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh && \
    cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc && \
    chsh -s $(which zsh)

# Install pip.
RUN curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py" && \
    python get-pip.py

# Install Gems.
RUN gem install $GEM_PACKAGES

# Copy in Zsh/Vim configs & MOTD.
RUN mkdir -p /root/.vim/colors
ADD ./dot_zshrc /root/.zshrc
ADD ./dot_vimrc /root/.vimrc
ADD ./molokai.vim /root/.vim/colors/molokai.vim
ADD ./motd /etc/motd

RUN git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim && \
    echo | echo | vim +PluginInstall +qall &>/dev/null

WORKDIR /root

# Clean-up.
RUN apt-get clean && \
    rm -rf /tmp/* /var/tmp/* && \
    rm -rf /var/lib/apt/lists/* && \
    rm -f /etc/ssh/ssh_host_*

ENTRYPOINT $(which zsh)
