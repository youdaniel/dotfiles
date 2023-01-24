#!/bin/bash
if [ -d "/proc/acpi/button/lid" ]
then
  export IS_LAPTOP="true"
else
  xrandr --output DP-0 --mode 3440x1440 --rate 144.00
fi

dbus-update-activation-environment --systemd DBUS_SESSION_BUS_ADDRESS DISPLAY XAUTHORITY

eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

# Add .local/bin to path
export PATH="/home/daniel/.local/bin:$PATH"

export XDG_CURRENT_DESKTOP=qtile
qtile start
