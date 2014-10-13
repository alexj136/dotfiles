#!/bin/sh

# Creates required symbolic links to the files in this repository, in the
# required locations. Run with 'sh links.sh'. This script requires that the git
# repo exist at '$HOME/.dotfiles/'.

# Command-line related things
ln -s --verbose $HOME/.dotfiles/gitconfig $HOME/.gitconfig
ln -s --verbose $HOME/.dotfiles/hgrc $HOME/.hgrc
ln -s --verbose $HOME/.dotfiles/zshrc $HOME/.zshrc
ln -s --verbose $HOME/.dotfiles/bashrc $HOME/.bashrc

# X.Org related things
ln -s --verbose $HOME/.dotfiles/xinitrc $HOME/.xinitrc
ln -s --verbose $HOME/.dotfiles/Xresources $HOME/.Xresources
ln -s --verbose $HOME/.dotfiles/gtkrc-2.0 $HOME/.gtkrc-2.0
ln -s --verbose $HOME/.dotfiles/fontconfig $HOME/.config/

# i3WM config file
if [ ! -d "$HOME/.i3" ]; then # Conditional guard prevents a recursive symlink
    ln -s --verbose $HOME/.dotfiles/i3/ $HOME/.i3
fi

# XMonad related things
if [ ! -d "$HOME/.xmonad" ]; then
    ln -s --verbose $HOME/.dotfiles/xmonad/ $HOME/.xmonad
fi
ln -s --verbose $HOME/.dotfiles/conkyrc $HOME/.conkyrc

# Openbox related things
ln -s --verbose $HOME/.dotfiles/pypanelrc $HOME/.pypanelrc
ln -s --verbose $HOME/.dotfiles/openbox/ $HOME/.config/

# Other
ln -s --verbose $HOME/.dotfiles/zathura/ $HOME/.config/
