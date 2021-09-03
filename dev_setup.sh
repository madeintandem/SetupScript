#!/bin/sh

# GUI mac app installation & Command line or non-GUI application installation

brew bundle

if [ ! -d $HOME/.rvm ]; then
  fancy_echo "RVM not found, installing"
  \curl -sSL https://get.rvm.io | bash -s stable
else
  fancy_echo "RVM found, continuing"
fi

source ~/.rvm/scripts/rvm
rvm -v 1> /dev/null
if [ $? != 0 ]; then
  fancy_echo "After this script, start a new shell session to initialize rvm and run the following command"
  fancy_echo "rvm install 3.0.0 && gem install bundler rubocop reek solargraph rails"
else
  fancy_echo "Installing ruby 3.0.0"
  rvm reload
  rvm install 3.0.0
fi

# installing rvm will create shell profiles if they do not exist
if [ ! -d $HOME/.nvm ]; then
  fancy_echo "NVM not found, installing"
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | zsh
  source ~/.zshrc
else
  fancy_echo "NVM found, continuing"
fi

nvm install --lts

fancy_echo "Installing yarn"
npm install -g yarn
