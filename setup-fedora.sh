#!/usr/bin/env bash
set -ex

# bash ./support/u.gnomeshell.sh
# curl https://cli-assets.heroku.com/install.sh | sh
# flatpak remote-add flathub https://flathub.org/repo/flathub.flatpakrepo

# libX11 and libXft and libXinerama-devel for suckless tools
# libvirt for kvm for the Android emulator
# podman for docker replacement
sudo dnf install -y python3 python3-devel cmake git-lfs ripgrep htop jq xclip \
  neovim python3-neovim tmux redis postgresql-server postgresql-devel \
  libX11-devel libXft-devel libXinerama-devel libXrandr-devel feh pcmanfm xclip \
  podman podman-docker @virtualization wpa_supplicant alsa-utils \
  --skip-broken

sudo systemctl start redis
sudo systemctl enable redis
sudo systemctl start libvirtd
sudo systemctl enable libvirtd
git lfs install
which ansible>/dev/null || pip3 install --user ansible virtualenv

if sudo test ! -d "/var/lib/pgsql/data/log";  then
  sudo /usr/bin/postgresql-setup --initdb
  sudo systemctl enable postgresql
  sudo systemctl restart postgresql
  pushd ~ >/dev/null
  sudo -u postgres psql -c "create user $USER with superuser;" || true
  sudo -u postgres psql -c "create database $USER with owner $USER;" || true
  popd
fi

sudo cp -r ~/dotfiles/support/fonts/go /usr/share/fonts/go
sudo cp -r ~/dotfiles/support/fonts/input /usr/share/fonts/input
fc-cache -f -v

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
[ ! -f ~/.local/share/konsole/u.colorscheme ] && cp ~/dotfiles/support/konsole.colorscheme ~/.local/share/konsole/u.colorscheme

if [ ! -f $HOME/code/dev/go/bin/go ]; then
  curl -o go.tar.gz http://storage.googleapis.com/golang/go1.14.4.linux-amd64.tar.gz
  tar -xzf go.tar.gz
  mv go ~/code/dev
  rm go.tar.gz
  ~/code/dev/go/bin/go get github.com/motemen/gore
  ~/code/dev/go/bin/go get golang.org/x/tools/cmd/goimports
fi

if [ ! -d "$HOME/n" ]; then
  curl -L http://git.io/n-install | bash -s -- -n -y
  export PATH="$PATH:$HOME/n/bin"
  $HOME/n/bin/npm i -g yarn
  $HOME/n/bin/npm i -g eslint
fi

if [ ! -d "$HOME/.rustup" ]; then
  curl https://sh.rustup.rs -sSf | sh -s -- -y --no-modify-path
fi
