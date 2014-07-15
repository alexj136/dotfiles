#!/bin/sh

# Creates required directories and symbolic links to the files in this
# repository, in the required locations. Run with "sh links.sh".

# i3wm config file
mkdir --parents --verbose $HOME/.i3/
ln --symbolic --verbose i3config $HOME/.i3/config
