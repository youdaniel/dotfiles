#!/bin/bash
if [ -d "/proc/acpi/button/lid" ]; then
  export IS_LAPTOP="true"
else
  xrandr --output DP-0 --mode 5120x1440 --rate 240
fi

dbus-update-activation-environment --systemd DBUS_SESSION_BUS_ADDRESS DISPLAY XAUTHORITY

# Add .local/bin to path
export PATH="/home/daniel/.local/bin:$PATH"

export XDG_CURRENT_DESKTOP=qtile
qtile start
