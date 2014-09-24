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

# Get the screen width from $HOME/.screenwidth
screenwidth=$(<$HOME/.screenwidth)

# Load xterm settings
exec xrdb -merge ~/.Xresources &

# Run the network manager tray icon
exec nm-applet &

# Launch the screensaver daemon
exec xscreensaver -no-splash &

# System status bar - goes from the middle of the screen to the right, stopping
# 20 pixels away from the right-hand-side of the screen, leaving room for the
# system tray.
exec conky | dzen2 -x $((screenwidth / 2)) -y 0 -w $(((screenwidth / 2) - 20)) \
    -ta r -bg '#002b36' -fn 'Inconsolata:size=11' &

# System tray
exec trayer --edge top --align right --height 18 --widthtype pixel \
    --width 20 --expand true --transparent true --alpha 0 --tint 0x002b36 &

# Set desktop wallpaper
exec feh --bg-fill '/home/alex/docs/Gran_Canaria_by_ALF.jpg' &

# Run window manager selected by SLiM
exec $1
