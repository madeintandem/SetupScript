# thanks to thoughtbot laptop script
fancy_echo() {
  local fmt="$1"; shift
  printf "\n$fmt\n" "$0"
}

xcode-select -p
if [ $? == 0 ]; then
  fancy_echo "XCode Command Line Tools found. Continuing.."
else
  fancy_echo "Installing xcode command line tools, this could take some time.."
  xcode-select --install
fi

# install Homebrew package manager
if [ ! -f /usr/local/bin/brew ]; then
  fancy_echo "Homebrew not found.. installing Homebrew"
  /bin/zsh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  fancy_echo "Homebrew detected"
  fancy_echo "Updating brew"
  brew update
fi

brew install google-chrome slack rectangle 1password spotify figma --cask

#
fancy_echo "Do you want to install Design tools?  y / n"
read $design

if [ $design == "y" ]; then
  brew install adobe-creative-cloud --cask
fi

fancy_echo "Do you want to install Development tools? y / n"
read $dev

if [ $dev != "y" ]; then
  fancy_echo "Well you're all set then!"
  exit
fi

brew install visual-studio-code alfred iterm2 --cask

if [ ! -d $HOME/.nvm ]; then
  fancy_echo "NVM not found, installing..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
else
  fancy_echo "NVM found, continuing"
fi

nvim install latest

if [ ! -d $HOME/.rvm ]; then
  fancy_echo "RVM not found, installing..."
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
  fancy_echo "rvm install 3.0.0"
fi

npm install -g yarn create-react-app