#!/usr/bin/env bash

# 1. Grab all sink names into an array
mapfile -t SINKS < <(pactl list short sinks | awk '{print $2}')

# 2. Figure out which sink is currently the default
CURRENT=$(pactl info | awk -F': ' '/Default Sink/ {print $2}')

# 3. Find its index, pick the next (wrap around), and switch
for i in "${!SINKS[@]}"; do
  if [[ "${SINKS[$i]}" == "$CURRENT" ]]; then
    NEXT="${SINKS[$(((i + 1) % ${#SINKS[@]}))]}"
    pactl set-default-sink "$NEXT"
    echo "Switched default sink → $NEXT"
    exit 0
  fi
done

# 4. If nothing matched (first run?), just pick the first sink
pactl set-default-sink "${SINKS[0]}"
echo "Switched default sink → ${SINKS[0]}"
