# Install developer tools
xcode-select --install || echo "Ignoring, developer tools are installed"

# Install brew
if ! [ -x "$(command -v brew)" ]; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Set shell to zsh
if test "$SHELL" != "/bin/zsh"; then
  chsh -s /bin/zsh
fi

# Update wallpaper
wallpaper_path="$HOME/dotfiles/support/wallpaper.jpg"
osascript -e "tell application \"Finder\" to set desktop picture to POSIX file \"$wallpaper_path\""

### Dock
# Set smaller icon size
defaults write com.apple.dock tilesize -int 32
# Wipe all icons
defaults write com.apple.dock persistent-apps -array
# Speed up mission control animations
defaults write com.apple.dock expose-animation-duration -float 0.1
# Do not automagically rearrange mission control spaces
defaults write com.apple.dock mru-spaces -bool false
# Automatically hide the dock
defaults write com.apple.dock autohide -bool true
# Remove hiding delay
defaults write com.apple.dock autohide-delay -float 0
# Remove dock show/hide animation
defaults write com.apple.dock autohide-time-modifier -float 0
# Set hot corners
defaults write com.apple.dock wvous-tl-corner -int 10 # sleep
defaults write com.apple.dock wvous-tr-corner -int 2  # mission control
defaults write com.apple.dock wvous-br-corner -int 11 # launchpad

### Finder
# Show extensions
defaults write -g AppleShowAllExtensions -bool true
# Show hidden files
defaults write com.apple.finder AppleShowAllFiles true
# Expand save panel by default
defaults write -g NSNavPanelExpandedStateForSaveMode -bool true
defaults write -g NSNavPanelExpandedStateForSaveMode2 -bool true
# Search in current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
# Default location is Home folder
defaults write com.apple.finder NewWindowTarget -string "PfLo"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}"
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
# Disable file ext change warning
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
# Use list view by default
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
# Disable trash emptying warning
defaults write com.apple.finder WarnOnEmptyTrash -bool false

### Keyboard & Mouse
# Enable tap to click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
# Always show scoll bars
defaults write -g AppleShowScrollBars -string "Always"
# Disable "natural" scrolling
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false
# Enable full keyboard use in modals (tab)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3
# Disable autocorrect
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false
# Disable press-and-hold (in favor of key repeat)
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
# Faster key repeat
defaults write -g KeyRepeat -int 2
# Disable "smart" quotes
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
# Disable "smart" dashes
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
# Disable "smart" emoji replacements
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticEmojiSubstitutionEnablediMessage" -bool false
# Disable (extra-sensitive) back swipe
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false

### OS
# Disable motion sensor
sudo pmset -a sms 0
# Disable hibernation (faster sleeps)
sudo pmset -a hibernatemode 0
# Disable sleeping
sudo systemsetup -setcomputersleep Off >/dev/null
# Remove the sleep image file to save disk space
sudo rm /private/var/vm/sleepimage
sudo touch /private/var/vm/sleepimage
sudo chflags uchg /private/var/vm/sleepimage
# Set hostname
sudo scutil --set ComputerName "kiasaki-mbp"
sudo scutil --set HostName "kiasaki-mbp"
sudo scutil --set LocalHostName "kiasaki-mbp"
# Ask for password after screensaver
defaults write com.apple.screensaver askForPassword -int 1
# Ask for password after only 10 seconds
defaults write com.apple.screensaver askForPasswordDelay -int 10
# Disable notification center
launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist
killall -9 NotificationCenter
# Disable transparency
defaults write com.apple.universalaccess reduceTransparency -bool true

killall Dock &> /dev/null
killall Finder &> /dev/null

### Packages
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

git lfs install
pip3 install --user ansible awscli
brew services start postgresql

brew tap caskroom/cask
brew tap caskroom/fonts
#brew cask install google-chrome vlc virtualbox the-unarchiver licecap spectacle textmate

### iTerm2
# Import color scheme
# open "${HOME}/dotfiles/colors/dracula.itermcolors"
# Don't prompt on quit
# defaults write com.googlecode.iterm2 PromptOnQuit -bool false
