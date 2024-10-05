#!/bin/bash
if [ -d "/proc/acpi/button/lid" ]; then
	export IS_LAPTOP="true"
else
	xrandr --output DP-4 --mode 3440x1440 --rate 144.00
	# xrandr --output DP-2 --primary --mode 2560x1440 --pos 0x0 --output HDMI-0 --mode 1920x1080 --pos 2560x360
	# export DUAL_MONITOR="false"
fi

dbus-update-activation-environment --systemd DBUS_SESSION_BUS_ADDRESS DISPLAY XAUTHORITY

# Add .local/bin to path
export PATH="/home/daniel/.local/bin:$PATH"

export XDG_CURRENT_DESKTOP=qtile
qtile start
