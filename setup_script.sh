#!/bin/sh

# thanks to thoughtbot laptop script
fancy_echo() {
  local fmt="$1"; shift
  printf "\n$fmt\n" "$0"
}

################################
#   XCode command line tools   #
################################
# From developer.apple.com -
# Download the macOS SDK, headers, and build tools such as the Apple
# LLVM compiler and Make. These tools make it easy to install open
# source software or develop on UNIX within Terminal. macOS can
# automatically download these tools the first time you try to build
# software, and they are available on the downloads page.
#
# Why do we install it for everyone, not just developers?
#   Some of the tools supplied here are needed for the rest of this
#   script to run, and it's 100% essential to do work as a developer
#   on macOS
#
xcode-select -p
if [ $? == 0 ]; then
  fancy_echo "XCode Command Line Tools found. Continuing.."
else
  fancy_echo "Installing xcode command line tools, this could take some time.."
  xcode-select --install
fi

#################################################
#   Homebrew, macOS's missing package manager   #
#################################################
# From brew.sh -
# Homebrew installs the stuff you need that Apple (or your Linux system) didn’t.
#
# Why do we install it for everyone?
#   It's the program that much more of this script relies on
#
# set expected Homebrew install dir by processor architecture
case $(arch) in
  'arm64')
    BREW_DIR=/opt/homebrew/bin
    ;;
  'x86_64')
    BREW_DIR=/usr/local/bin
    ;;
  *)
    unset BREW_DIR
    ;;
esac

if ! [[ -z "$BREW_DIR" ]] && ! [[ -f $BREW_DIR/brew ]]; then
  fancy_echo "Homebrew not found.. installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  if [[ $BREW_DIR == /opt/homebrew/bin ]]; then
    echo '# Set PATH, MANPATH, etc., for Homebrew.' >> ~/.zprofile
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
    fancy_echo "brew added to PATH"
  fi
  brew -v
elif ! [[ -z "$BREW_DIR" ]] && [[ $(which brew) == $BREW_DIR/brew ]]; then
  fancy_echo "Homebrew detected"
  fancy_echo "Updating brew"
  brew update
  brew -v
else
  fancy_echo "No action taken for Homebrew; path did not match CPU architecture"
fi

if [ ! -d /Applications/"Google Chrome.app" ]; then
  fancy_echo "Google Chrome not found.. installing Google Chrome"
  brew install --cask google-chrome
else
  fancy_echo "Google Chrome detected"
  fancy_echo "Skipping Google Chrome..."
fi

if [ ! -d /Applications/Slack.app ]; then
  fancy_echo "Slack not found.. installing Slack"
  brew install --cask slack
else
  fancy_echo "Slack detected"
  fancy_echo "Skipping Slack..."
fi

if [ ! -d /Applications/Rectangle.app ]; then
  fancy_echo "Rectangle not found.. installing Rectangle"
  brew install --cask rectangle
else
  fancy_echo "Rectangle detected"
  fancy_echo "Skipping Rectangle..."
fi

if [ ! -d /Applications/'1Password 7.app' ]; then
  fancy_echo "1password not found.. installing 1password"
  brew install --cask 1password
else
  fancy_echo "1password detected"
  fancy_echo "Skipping 1password..."
fi

if [ ! -d /Applications/'Spotify.app' ]; then
  fancy_echo "Spotify not found.. installing Spotify"
  brew install --cask spotify
else
  fancy_echo "Spotify detected"
  fancy_echo "Skipping Spotify..."
fi

if [ ! -d /Applications/'Figma.app' ]; then
  fancy_echo "Figma not found.. installing Figma"
  brew install --cask figma
else
  fancy_echo "Figma detected"
  fancy_echo "Skipping Figma..."
fi

if [ ! -d /Applications/'Alfred 4.app' ]; then
  fancy_echo "Alfred not found.. installing Alfred"
  brew install --cask alfred
else
  fancy_echo "Alfred detected"
  fancy_echo "Skipping Alfred..."
fi

if [ ! -f ./setup_script.sh ]; then
  git clone https://github.com/madeintandem/SetupScript.git $HOME/tandem_setup_script
  IS_CLONED="true"
else
  IS_CLONED="false"
fi

###############################
#   Design-specific tooling   #
###############################
#
fancy_echo "Do you want to install Design tools?  y / n"
read design

if [ "$design" = "y" ] && [ "$IS_CLONED" = "true" ]; then
  . $HOME/tandem_setup_script/design_setup.sh
elif [ "$design" = "y" ]; then
  . ./design_setup.sh
fi

############################
#   Dev-specific tooling   #
############################
#
fancy_echo "Do you want to install Development tools? y / n"
read dev

if [ "$dev" = "y" ] && [ "$IS_CLONED" = "true" ]; then
  . $HOME/tandem_setup_script/dev_setup.sh
elif [ "$dev" = "y" ]; then
  . ./dev_setup.sh
fi

#############################
#   Useful macOS settings   #
#############################
# Some settings and configuration of macOS are not accessible
# through the UI. Included here are some useful settings that
# can be opted into.

fancy_echo "Would you like to set up some macOS configuration? y / n"
read macos

if [ "$macos" = "y" ] && [ "$IS_CLONED" = "true" ]; then
  . $HOME/tandem_setup_script/macos_settings.sh
elif [ "$macos" = "y" ]; then
  . ./macos_settings.sh
fi

# clean up after yourself!
if [ "$IS_CLONED" = "true" ]; then
  rm -rf $HOME/tandem_setup_script
fi