#!/bin/sh

# Creates required symbolic links to the files in this repository, in the
# required locations. Run with 'sh links.sh'. This script requires that the git
# repo exist at '$HOME/.dotfiles/' and must be executed there.

# Command-line related things
stow console

# X.Org related things
stow xorg-common

# i3WM config file
ln -s --verbose $HOME/.dotfiles/i3/ $HOME/.config/

# XMonad related things - conditional guard prevents a recursive symlink
if [ ! -d "$HOME/.xmonad" ]; then
    ln -s --verbose $HOME/.dotfiles/xmonad/ $HOME/.xmonad
fi

# Luakit
ln -s --verbose $HOME/.dotfiles/luakit/ $HOME/.config/
mkdir -p $HOME/.local/share/luakit
wget --output-document=$HOME/.local/share/luakit/easylist.txt \
    https://easylist-downloads.adblockplus.org/easylist.txt

# Openbox related things
ln -s --verbose $HOME/.dotfiles/pypanelrc $HOME/.pypanelrc
ln -s --verbose $HOME/.dotfiles/openbox/ $HOME/.config/

# Other
ln -s --verbose $HOME/.dotfiles/zathura/ $HOME/.config/
