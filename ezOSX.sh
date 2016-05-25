#!/bin/bash

# helpers
function echo_task { echo -e '\033[1mTASK: '"$1"'\033[0m'; }
function echo_ok { echo -e '\033[33m'"$1"'\033[0m'; }
function echo_warn  { echo -e '\033[31mWARNING: '"$1"'\033[0m'; }

# Settings
node_version="0.12.2"
ruby_versions="1.9 2.1 2.2"
ruby_default="2.1"

echo_ok "Install starting. You may be asked for your password (for sudo)."

# requires xcode and tools!
echo "/// XCode"
echo_task "Checking if XCode is installed"
xcode-select -p || exit "XCode must be installed! (use the app store)"

# requirements
echo
echo "/// Requirements"
cd ~
mkdir -p tmp
echo_task "Setting permissions"
for dir in "/usr/local /usr/local/bin /usr/local/include /usr/local/lib /usr/local/share"; do
    sudo chgrp admin $dir
    sudo chmod g+w $dir
done

# homebrew
echo
echo_task "Checking if homebrew is installed"

grep -q -F 'export HOMEBREW_CASK_OPTS="--appdir=/Applications"' .bashrc || echo 'export HOMEBREW_CASK_OPTS="--appdir=/Applications"' >> .bashrc

if hash brew &> /dev/null; then
    echo_ok "Homebrew already installed"
else
    echo_task "Installing homebrew"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    echo_ok "Homebrew installed"
fi

# more homebrew
echo
echo_task "Install cask"
brew install caskroom/cask/brew-cask
echo_ok "Cask installed"

echo
echo_task "Update and cleanup"
brew update && brew upgrade brew-cask && brew cleanup && brew cask cleanup
echo_ok "Updated and cleaned up"

# brew taps
echo
echo_task "Brew taps"
brew tap caskroom/versions
brew tap caskroom/fonts
brew tap homebrew/games
echo_ok "Taps done"

cd ~-

# install brew formulae
echo
echo "/// Install formulae"
read -p "Do you want to install your brew formulae (defined in .config/tools.brew)? <y/n> " prompt
if [[ $prompt == "y" || $prompt == "Y" || $prompt == "yes" || $prompt == "Yes" ]]
then
    echo
    bash UtilityScripts/Homebrew.sh
fi

# Install cask fonts
echo
echo "/// Install fonts"
read -p "Do you want to install your apps (defined in .config/fonts.cask)? <y/n> " prompt
if [[ $prompt == "y" || $prompt == "Y" || $prompt == "yes" || $prompt == "Yes" ]]
then
    echo
    bash UtilityScripts/Cask.sh -f
fi

# Install cask apps
echo
echo "/// Install apps"
read -p "Do you want to install your apps (defined in .config/apps.cask)? <y/n> " prompt
if [[ $prompt == "y" || $prompt == "Y" || $prompt == "yes" || $prompt == "Yes" ]]
then
    echo
    bash UtilityScripts/Cask.sh -a
fi

# Install zsh plugins
echo
echo "/// Install zsh plugins"
read -p "Do you want to install your zsh plugins (defined in .config/plugins.zsh)? <y/n> " prompt
if [[ $prompt == "y" || $prompt == "Y" || $prompt == "yes" || $prompt == "Yes" ]]
then
    echo
    bash UtilityScripts/oh-my-zsh.sh
fi

# Starting Updater
echo
echo "/// Updater"
read -p "Do you want to update the packages? <y/n> " prompt
if [[ $prompt == "y" || $prompt == "Y" || $prompt == "yes" || $prompt == "Yes" ]]
then
    echo
    bash UtilityScripts/Updater.sh
fi

echo
echo
echo_ok "/// Setup finished"
echo_ok "Have fun with your new Mac"
echo
echo




# TODO: Als command definierbar machen (PATH-Variable)
# TODO: Switch nach parametern (wenn als command hinterlegt
# TODO: Abfrage ob ein Cronjob eingerichtet werden soll
# TODO: Abfrage ob das Updatescript in die .bash_profile geschrieben werden soll (Script schreiben)