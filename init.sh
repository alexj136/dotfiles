#!/bin/sh
# Set up vim for usage after freshly pulling this repository.
ln -s ~/.vim/vimrc ~/.vimrc
mkdir -p ~/.vim/bundle/
mkdir -p ~/.vim/swapfiles/
mkdir -p ~/.config/nvim/
NVIM=~/.config/nvim/init.vim
touch $NVIM
echo 'set runtimepath^=~/.vim runtimepath+=~/.vim/after' > $NVIM
echo 'let &packpath = &runtimepath' >> $NVIM
echo 'source ~/.vimrc' >> $NVIM
git clone https://github.com/gmarik/Vundle.vim ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
