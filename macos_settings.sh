#!/bin/sh

clear_and_header() {
  clear
  echo ""
  echo "=============== macOS config wizard ================"
  echo "( please choose each setting with either 'y' or 'n')"
  echo ""
}

# arguments: prompt, command
prompt_and_read() {
  if [ "$ACCEPT_ALL" = "true" ]; then
    eval "$2"
  else
    clear_and_header
    echo ""
    echo $1
    read macos
    if [ "$macos" = "y" ]; then
      eval "$2"
    fi
  fi
}

echo "Please enter your admin password to update preferences"
sudo -v

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

clear_and_header
echo "Accept all suggested options?"
read macos
if [ "$macos" = "y" ]; then
  ACCEPT_ALL="true"
fi

prompt_and_read "Hide all desktop icons?" \
  "defaults write com.apple.finder CreateDesktop false"

prompt_and_read "Prevent photos from opening automatically when devices are plugged in?" \
  "defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true"

prompt_and_read "Disable sound effects on boot?" \
  "sudo nvram SystemAudioVolume=\" \""

prompt_and_read "Disable autocorrect when typing?" \
  "defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false"

prompt_and_read "Disable automatic capitalization?" \
  "defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false"

prompt_and_read "Disable automatic smart dashes?" \
  "defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false"

prompt_and_read "Disable automatic smart quotes?" \
  "defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false"

prompt_and_read "Disable the 'are you sure you want to open this application?' dialog?" \
  "defaults write com.apple.LaunchServices LSQuarantine -bool false"

prompt_and_read "Show hidden files in finder?" \
  "defaults write com.apple.finder AppleShowAllFiles -bool true"

prompt_and_read "Show file extensions in finder?" \
  "defaults write NSGlobalDomain AppleShowAllExtensions -bool true"

prompt_and_read "Disable shadows in screenshots?" \
  "defaults write com.apple.screencapture disable-shadow -bool true"

prompt_and_read "Enable subpixel font rendering on non-Apple displays?" \
  "defaults write NSGlobalDomain AppleFontSmoothing -int 2"

prompt_and_read "Avoid creating .DS_Store files on network or USB volumes?" \
  "defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true && defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true"

prompt_and_read "Automatically hide and show the Dock?" \
  "defaults write com.apple.dock autohide -bool true"

prompt_and_read "Keep folders on top while sorting by name in finder?" \
  "defaults write com.apple.finder _FXSortFoldersFirst -bool true"

prompt_and_read "Have the dock show only active applications?" \
  "defaults write com.apple.dock static-only -bool true; killall Dock"

prompt_and_read "Visualize CPU usage in the Activity Monitor Dock icon" \
  "defaults write com.apple.ActivityMonitor IconType -int 5"

prompt_and_read "Activity Monitor show all processes?" \
  "defaults write com.apple.ActivityMonitor ShowCategory -int 0"

prompt_and_read "Save to disk (not iCloud) by default?" \
  "defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false"

prompt_and_read "Expand save panel by default?" \
  "defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true && defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true"

prompt_and_read "Sort activity monitor results by CPU usage?" \
  "defaults write com.apple.ActivityMonitor SortColumn -string \"CPUUsage\" && defaults write com.apple.ActivityMonitor SortDirection -int 0"

prompt_and_read "Add Rectangle as login item?" \
  "osascript -e 'tell application \"System Events\" to make login item at end with properties {name: \"Rectangle\",path:\"/Applications/Rectangle.app\", hidden:false}'"

prompt_and_read "Add Alfred as login item?" \
  "osascript -e 'tell application \"System Events\" to make login item at end with properties {name: \"Alfred 4\",path:\"/Applications/Alfred 4.app\", hidden:false}'"

prompt_and_read "Disable the warning when changing a file extension?" \
  "defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false"

prompt_and_read "Show the ~/Library folder by default?" \
  "chflags nohidden ~/Library"

prompt_and_read "Disable Resume system wide?" \
  "defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool false"

prompt_and_read "Save screenshots to their own folder on the Desktop?" \
  "mkdir $HOME/Desktop/screenshots && defaults write com.apple.screencapture location -string \"${HOME}/Desktop/screenshots\""

prompt_and_read "In Finder, search the current directory by default?" \
  "defaults write com.apple.finder FXDefaultSearchScope -string \"SCcf\""

for app in "Calendar" "Contacts" "Dock" "Finder" "SystemUIServer"; do
  killall "$app" &> /dev/null
done
