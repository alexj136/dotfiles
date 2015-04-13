#!/bin/sh

# Ensure the screenshots directory exists
mkdir -p $HOME/Pictures/screenshots

# Make the screenshots directory the current
pushd $HOME/Pictures/screenshots > /dev/null

# Take the screenshot
scrot '%d-%m-%Y_%T.png'

# Return to the initial directory
popd > /dev/null
