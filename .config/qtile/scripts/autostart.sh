#!/bin/bash

function run {
  if ! pgrep -x "$(basename "$1")" >/dev/null; then
    "$@" &
  fi
}

run /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
run ibus-daemon -drxR
run variety
run picom --no-fading-openclose
run xss-lock --ignore-xss slock
run xidlehook --not-when-fullscreen --not-when-audio --timer 300 'xset dpms force off' 'xset dpms force on' --timer 15 'slock' '' --timer 3600 'systemctl suspend' ''
run dunst
run nm-applet
run blueman-applet
run redshift
run discord
run spotify

if [ "$IS_LAPTOP" == "true" ]; then
  run libinput-gestures-setup start
fi
