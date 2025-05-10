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
CITY="Jericho"

usage() {
  cat <<EOF
Usage: ${0##*/} [-c CITY] [-u UNIT] [-f FORMAT] [-t TTL]

Options:
  -c CITY   City name (default: $CITY)
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

# URL-encode function
urlencode() {
  local s="$1"
  printf '%s' "$s" | od -An -tx1 | tr ' ' '%' | tr -d '\n' | sed 's/%0a//g'
}

# Prepare cache directory and key
mkdir -p "$CACHE_DIR"
CACHE_KEY="$(printf "%s|%s|%s|%s" "$CITY" "$UNIT" "$FORMAT" "$CACHE_TTL" | md5sum | cut -d' ' -f1)"
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
ENC_CITY="$(urlencode "$CITY")"
ENC_FORMAT="$(urlencode "$FORMAT")"
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
text="${emoji} ${temp}"
alt="$condition: $temp"
tooltip="$condition: $temp"

# Output JSON for Waybar and cache
printf '{"text":"%s","alt":"%s","tooltip":"%s"}\n' \
  "$text" "$alt" "$tooltip" >"$CACHE_FILE"
echo "$(cat $CACHE_FILE)"
