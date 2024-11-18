#!/bin/bash

function run {
	if ! pgrep $1; then
		$@ &
	fi
}

run /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
run ibus-daemon -drxR
run variety
run picom --no-fading-openclose
run xss-lock slock
run dunst
run nm-applet
run blueman-applet
run redshift
run discord
run spotify

if [ "$IS_LAPTOP" == "true" ]; then
	run libinput-gestures-setup start
else
	run gwe --hide-window
fi
