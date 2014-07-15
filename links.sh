#!/bin/sh

# Creates required directories and symbolic links to the files in this
# repository, in the required locations. Run with "sh links.sh".

# Command-line related things
ln --symbolic --verbose gitconfig $HOME/.gitconfig
ln --symbolic --verbose hgrc $HOME/.hgrc
ln --symbolic --verbose zshrc $HOME/.zshrc

# X.Org related things
ln --symbolic --verbose xinitrc $HOME/.xinitrc
ln --symbolic --verbose Xresources $HOME/.Xresources
ln --symbolic --verbose gtkrc-2.0 $HOME/.gtkrc-2.0
mkdir --parents --verbose $HOME/.config/fontconfig/
ln --symbolic --verbose fonts.conf $HOME/.config/fontconfig/fonts.conf

# i3WM config file
mkdir --parents --verbose $HOME/.i3/
ln --symbolic --verbose i3config $HOME/.i3/config

# XMonad related things
mkdir --parents --verbose $HOME/.xmonad/
ln --symbolic --verbose xmonad.hs $HOME/.xmonad/xmonad.hs
ln --symbolic --verbose conkyrc $HOME/.conkyrc

# Openbox related things
ln --symbolic --verbose pypanelrc $HOME/.pypanelrc
mkdir --parents --verbose $HOME/.config/openbox/
ln --symbolic --verbose autostart $HOME/.config/openbox/autostart
ln --symbolic --verbose menu.xml $HOME/.config/openbox/menu.xml
ln --symbolic --verbose rc.xml $HOME/.config/openbox/rc.xml

# Other
mkdir --parents --verbose $HOME/.config/zathura/
ln --symbolic --verbose zathurarc $HOME/.config/zathura/zathurarc
