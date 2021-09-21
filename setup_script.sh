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
if [ ! -f /usr/local/bin/brew ]; then
  fancy_echo "Homebrew not found.. installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  fancy_echo "Homebrew detected"
  fancy_echo "Updating brew"
  brew update
fi

brew install google-chrome slack rectangle 1password spotify figma alfred --cask

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