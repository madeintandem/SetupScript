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
  /bin/zsh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  fancy_echo "Homebrew detected"
  fancy_echo "Updating brew"
  brew update
fi

brew install google-chrome slack rectangle 1password spotify figma alfred --cask

###############################
#   Design-specific tooling   #
###############################
#
fancy_echo "Do you want to install Design tools?  y / n"
read $design

if [ $design = "y" ]; then
  . ./design_setup.sh
fi

############################
#   Dev-specific tooling   #
############################
#
fancy_echo "Do you want to install Development tools? y / n"
read $dev

if [ $dev = "y" ]; then
  . ./dev_setup.sh
fi
<<<<<<< HEAD
=======

source ~/.rvm/scripts/rvm
rvm -v
if [ $? != 0 ]; then
  fancy_echo "Installing ruby 3.0.0"
  rvm reload
  rvm install 3.0.0
else
  fancy_echo "After this script, start a new shell session to initialize rvm and run the following command"
  fancy_echo "rvm install 3.0.0"
fi

npm install -g yarn create-react-app
>>>>>>> 87bc5b3ae77ee01ac995f9d365b00307bd65c007
