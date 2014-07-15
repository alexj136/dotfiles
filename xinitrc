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

if [ "$HOSTNAME" == "Alex-ThinkPad" ]; then
    # System status bar
    exec conky | dzen2 -x 800 -y 0 -w 780 -ta r -bg '#002b36' \
        -fn 'Inconsolata:size=11' &
    # System tray
    exec trayer --edge top --align right --height 18 --widthtype pixel \
        --width 20 --expand true --transparent true --alpha 0 --tint 0x002b36 &

elif [ "$HOSTNAME" == "Alex-Desktop" ]; then
    # Screen resolution
    exec xrandr --output HDMI-0 --mode 1920x1080 --primary --left-of DVI-0 \
        --output DVI-0 --mode 1280x1024 &
    wait $!
    # System status bar
    exec conky | dzen2 -x 960 -y 0 -w 960 -ta r -bg '#002b36' \
        -fn 'Inconsolata:size=11' &

else
    # Write a file to the home folder with the unrecognised hostname
    echo "Hostname $HOSTNAME not recognised" > ~/xinitErr &
fi

# Set desktop wallpaper
exec feh --bg-fill '/home/alex/docs/Gran_Canaria_by_ALF.jpg' &

# Run window manager selected by SLiM
exec xmonad
