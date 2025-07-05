#!/usr/bin/env bash
# Improved weather-fetching script with JSON output for Waybar
# Repository: https://github.com/JaKooLit/weather-script

set -euo pipefail
IFS=$'\n\t'

# Default configuration
CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/weather-script"
CACHE_TTL=1740 # 29 minutes
UNIT="u"       # m=metric, u=US, M=UK
FORMAT="%C %t" # wttr.in format string: condition and temperature
CITY_FILE="${XDG_CACHE_HOME:-$HOME/.cache}/waybar_weather_city"
CITY="" # Default to empty for IP-based geolocation or read from file

usage() {
  cat <<EOF
Usage: ${0##*/} [-c CITY] [-u UNIT] [-f FORMAT] [-t TTL]
            -c CITY   City name (default: read from $CITY_FILE or IP-based geolocation)

Options:
  -c CITY   City name (default: IP-based geolocation)
  -u UNIT   Units: m=metric, u=US, M=UK (default: $UNIT)
  -f FORMAT wttr.in format (default: "$FORMAT").
            e.g. "%C %t" = condition and temperature
                 "%l:+%C+%t+%w" = location, condition, temp, wind
  -t TTL    Cache time-to-live in seconds (default: $CACHE_TTL)
  -h        Show this help message
EOF
  exit 1
}

while getopts "c:u:f:t:h" opt; do
  case "$opt" in
  c) CITY="$OPTARG" ;;
  u) UNIT="$OPTARG" ;;
  f) FORMAT="$OPTARG" ;;
  t) CACHE_TTL="$OPTARG" ;;
  h) usage ;;
  *) usage ;;
  esac
done

# If CITY not provided via argument, try to read from file
if [[ -z "$CITY" ]]; then
  if [[ -f "$CITY_FILE" && -s "$CITY_FILE" ]]; then
    CITY=$(cat "$CITY_FILE")
  else
    # Fallback to a default city if file doesn't exist or is empty
    CITY="Jericho" # You can change this default city
  fi
fi

# URL-encode function
urlencode() {
  local s="$1"
  printf '%s' "$s" | od -An -tx1 | tr ' ' '%' | tr -d '\n' | sed 's/%0a//g'
}

# Prepare cache directory and key
mkdir -p "$CACHE_DIR"
# Determine cache key based on whether a city is explicitly set
if [[ -n "$CITY" ]]; then
  CACHE_KEY="$(printf "%s|%s|%s|%s" "$CITY" "$UNIT" "$FORMAT" "$CACHE_TTL" | md5sum | cut -d' ' -f1)"
else
  # If CITY is still empty (shouldn't happen with the new logic but as a failsafe)
  CACHE_KEY="$(printf "%s|%s|%s" "IP_GEOLOCATION" "$UNIT" "$FORMAT" | md5sum | cut -d' ' -f1)"
fi
CACHE_FILE="$CACHE_DIR/$CACHE_KEY"

# Serve from cache if fresh
if [[ -f "$CACHE_FILE" ]]; then
  age=$(($(date +%s) - $(stat -c '%Y' "$CACHE_FILE")))
  if ((age < CACHE_TTL)); then
    cat "$CACHE_FILE"
    exit 0
  fi
fi

# Build URL with proper encoding
ENC_FORMAT="$(urlencode "$FORMAT")"
# Use the CITY variable, which now either comes from -c, the file, or the default
ENC_CITY="$(urlencode "$CITY")"
URL="https://wttr.in/${ENC_CITY}?${UNIT}nT&format=${ENC_FORMAT}"

# Fetch plain text response
if ! response=$(curl -fsSL "$URL"); then
  echo "Error: Failed to fetch weather data from $URL" >&2
  exit 2
fi

# Parse response: e.g. "Clear 20°C"
temp="${response##* }"
condition="${response% $temp}"

# Map condition to emoji
case "${condition,,}" in
*clear* | *sunny*) emoji="☀️" ;;
*partly*cloudy* | *cloudy*) emoji="⛅️" ;;
*overcast*) emoji="☁️" ;;
*rain* | *drizzle*) emoji="🌧️" ;;
*storm* | *thunder*) emoji="⛈️" ;;
*snow*) emoji="❄️" ;;
*fog* | *mist* | *haze*) emoji="🌫️" ;;
*) emoji="🌡️" ;;
esac

# Prepare JSON fields
# Display city, emoji, and temperature in the text field
text="${emoji} ${temp}"
alt="$condition: $temp (${CITY})"
tooltip="$condition: $temp (${CITY})"

# Output JSON for Waybar and cache
printf '{"text":"%s","alt":"%s","tooltip":"%s"}\n' \
  "$text" "$alt" "$tooltip" >"$CACHE_FILE"
echo "$(cat $CACHE_FILE)"
