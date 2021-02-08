#!/bin/bash

function run {
  if ! pgrep $1 ;
  then
    $@ &
  fi
}

run /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
run feh --bg-scale $HOME/Pictures/wallpaper.png
run picom
run xss-lock slock
run dunst
run redshift
run lightcord
run slack
