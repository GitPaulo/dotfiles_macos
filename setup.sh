#!/bin/bash

DOTFILES_DIR=~/dotfiles_macos
BACKUP_DIR=~/dotfiles_backup
FILES=(.bash_profile .bashrc .skhdrc .yabairc .vimrc .vim .config)

echo "====> dotfiles_macos setup script!"
mkdir -p $BACKUP_DIR

for file in "${FILES[@]}"; do
  if [ -e ~/$file ] && [ ! -L ~/$file ]; then
    mv ~/$file $BACKUP_DIR/
  fi
  ln -sf $DOTFILES_DIR/$file ~/$file
done

echo "dotfiles symlinked. Original files moved to $BACKUP_DIR."

echo "Debloating..."
read -e -p "(y/N) Do you want to run debloating commands now? " yn
if [ "$yn" = "y" ]; then
  echo "...."
else
  sleep 3
  echo "Skipping!"
  exit
fi

# Disabling Spotlight
echo "Disabling Spotlight"
sudo mdutil -i off -a
echo "Done"

# Disable animations, and heavy desktop effects
echo "Disabing animations and desktop effects"
sudo defaults write /Library/Preferences/com.apple.loginwindow DesktopPicture ""
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001
defaults write -g QLPanelAnimationDuration -float 0
defaults write com.apple.dock autohide-time-modifier -float 0
defaults write com.apple.Dock autohide-delay -float 0
defaults write com.apple.dock expose-animation-duration -float 0.001
defaults write com.apple.dock launchanim -bool false
defaults write com.apple.finder DisableAllAnimations -bool true
defaults write com.apple.Accessibility DifferentiateWithoutColor -int 1
defaults write com.apple.Accessibility ReduceMotionEnabled -int 1
defaults write com.apple.universalaccess reduceMotion -int 1
defaults write com.apple.universalaccess reduceTransparency -int 1
defaults write com.apple.Accessibility ReduceMotionEnabled -int 1
echo "Done"

# Disable and remove Safari services
echo "Disabling and removing Safari services"
sudo launchctl remove com.apple.SafariCloudHistoryPushAgent
sudo launchctl remove com.apple.Safari.SafeBrowsing.Service
sudo launchctl remove com.apple.SafariNotificationAgent
sudo launchctl remove com.apple.SafariPlugInUpdateNotifier
sudo launchctl remove com.apple.SafariHistoryServiceAgent
sudo launchctl remove com.apple.SafariLaunchAgent
sudo launchctl remove com.apple.SafariPlugInUpdateNotifier
sudo launchctl remove com.apple.safaridavclient
echo "Done"

# Disable application state on shutdown
echo "Disabling application state on shutdown"
defaults write com.apple.loginwindow TALLogoutSavesState -bool false
echo "Done"

# Reboot
echo "Debloat done"
read -e -p "(y/N) Do you want to reboot now? " yn
if [ "$yn" = "y" ]; then
  sleep 3
  echo "Rebooting..."
  sudo reboot
else
  sleep 3
  echo "Defaulting to no."
  exit
fi
