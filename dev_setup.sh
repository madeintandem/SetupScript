# GUI mac app installation
brew install visual-studio-code iterm2 --cask

# Command line or non-GUI application installation
brew install openssl z fzf exa heroku redis postgresql

if [ ! -d $HOME/.nvm ]; then
  fancy_echo "NVM not found, installing"
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
else
  fancy_echo "NVM found, continuing"
fi

nvim install latest

if [ ! -d $HOME/.rvm ]; then
  fancy_echo "RVM not found, installing"
  \curl -sSL https://get.rvm.io | bash -s stable
else
  fancy_echo "RVM found, continuing"
fi

source ~/.rvm/scripts/rvm
rvm -v
if [ $? != 0 ]; then
  fancy_echo "Installing ruby 3.0.0"
  rvm reload
  rvm install 3.0.0
else
  fancy_echo "After this script, start a new shell session to initialize rvm and run the following command"
  fancy_echo "rvm install 3.0.0 && gem install bundler rubocop reek solargraph rails"
fi

fancy_echo "Installing common npm packages"
npm install -g yarn create-react-app prettier javascript-typescript-langserver babel eslint