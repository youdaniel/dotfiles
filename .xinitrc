#!/bin/bash
if [ -d "/proc/acpi/button/lid" ]; then
  export IS_LAPTOP="true"
fi

# xrandr --output HDMI-0 --mode 1920x1080 --pos 2560x360 --rotate normal --output DP-2 --primary --mode 2560x1440 --pos 0x0 --rotate normal
xrandr --output DP-0 --mode 3440x1440 --rate 144.00
dbus-update-activation-environment --systemd DBUS_SESSION_BUS_ADDRESS DISPLAY XAUTHORITY

eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK
export XDG_CURRENT_DESKTOP=qtile

# Add .local/bin to path
export PATH="/home/daniel/.local/bin:$PATH"

qtile start
