#!/bin/sh
xrandr --output HDMI-0 --mode 1920x1080 --pos 2560x360 --rotate normal --output DP-4 --primary --mode 2560x1440 --pos 0x0 --rotate normal

eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

qtile start
