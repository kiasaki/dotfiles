#!/bin/sh
set -e

if [ ! -d $HOME/code/repos/tmp/st ]; then
  git clone git://git.suckless.org/st ~/code/repos/tmp/st
fi
rm -f ~/code/repos/tmp/st/config.h
ln -s ~/dotfiles/support/config-st.h ~/code/repos/tmp/st/config.h
cd ~/code/repos/tmp/st
git apply ~/dotfiles/support/patches/st-anysize-0.8.1.diff || true
make clean
make
sudo make install
cd -

if [ ! -d $HOME/code/repos/tmp/dmenu ]; then
  git clone git://git.suckless.org/dmenu ~/code/repos/tmp/dmenu
fi
rm -f ~/code/repos/tmp/dmenu/config.h
ln -s ~/dotfiles/support/config-dmenu.h ~/code/repos/tmp/dmenu/config.h
cd ~/code/repos/tmp/dmenu
make clean
make
sudo make install
cd -

if [ ! -d $HOME/code/repos/tmp/dwm ]; then
  git clone git://git.suckless.org/dwm ~/code/repos/tmp/dwm
fi
rm -f ~/code/repos/tmp/dwm/config.h
ln -s ~/dotfiles/support/config-dwm.h ~/code/repos/tmp/dwm/config.h
cd ~/code/repos/tmp/dwm
make clean
make
sudo make install
cd -

if [ ! -d $HOME/code/repos/tmp/slstatus ]; then
  git clone git://git.suckless.org/slstatus ~/code/repos/tmp/slstatus
fi
rm -f ~/code/repos/tmp/slstatus/config.h
ln -s ~/dotfiles/support/config-slstatus.h ~/code/repos/tmp/slstatus/config.h
cd ~/code/repos/tmp/slstatus
make clean
make
sudo make install
cd -

if [ ! -d $HOME/code/repos/tmp/slock ]; then
  git clone git://git.suckless.org/slock ~/code/repos/tmp/slock
fi
rm -f ~/code/repos/tmp/slock/config.h
ln -s ~/dotfiles/support/config-slock.h ~/code/repos/tmp/slock/config.h
cd ~/code/repos/tmp/slock
make clean
make
sudo make install
cd -
