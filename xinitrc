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

# Run the network manager & volume tray icons
exec nm-applet &
exec volumeicon &

# Launch the screensaver daemon
exec xautolock -time 20 -locker i3lock &

# Set desktop wallpaper
exec feh --bg-fill $HOME/Pictures/Gran_Canaria_by_ALF.jpg &

# Run window manager selected by SLiM
exec $1
