FROM ubuntu:latest
MAINTAINER Daniel Middleton <@monokal.io>

# APT packages to install.
ENV APT_PACKAGES \
    apt-transport-https \
    ca-certificates \
    git \
    ruby-dev \
    gcc \
    make \
    curl \
    wget \
    python \
    python3 \
    vim \
    zsh \
    tree

# Gems to install.
ENV GEM_PACKAGES \
    fpm

# Change to /tmp so we can clean-up later.
WORKDIR /tmp

# Install APT packages.
RUN apt-get update && \
    apt-get -y dist-upgrade && \
    apt-get -y install $APT_PACKAGES

# Some misc config.
RUN mkdir /host && \
    git config --global user.name "monokal" && \
    git config --global user.email "d@monokal.io" && \
    git config --global push.default simple

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
    vim -c 'PluginInstall' -c 'qa!'

# Clean-up.
RUN apt-get clean && \
    rm -rf /tmp/* /var/tmp/* && \
    rm -rf /var/lib/apt/lists/* && \
    rm -f /etc/ssh/ssh_host_*

WORKDIR /host

ENTRYPOINT $(which zsh)
