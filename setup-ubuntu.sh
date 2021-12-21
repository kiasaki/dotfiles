#!/bin/bash
set -xe

pushd ~ >/dev/null

sudo apt-get install -qq -y software-properties-common \
  build-essential \
  make \
  cmake \
  curl \
  git \
  git-lfs \
  htop \
  mosh \
  tmux \
  jq \
  neovim \
  silversearcher-ag \
  postgresql \
  redis-server \
  python3-pip \
  xclip
# libfreetype6-dev \
# fontconfig \
# xorg-dev \
# feh

sudo systemctl start redis-server && sudo systemctl enable redis-server || sudo service redis-server start
sudo systemctl start postgresql && sudo systemctl enable postgresql || sudo service postgresql start
sudo -u postgres psql -c "create user $USER with superuser;" || true
sudo -u postgres psql -c "create database $USER with owner $USER;" || true
git lfs install
which ansible>/dev/null || pip3 install --user ansible virtualenv awscli

sudo cp -r ~/dotfiles/support/fonts/go /usr/share/fonts/go
sudo cp -r ~/dotfiles/support/fonts/input /usr/share/fonts/input
fc-cache -f -v || true

mkdir -p ~/bin ~/code/{dev,repos,venv,go}
mkdir -p ~/.vim/{autoload,colors,syntax} ~/.config/nvim/{autoload,colors,syntax}
function install_dot() {
  local source="$1"
  local target="$2"
  rm -rf "$HOME/$target"
  ln -s "$HOME/$source" "$HOME/$target"
}
install_dot dotfiles/dotfiles/vimrc .vimrc
install_dot dotfiles/dotfiles/bashrc .bashrc
install_dot dotfiles/dotfiles/psqlrc .psqlrc
install_dot dotfiles/dotfiles/xinitrc .xinitrc
install_dot dotfiles/dotfiles/tmux.conf .tmux.conf
install_dot dotfiles/vim/u.vim .vim/colors/u.vim
install_dot dotfiles/dotfiles/vimrc .config/nvim/init.vim
install_dot dotfiles/vim/u.vim .config/nvim/colors/u.vim
install_dot dotfiles/vim/go.vim .config/nvim/syntax/go.vim
install_dot dotfiles/vim/dart.vim .config/nvim/syntax/dart.vim
install_dot dotfiles/vim/markdown.vim .config/nvim/syntax/markdown.vim

[ ! -f ~/.env ] && touch ~/.env
[ ! -f ~/.hushlogin ] && touch ~/.hushlogin
[ ! -f ~/.npmrc ] && cp $HOME/dotfiles/dotfiles/npmrc ~/.npmrc
[ ! -f ~/.gitconfig ] && cp $HOME/dotfiles/dotfiles/gitconfig ~/.gitconfig
[ ! -f ~/.vim/autoload/plug.vim ] && cp ~/dotfiles/vim/plug.vim ~/.vim/autoload/plug.vim
[ ! -f ~/.config/nvim/autoload/plug.vim ] && cp ~/dotfiles/vim/plug.vim ~/.config/nvim/autoload/plug.vim

if [ ! -f $HOME/code/dev/go/bin/go ]; then
  curl -o go.tar.gz http://storage.googleapis.com/golang/go1.14.4.linux-amd64.tar.gz
  tar -xzf go.tar.gz
  mv go ~/code/dev
  rm go.tar.gz
  export GOROOT=~/code/dev/go
  export GOPATH=~/code/go
  $GOROOT/bin/go get github.com/motemen/gore
  $GOROOT/bin/go get golang.org/x/tools/cmd/goimports
fi

if [ ! -d "$HOME/.rustup" ]; then
  curl https://sh.rustup.rs -sSf | sh -s -- -y --no-modify-path
fi

if [ ! -d "$HOME/n" ]; then
  curl -L http://git.io/n-install | bash -s -- -n -y
  export PATH="$PATH:$HOME/n/bin"
  $HOME/n/bin/npm i -g yarn
  $HOME/n/bin/npm i -g eslint
fi

echo "setxkbmap -option ctrl:nocaps" >> ~/.env
