#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# Load xterm settings
exec xrdb -merge ~/.Xresources &

# Run the network manager applet
exec nm-applet &

# Launch the screensaver daemon
exec xautolock -time 20 -locker "i3lock -e -c 002b36" &

# Set desktop wallpaper
exec nitrogen --restore &

# Run the emoji picker applet if installed (AUR emojione-picker-git package)
if hash emojione-picker 2>/dev/null; then
    exec emojione-picker &
fi

# Source a machine-local xinitrc if one exists
if [ -e "$HOME/.xinitrc.local" ]; then
    sh "$HOME/.xinitrc.local"
fi

# Run window manager selected by SLiM
exec $1
