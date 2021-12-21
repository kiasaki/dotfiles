#!/bin/bash
set -e

log() {
  echo "----> $1"
}

osx=false
if [[ "$(uname)" == "Darwin" ]]; then
  osx=true
fi

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
  log "Language: Go: Fetching binaries"
  if $osx; then
    curl -o go.tar.gz https://storage.googleapis.com/golang/go1.14.4.darwin-amd64.tar.gz
  else
    curl -o go.tar.gz http://storage.googleapis.com/golang/go1.14.4.linux-amd64.tar.gz
  fi
  tar -xzf go.tar.gz
  mv go ~/code/dev
  rm go.tar.gz
fi
export GOROOT=~/code/dev/go
export GOPATH=~/code/go
export GOBIN=~/bin
mkdir -p $GOPATH/src/github.com/kiasaki
$GOROOT/bin/go get -u github.com/motemen/gore
$GOROOT/bin/go get -u golang.org/x/tools/cmd/goimports

if [ ! -d "$HOME/.rustup" ]; then
  curl https://sh.rustup.rs -sSf | sh -s -- --no-modify-path --default-toolchain nightly
fi

if [ ! -d "$HOME/n" ]; then
  log "Language: Node.js: Fetching binaries"
  curl -L http://git.io/n-install | bash -s -- -n -y
  export PATH="$PATH:$HOME/n/bin"
  $HOME/n/bin/npm i -g eslint
fi
