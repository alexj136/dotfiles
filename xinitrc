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

# Run the network manager tray icon
exec nm-applet &

# Launch the screensaver daemon
exec xscreensaver -no-splash &

# Set desktop wallpaper
exec feh --bg-fill '/home/alex/docs/Gran_Canaria_by_ALF.jpg' &

# Run window manager selected by SLiM
exec $1
