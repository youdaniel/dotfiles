#!/bin/bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

run feh --bg-scale $HOME/Pictures/wallpaper.png
run picom &
run light-locker &
run dunst &
run /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
run setxkbmap -option compose:rctrl

run redshift &
run lightcord
run slack
