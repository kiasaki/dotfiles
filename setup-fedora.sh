#!/usr/bin/env bash
set -ex

sudo dnf install -y python3 python3-devel cmake git-lfs ripgrep htop jq xclip \
  neovim python3-neovim tmux redis postgresql-server postgresql-devel \
  libX11-devel libXft-devel libXinerama-devel libXrandr-devel feh pcmanfm \
  podman podman-docker @virtualization wpa_supplicant alsa-utils \
  --skip-broken

sudo systemctl start redis
sudo systemctl enable redis
sudo systemctl start libvirtd
sudo systemctl enable libvirtd

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
