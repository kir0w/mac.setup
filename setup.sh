#!/bin/sh

# Color Variables
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Ask for the administrator password upfront.
sudo -v

# Keep Sudo Until Script is finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Check if OSX Command line tools are installed
if type xcode-select >&- && xpath=$( xcode-select --print-path ) &&
    test -d "${xpath}" && test -x "${xpath}" ; then
    ###############################################################################
    # Computer Settings                                                           #
    ###############################################################################
    #echo -e "${RED}Enter your computer name please?${NC}"
    #read cpname
    #echo -e "${RED}Please enter your name?${NC}"
    #read name
    #echo -e "${RED}Please enter your git email?${NC}"
    #read email

    #clear

    #sudo scutil --set ComputerName "$cpname"
    #sudo scutil --set HostName "$cpname"
    #sudo scutil --set LocalHostName "$cpname"
    #defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "$cpname"

    #defaults write -g ApplePressAndHoldEnabled -bool false
    #defaults write com.apple.finder ShowPathbar -bool true
    #defaults write com.apple.finder ShowStatusBar -bool true
    #defaults write NSGlobalDomain KeyRepeat -int 0.02
    #defaults write NSGlobalDomain InitialKeyRepeat -int 12
    #chflags nohidden ~/Library


    #git config --global user.name "$name"

    #git config --global user.email "$email"

    #git config --global color.ui true

    ###############################################################################
    # Install Applications                                                        #
    ###############################################################################


    echo "Setup ssh"
    ssh-keygen -t rsa

   exit

   echo "Setup real_sync"
   mkdir ~/.DklabRealsync
   git clone https://github.com/DmitryKoterov/dklab_realsync.git ~/.DklabRealsync


  echo "Install composer"
  mkdir ~/.TempSetup
  cd ~/.TempSetup
  php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
  php -r "if (hash_file('SHA384', 'composer-setup.php') === '669656bab3166a7aff8a7506b8cb2d1c292f042046c5a994c43155c0be6190fa0355160742ab2e1c88d40d5be660b410') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
  php composer-setup.php
  php -r "unlink('composer-setup.php');"
  mv composer.phar /usr/local/bin/composer
  rm -rf ~/.TempSetup

  exit

    # Install Homebrew
    echo "Installing Homebrew"
#    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

    clear
    # Install Homebrew Apps
    #echo "Installing Homebrew Command Line Tools"
    #brew install \
    #mc \
    #wget \
    #htop

    brew tap caskroom/cask

    echo "Installing Apps"
    brew cask install \
    iterm2 \
    sublime-text \
    sequel-pro \
    phpstorm \
    google-chrome \
    firefox \
    telegram \
    vlc \
    dropbox \
    smartgit \
    istat-menus

exit
    echo "Cleaning Up Cask Files"
    brew cask cleanup

    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

    clear

    echo "${GREEN}Thanks for using DevMyMac! If you liked it, make sure to go to the Github Repo (https://github.com/adamisntdead/DevMyMac) and Star it! If you have any issues, just put them there, and all suggestions and contributions are appreciated!"

else
   echo "Need to install the OSX Command Line Tools (or XCode) First! Starting Install..."
   # Install XCODE Command Line Tools
   xcode-select --install
fi