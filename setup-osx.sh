xcode-select --install || echo "Ignoring, developer tools are installed"
if ! [ -x "$(command -v brew)" ]; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Dock
defaults write com.apple.dock tilesize -int 32
defaults write com.apple.dock persistent-apps -array
defaults write com.apple.dock expose-animation-duration -float 0.1
defaults write com.apple.dock mru-spaces -bool false
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0
defaults write com.apple.dock wvous-tl-corner -int 10 # sleep
defaults write com.apple.dock wvous-tr-corner -int 2  # mission control
defaults write com.apple.dock wvous-br-corner -int 11 # launchpad
# Finder
defaults write -g AppleShowAllExtensions -bool true
defaults write com.apple.finder AppleShowAllFiles true
defaults write -g NSNavPanelExpandedStateForSaveMode -bool true
defaults write -g NSNavPanelExpandedStateForSaveMode2 -bool true
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
defaults write com.apple.finder NewWindowTarget -string "PfLo"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}"
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
defaults write com.apple.finder WarnOnEmptyTrash -bool false

### Keyboard & Mouse
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write -g AppleShowScrollBars -string "Always"
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
defaults write -g KeyRepeat -int 2
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticEmojiSubstitutionEnablediMessage" -bool false
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false

### OS
sudo pmset -a sms 0
sudo pmset -a hibernatemode 0
sudo systemsetup -setcomputersleep Off >/dev/null
sudo rm /private/var/vm/sleepimage
sudo touch /private/var/vm/sleepimage
sudo chflags uchg /private/var/vm/sleepimage
sudo scutil --set ComputerName "kiasaki-mbp"
sudo scutil --set HostName "kiasaki-mbp"
sudo scutil --set LocalHostName "kiasaki-mbp"
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 10
launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist
killall -9 NotificationCenter
defaults write com.apple.universalaccess reduceTransparency -bool true

killall Dock &> /dev/null
killall Finder &> /dev/null

### Packages
brew tap petere/postgresql
brew install reattach-to-user-namespace tmux vim neovim/neovim/neovim curl jq htop postgresql redis sqlite awscli
brew services start postgresql
