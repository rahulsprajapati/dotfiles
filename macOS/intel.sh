#!/usr/bin/env bash

echo "Executing setup on native Intel..."

echo "Installing Homebrew..."
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "Updating homebrew..."
brew update

echo "Installing brew packages..."

echo "installing wget..."
brew install wget

echo "installing tree..."
brew install tree

echo "installing tmux..."
brew install tmux

echo "installing tmate..."
brew install tmate

echo "installing composer..."
brew install composer

echo "installing curl..."
brew install curl

echo "installing git..."
brew install git

echo "installing bash..."
brew install bash

echo "installing rsync..."
brew install rsync

echo "installing yarn..."
brew install yarn && yarn global add nodemon

echo "installing bash-completion..."
brew install bash-completion

echo "installing zsh..."
brew install zsh

echo "-- Brew cleanup."
brew cleanup

echo "installing iterm2..."
brew install iterm2

echo "installing sublime-text..."
brew install sublime-text

echo "installing google-chrome..."
brew install google-chrome

echo "installing firefox..."
brew install firefox

echo "installing 1password..."
brew install 1password

echo "installing slack..."
brew install slack

echo "installing docker..."
brew install docker

echo "installing zoom..."
brew install zoomus

echo "installing whatsapp..."
brew install whatsapp

echo "installing sequel-pro..."
brew install sequel-pro

echo "installing authy..."
brew install authy

echo "installing vlc..."
brew install vlc

echo "installing skitch..."
brew install skitch

echo "installing jetbrains-toolbox..."
brew install jetbrains-toolbox

echo "installing alfred..."
brew install alfred

#echo "Brew cleanup."
echo "-- Brew cleanup."
brew cleanup

echo "Installing nvm"
brew install nvm
source ~/.bashrc
nvm --version
nvm install --lts

echo "Setting up zsh config..."
RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
sed -i -e  's/robbyrussell/fino/g' ~/.zshrc
sed -i -e  's/plugins=(git)/plugins=(git colored-man-pages colorize pip python brew osx z docker)/g' ~/.zshrc
cp "$PWD/common/bash-helpers.sh" ~/bash-helpers.sh
echo "source ~/bash-helpers.sh" >> ~/.zshrc
chsh -s $(which zsh)

echo "Setting up github config"
git config --global user.name "Rahul Prajapati"
git config --global user.email "rahul.prajapati@live.in"

echo "Updating vim editor config"
git clone https://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh

echo "Setting up mac config..."

echo "Require password immediately after sleep or screen saver begins"
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

echo "Save screenshots to the desktop"
mkdir "$HOME/Screenshots"

defaults write com.apple.screencapture location -string "$HOME/Screenshots"

echo "Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)"
defaults write com.apple.screencapture type -string "png"

echo "Finder: show all filename extensions"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

echo "Finder: show status bar"
defaults write com.apple.finder ShowStatusBar -bool true

echo "Finder: show path bar"
defaults write com.apple.finder ShowPathbar -bool true

echo "Finder: allow text selection in Quick Look"
defaults write com.apple.finder QLEnableTextSelection -bool true

echo "Display full POSIX path as Finder window title"
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

echo "When performing a search, search the current folder by default"
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

echo "Avoid creating .DS_Store files on network volumes"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

echo "Update default mac shortcut key. i.e change sportlight to option+space to use command+space for alfred"
wget --no-check-certificate https://drive.google.com/uc?export=download&id=1WLsfBRqdzVw2V0t4dVUm5oHBSmnbsSll -qO symbolichotkeys.plist
defaults import com.apple.symbolichotkeys symbolichotkeys.plist

echo "Setting up code sniffer..."

composer g require --dev phpcompatibility/php-compatibility automattic/vipwpcs dealerdirect/phpcodesniffer-composer-installer

echo 'export PATH="$PATH:$HOME/.composer/vendor/bin"' >> ~/.zshrc

$HOME/.composer/vendor/bin/phpcs --version

$HOME/.composer/vendor/bin/phpcbf --version

$HOME/.composer/vendor/bin/phpcs -i

mkdir ~/.ssh/

wget -qO ~/.ssh/id_rsa.pub https://github.com/rahulsprajapati.keys

say "Hello Rahul, Please add your private ssh key now."

vi ~/.ssh/id_rsa

chmod 400 ~/.ssh/*

echo "Download Licecap for gif screenshot."
wget -qO ~/Downloads/licecap131.dmg https://www.cockos.com/licecap/licecap131.dmg

source ~/.zshrc
