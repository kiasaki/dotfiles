set -e

# Install packages
sudo eopkg it -c system.devel
sudo eopkg install git tmux neovim

# Install mksh
if [ ! -d "/tmp/mksh" ]; then
  git clone git@github.com:MirBSD/mksh.git /tmp/mksh
fi
cd /tmp/mksh
sh Build.sh
sudo install -c -s -o root -g bin -m 555 mksh /bin/mksh
sudo touch /etc/shells
sudo grep -x /bin/mksh /etc/shells >/dev/null || (echo /bin/mksh | sudo tee -a /etc/shells)
sudo install -c -o root -g bin -m 444 lksh.cat1 /usr/share/man/cat1/lksh.0
sudo install -c -o root -g bin -m 444 mksh.cat1 /usr/share/man/cat1/mksh.0
cd -

# Set shell to mksh
sudo chsh -s /bin/mksh $USER

# Symlink nvim to vim for $EDITOR to work
if [ ! -f /usr/bin/vim ]; then
  sudo ln -s /usr/bin/nvim /usr/bin/vim
fi
