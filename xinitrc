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

# System status bar
exec conky | dzen2 -x 800 -y 0 -w 780 -ta r -bg '#002b36' \
    -fn 'Inconsolata:size=11' &

# System tray
exec trayer --edge top --align right --height 18 --widthtype pixel \
    --width 20 --expand true --transparent true --alpha 0 --tint 0x002b36 &

# Set desktop wallpaper
exec feh --bg-fill '/home/alex/docs/Gran_Canaria_by_ALF.jpg' &

# Run window manager selected by SLiM
exec xmonad
