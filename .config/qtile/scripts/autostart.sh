#!/bin/bash

function run {
  if ! pgrep $1 ;
  then
    $@ &
  fi
}

run /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
run ibus-daemon -drxR
run variety
run picom
run xss-lock slock
run dunst
run nm-applet
run blueman-applet
run redshift
run discord
run slack

if [ "$IS_LAPTOP" == "true" ]; then
  run libinput-gestures-setup start
else
  run gwe --hide-window
fi
