#!/bin/sh
# Get the Luakit adblock list if it doesn't already exist
mkdir -p $HOME/.local/share/luakit
wget --output-document=$HOME/.local/share/luakit/easylist.txt \
    https://easylist-downloads.adblockplus.org/easylist.txt
