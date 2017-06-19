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
    # Git Settings                                                           #
    ###############################################################################
    clear

    echo -e "${RED}Please enter your name?${NC}"
    read name
    echo -e "${RED}Please enter your git email?${NC}"
    read email

    git config --global user.name "$name"

    git config --global user.email "$email"

    git config --global color.ui true

    git config --global core.excludesfile ~/git/gitignore 
    #git config --global init.templatedir ~/git/template
    git config --global branch.autosetuprebase always
    git config --global pull.rebase true
    git config --global commit.gpgSign false
    git config --global gc.autoDetach false

    mkdir ~/git
    cp ./gitignore ~/git/gitignore

    echo "${GREEN}##################   Setup ssh   ##################${NC}"
    ssh-keygen -t rsa

    echo "${GREEN}##################  Installing real_sync  ##################${NC}"
    mkdir ~/.DklabRealsync
    git clone https://github.com/DmitryKoterov/dklab_realsync.git ~/.DklabRealsync
    mkdir -p ~/Desktop/dev
    cp .realsync ~/Desktop/dev
    echo "${RED}Remote host to replicate to over SSH?${NC}"
    read host

    echo "host = ${host}:22" >> ~/Desktop/dev/.realsync

    echo "${GREEN}##################  Installing Composer  ##################${NC}"
    mkdir ~/.TempSetup
    cd ~/.TempSetup
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
    php -r "if (hash_file('SHA384', 'composer-setup.php') === '669656bab3166a7aff8a7506b8cb2d1c292f042046c5a994c43155c0be6190fa0355160742ab2e1c88d40d5be660b410') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
    php composer-setup.php
    php -r "unlink('composer-setup.php');"
    sudo mkdir -p /usr/local/bin
    sudo mv composer.phar /usr/local/bin/composer
    rm -rf ~/.TempSetup
    composer self-update

    ###############################################################################
    # Install Applications                                                        #
    ###############################################################################
    # Install Homebrew
    echo "Installing Homebrew"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

    clear
    # Install Homebrew Apps
    echo "Installing Homebrew Command Line Tools"
    brew install \
    mc \
    wget \
    htop

    brew tap caskroom/cask

    echo "Installing Apps"
    brew cask install \
    iterm2 \
    sublime-text \
    sequel-pro \
    phpstorm \
    google-chrome \
    firefox \
    smartgit 

    echo "Cleaning Up Cask Files"
    brew cask cleanup

    echo "${GREEN}All setup complete. We work hard, then we play hard ;)"

else
   echo "Need to install the OSX Command Line Tools (or XCode) First! Starting Install..."
   # Install XCODE Command Line Tools
   xcode-select --install
fi