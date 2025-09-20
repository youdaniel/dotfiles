#!/usr/bin/env bash

CITY_FILE="${XDG_CACHE_HOME:-$HOME/.cache}/waybar_weather_city"

# Prompt user for city using rofi
# Prompt user for city using rofi with aesthetic and size adjustments
# You can further customize with --theme <path/to/your/rofi/theme.rasi>
CITY=$(echo "" | rofi -dmenu -p "Enter city for weather" -theme Arc-Dark -l 0 -theme-str 'window { width: 20%; }')

if [[ -n "$CITY" ]]; then
  echo "$CITY" >"$CITY_FILE"
  # Signal Waybar to update the custom/weather module
  # Assuming Waybar listens for SIGRTMIN+8 or similar for custom modules
  pkill -RTMIN+8 waybar
fi
