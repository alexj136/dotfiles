#!/bin/sh
# Set up vim for usage after freshly pulling this repository.
ln -s ~/.vim/vimrc ~/.vimrc
mkdir -p ~/.vim/bundle/
git clone https://github.com/gmarik/Vundle.vim ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
