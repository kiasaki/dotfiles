#!/bin/bash
set -xe

sudo apt-get install -qq -y software-properties-common  build-essential  make \
  cmake  curl  git  htop  mosh  tmux  jq  neovim  silversearcher-ag \
  postgresql  redis-server  python3-pip  xclip libfreetype6-dev  fontconfig \
  xorg-dev feh

sudo systemctl start redis-server && sudo systemctl enable redis-server || sudo service redis-server start
sudo systemctl start postgresql && sudo systemctl enable postgresql || sudo service postgresql start
sudo -u postgres psql -c "create user $USER with superuser;" || true
sudo -u postgres psql -c "create database $USER with owner $USER;" || true

sudo cp -r ~/repos/dotfiles/support/fonts/go /usr/share/fonts/go
sudo cp -r ~/repos/dotfiles/support/fonts/input /usr/share/fonts/input
fc-cache -f -v || true

echo "setxkbmap -option ctrl:nocaps" >> ~/.env
