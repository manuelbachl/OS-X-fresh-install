#!/bin/bash

# A script to set up a new mac. Uses bash, homebrew, etc.

# Focused for ruby/rails development. Includes many utilities and apps:
# - homebrew, rvm, node
# - quicklook plugins, terminal fonts
# - browsers: chrome, firefox
# - dev: iterm2, sublime text, postgres, chrome devtools, etc.
# - team: slack, dropbox, google drive, skype, etc
# - utils: unarchiver, o-day, caffine, skitch, etc
# - productivity: evernote, viscosity, omnigraffle, karabiner, etc.


# Settings
node_version="0.12.2"
ruby_versions="1.9 2.1 2.2"
ruby_default="2.1"

# helpers
function echo_ok { echo -e '\033[1;32m'"$1"'\033[0m'; }
function echo_warn { echo -e '\033[1;33m'"$1"'\033[0m'; }
function echo_error  { echo -e '\033[1;31mERROR: '"$1"'\033[0m'; }

echo_ok "Install starting. You may be asked for your password (for sudo)."

# requires xcode and tools!
xcode-select -p || exit "XCode must be installed! (use the app store)"

# requirements
cd ~
mkdir -p tmp
echo_warn "setting permissions..."
for dir in "/usr/local /usr/local/bin /usr/local/include /usr/local/lib /usr/local/share"; do
  sudo chgrp admin $dir
  sudo chmod g+w $dir
done

# homebrew
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
if hash brew &> /dev/null; then
  echo_ok "Homebrew already installed"
else
    echo_warn "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# RVM
if hash rvm &> /dev/null; then
  echo_ok "RVM already installed"
else
  echo "Installing RVM..."
  curl -sSL https://get.rvm.io | bash -s stable --ruby
fi

# add default gems to rvm
global_gems_config="$HOME/.rvm/gemsets/global.gems"
default_gems="bundler awesome-print lunchy rak"
for gem in $default_gems; do
  echo $gem >> $global_gems_config
done
awk '!a[$0]++' $global_gems_config > /tmp/global.tmp
mv /tmp/global.tmp $global_gems_config

# RVM ruby versions
for version in $ruby_versions; do
  rvm install $version
done

# moar homebrew...
brew install caskroom/cask/brew-cask
brew update && brew upgrade brew-cask && brew cleanup && brew cask cleanup

# brew taps
brew tap caskroom/versions
brew tap caskroom/fonts
brew tap homebrew/games

# Homebrew base
brew install \
  boost \
  cowsay \
  ecm \
  fortune \
  gettext glib glibmm gsasl \
  highlight \
  libffi libsigc++ libxml++ libxml++3 libxml2 libxslt lua \
  mysql \
  openssl \
  postgresql \
  readline \
  ssh-copy-id \
  wget

# brew cask fonts
echo_warn "Installing fonts..."
brew cask install \
  font-anonymous-pro \
  font-dejavu-sans-mono-for-powerline font-droid-sans font-droid-sans-mono font-droid-sans-mono-for-powerline \
  font-input font-inconsolata font-inconsolata-for-powerline \
  font-liberation-mono font-liberation-mono-for-powerline font-liberation-sans \
  font-meslo-lg \
  font-nixie-one \
  font-office-code-pro \
  font-pt-mono \
  font-roboto \
  font-source-code-pro font-source-code-pro-for-powerline font-source-sans-pro \
  font-ubuntu font-ubuntu-mono-powerline

# brew cask quicklook
echo_warn "Installing QuickLook Plugins..."
brew cask install \
  animated-gif-quicklook \
  epubquicklook \
  qlcolorcode qlimagesize qlmarkdown qlprettypatch qlstephen qlvideo quicklook-csv quicklook-json

# Apps
echo_warn "Installing applications..."
brew cask install \
  a-better-finder-rename appdelete \
  battle-net \
  caffeine cakebrew \
  dash divvy \
  firefox flux fontexplorer-x-pro \
  google-chrome \
  iterm2 \
  keeweb \
  little-snitch \
  micro-snitch \
  nylas-n1 \
  openoffice owncloud \
  phpstorm \
  quicksilver \
  rocket-chat \
  screaming-frog-seo-spider shuttle sketch sketch-toolbox skype slack spotify sublime-text3 \
  teamviewer the-unarchiver thunderbird tower transmit \
  vlc \
  xmind
  # 2be continued...


echo
echo_ok "Done."
echo
echo "You may want to add the following settings to your .bashrc:"
echo_warn '  export HOMEBREW_CASK_OPTS="--appdir=/Applications"'
echo