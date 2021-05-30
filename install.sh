#!/bin/bash
sudo apt update
sudo apt upgrade -y
sudo apt install neovim -y
sudo apt install zsh -y
sudo apt install nodejs -y
sudo apt install npm -y
sudo apt-get install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip -y

mkdir -p ~/.vim/backup
mkdir -p ~/.vim/swap
mkdir -p ~/.vim/undo
mkdir -p ~/go_projects/bin
mkdir -p ~/go_projects/pkg
mkdir -p ~/go_projects/src
cd /tmp
tar -C /usr/local -xzf go1.16.4.linux-amd64.tar.gz

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions


#Install Vim-Plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

