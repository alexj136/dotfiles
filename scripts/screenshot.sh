#!/bin/sh

# Ensure the screenshots directory exists
mkdir -p $HOME/Pictures/screenshots

# Take the screenshot
scrot $HOME/Pictures/screenshots/%d-%m-%Y_%T.png
