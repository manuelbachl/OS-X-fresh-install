

brew install \
  boost \
  cowsay \
  ecm \
  fortune \
  gettext glib glibmm gsasl \
  highlight \
  jq \
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

# brew cask quicklook
echo_warn "Installing QuickLook Plugins..."
brew cask install \










# Apps
echo_warn "Installing applications..."
brew cask install \
  # 2be continued...


echo
echo_ok "Done."
echo
echo "You may want to add the following settings to your .bashrc:"
echo_warn '  export HOMEBREW_CASK_OPTS="--appdir=/Applications"'
echo
echo
echo_warn "Please remember installing those apps manually:"
echo "Adobe Creative Cloud Apps"
echo "Feedly"
echo "MAMP Pro"
echo "Quiver"
echo "App for Whatsapp"
echo "CopyClip 2"
echo "Freechat for Facebook Messenger"
echo "Powermapper"
echo
echo
echo_warn "Don't forget installing needed Plugins inside apps"
echo "Firefox: Colorzilla, Disconnect, Firebug, HTTPS-Everywhere, MeasureIt, Screengrab, Self-Destructing Cookies, Undo Closed Tabs Button, Wappalyzer, Webdeveloper"
echo "Thunderbird: Lightning"