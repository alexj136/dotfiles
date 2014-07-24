#!/bin/sh

# Creates required directories and symbolic links to the files in this
# repository, in the required locations. Run with 'sh links.sh'. This script
# requires that the git repo exist at '$HOME/.dotfiles/'.

# Command-line related things
ln -s --verbose $HOME/.dotfiles/gitconfig $HOME/.gitconfig
ln -s --verbose $HOME/.dotfiles/hgrc $HOME/.hgrc
ln -s --verbose $HOME/.dotfiles/zshrc $HOME/.zshrc
ln -s --verbose $HOME/.dotfiles/bashrc $HOME/.bashrc

# X.Org related things
ln -s --verbose $HOME/.dotfiles/xinitrc $HOME/.xinitrc
ln -s --verbose $HOME/.dotfiles/Xresources $HOME/.Xresources
ln -s --verbose $HOME/.dotfiles/gtkrc-2.0 $HOME/.gtkrc-2.0
mkdir --parents --verbose $HOME/.config/fontconfig/
ln -s --verbose $HOME/.dotfiles/fonts.conf $HOME/.config/fontconfig/fonts.conf

# i3WM config file
mkdir --parents --verbose $HOME/.i3/
ln -s --verbose $HOME/.dotfiles/i3config $HOME/.i3/config

# XMonad related things
mkdir --parents --verbose $HOME/.xmonad/
ln -s --verbose $HOME/.dotfiles/xmonad.hs $HOME/.xmonad/xmonad.hs
ln -s --verbose $HOME/.dotfiles/conkyrc $HOME/.conkyrc

# Openbox related things
ln -s --verbose $HOME/.dotfiles/pypanelrc $HOME/.pypanelrc
mkdir --parents --verbose $HOME/.config/openbox/
ln -s --verbose $HOME/.dotfiles/autostart $HOME/.config/openbox/autostart
ln -s --verbose $HOME/.dotfiles/menu.xml $HOME/.config/openbox/menu.xml
ln -s --verbose $HOME/.dotfiles/rc.xml $HOME/.config/openbox/rc.xml

# Other
mkdir --parents --verbose $HOME/.config/zathura/
ln -s --verbose $HOME/.dotfiles/zathurarc $HOME/.config/zathura/zathurarc
