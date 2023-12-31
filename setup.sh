#!/bin/bash
set -e

function install_dot() {
  rm -rf "$HOME/$2"
  ln -s "$HOME/repos/dotfiles/$1" "$HOME/$2"
}
mkdir -p ~/bin ~/repos
mkdir -p ~/.vim/{autoload,colors,syntax} ~/.config/nvim/{autoload,colors,syntax}
install_dot dotfiles/vimrc .vimrc
install_dot dotfiles/bashrc .bashrc
install_dot dotfiles/psqlrc .psqlrc
install_dot dotfiles/sqliterc .sqliterc
install_dot dotfiles/xinitrc .xinitrc
install_dot dotfiles/tmux.conf .tmux.conf
install_dot dotfiles/vimrc .config/nvim/init.vim
install_dot vim/u.vim .vim/colors/u.vim
install_dot vim/u.vim .config/nvim/colors/u.vim
install_dot vim/go.vim .config/nvim/syntax/go.vim
install_dot vim/scheme.vim .config/nvim/syntax/scheme.vim
install_dot vim/markdown.vim .config/nvim/syntax/markdown.vim
install_dot vim/solidity.vim .config/nvim/syntax/solidity.vim
[ ! -f ~/.env ] && touch ~/.env
[ ! -f ~/.hushlogin ] && touch ~/.hushlogin
[ ! -f ~/.gitconfig ] && cp $HOME/repos/dotfiles/dotfiles/gitconfig ~/.gitconfig
[ ! -f ~/.gitignore_global ] && cp $HOME/repos/dotfiles/.gitignore ~/.gitignore_global
[ ! -f ~/.vim/autoload/plug.vim ] && cp ~/repos/dotfiles/vim/plug.vim ~/.vim/autoload/plug.vim
[ ! -f ~/.config/nvim/autoload/plug.vim ] && cp ~/repos/dotfiles/vim/plug.vim ~/.config/nvim/autoload/plug.vim

if [ ! -f $HOME/goroot/bin/go ]; then
  if [[ "$(uname)" == "Darwin" ]]; then
    curl -o go.tar.gz https://storage.googleapis.com/golang/go1.20.4.darwin-arm64.tar.gz
  else
    curl -o go.tar.gz http://storage.googleapis.com/golang/go1.20.4.linux-amd64.tar.gz
  fi
  tar -xzf go.tar.gz
  mv go ~/goroot
  rm go.tar.gz
fi
export GOROOT=~/goroot
export GOPATH=~/gopath
export GOBIN=~/bin
$GOROOT/bin/go install github.com/motemen/gore@latest
$GOROOT/bin/go install golang.org/x/tools/cmd/goimports@latest

if [ ! -d "$HOME/.rustup" ]; then
  curl https://sh.rustup.rs -sSf | sh -s -- --no-modify-path
fi

if [ ! -d "$HOME/n" ]; then
  curl -L http://git.io/n-install | bash -s -- -n -y
  export PATH="$PATH:$HOME/n/bin"
  $HOME/n/bin/npm i -g eslint
  $HOME/n/bin/npm i -g prettier
fi
