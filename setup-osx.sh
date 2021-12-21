set -xe

sudo pmset -a sms 0 # no motion sensor
sudo pmset -a hibernatemode 0 # no hibernate
sudo systemsetup -setcomputersleep Off >/dev/null # no sleep
sudo rm /private/var/vm/sleepimage # remove sleep image
sudo touch /private/var/vm/sleepimage
sudo chflags uchg /private/var/vm/sleepimage
sudo scutil --set ComputerName "kiasaki-mbp" # set hostname
sudo scutil --set HostName "kiasaki-mbp"
sudo scutil --set LocalHostName "kiasaki-mbp"
defaults write com.apple.screensaver askForPassword -int 1 # ask for password after ss
defaults write com.apple.screensaver askForPasswordDelay -int 10 # delay password by 10s
defaults write -g AppleShowAllExtensions -bool true # show file extensions
defaults write com.apple.finder AppleShowAllFiles true # show hidden files
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv" # list view is default
defaults write com.apple.finder WarnOnEmptyTrash -bool false # don't warn on empty trash
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false # no natural scroll
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3 # allow tab in popups
defaults write -g KeyRepeat -int 2 # repeat keys fast
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false # no press&hold -> repeat
defaults write com.apple.universalaccess reduceTransparency -bool true # no transparency
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false # no "smart" sub.
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false # no "smart" sub.
defaults write com.apple.dock wvous-tl-corner -int 10 # sleep
defaults write com.apple.dock wvous-tr-corner -int 2  # mission control
defaults write com.apple.dock wvous-br-corner -int 11 # launchpad
defaults write com.apple.dock autohide-time-modifier -float 0 # no dock anim.
defaults write com.apple.dock autohide-delay -float 0 # no dock delay
defaults write com.apple.dock tilesize -int 32 # dock icon size
defaults write com.apple.dock expose-animation-duration -float 0.1 # faster dock anim.
defaults write com.apple.dock mru-spaces -bool false # don't rearrance spaces

if ! [ -x "$(command -v brew)" ]; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew tap petere/postgresql
brew install reattach-to-user-namespace

pkgs=()
which jq >/dev/null || pkgs+=(jq)
which ag >/dev/null || pkgs+=(the_silver_searcher)
which tig >/dev/null || pkgs+=(tig)
which git-lfs >/dev/null || pkgs+=(git-lfs)
which tree >/dev/null || pkgs+=(tree)
which tmux >/dev/null || pkgs+=(tmux)
which curl >/dev/null || pkgs+=(curl)
which htop >/dev/null || pkgs+=(htop)
which http >/dev/null || pkgs+=(httpie)
which git >/dev/null || pkgs+=(git)
which hg >/dev/null || pkgs+=(mercurial)
which vim >/dev/null || pkgs+=(vim)
which neovim >/dev/null || pkgs+=(neovim/neovim/neovim)
which psql >/dev/null || pkgs+=(postgresql)
which sqlite >/dev/null || pkgs+=(sqlite)
which redis >/dev/null || pkgs+=(redis)
if test -n "$pkgs"; then
  brew install "${pkgs[@]}"
fi

brew services start postgresql

mkdir -p ~/bin ~/code/{dev,repos,go}
mkdir -p ~/.vim/{autoload,colors,syntax} ~/.config/nvim/{autoload,colors,syntax}
function install_dot() {
  local source="$1"
  local target="$2"
  rm -rf "$HOME/$target"
  ln -s "$HOME/$source" "$HOME/$target"
}
install_dot dotfiles/dotfiles/vimrc .vimrc
install_dot dotfiles/dotfiles/bashrc .bashrc
install_dot dotfiles/dotfiles/bashrc .zshrc
install_dot dotfiles/dotfiles/psqlrc .psqlrc
install_dot dotfiles/dotfiles/tmux.conf .tmux.conf
install_dot dotfiles/vim/u.vim .vim/colors/u.vim
install_dot dotfiles/dotfiles/vimrc .config/nvim/init.vim
install_dot dotfiles/vim/u.vim .config/nvim/colors/u.vim
install_dot dotfiles/vim/go.vim .config/nvim/syntax/go.vim
install_dot dotfiles/vim/markdown.vim .config/nvim/syntax/markdown.vim

[ ! -f ~/.env ] && touch ~/.env
[ ! -f ~/.npmrc ] && cp $HOME/dotfiles/dotfiles/npmrc ~/.npmrc
[ ! -f ~/.gitconfig ] && cp $HOME/dotfiles/dotfiles/gitconfig ~/.gitconfig
[ ! -f ~/.vim/autoload/plug.vim ] && cp ~/dotfiles/vim/plug.vim ~/.vim/autoload/plug.vim
[ ! -f ~/.config/nvim/autoload/plug.vim ] && cp ~/dotfiles/vim/plug.vim ~/.config/nvim/autoload/plug.vim

if [ ! -f $HOME/code/dev/go/bin/go ]; then
  curl -o go.tar.gz https://storage.googleapis.com/golang/go1.17.2.darwin-amd64.tar.gz
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
  $HOME/n/bin/npm i -g eslint
fi

if [ ! -d "$HOME/.nix-profile" ]; then
  sh <(curl -L https://nixos.org/nix/install) --darwin-use-unencrypted-nix-store-volume
  . "$HOME/.nix-profile/etc/profile.d/nix.sh"
  curl https://dapp.tools/install | sh
fi
