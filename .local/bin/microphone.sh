#!/bin/bash

pactl list short cards | grep -q PnP_Audio
exit_status=$?

if [[ "$IS_LAPTOP" == "true" && $exit_status == 1 ]]
then
  MIC="Front Left"
else
  MIC="Mono"
fi

case "$1" in
  "toggle") amixer set Capture toggle || exit;;
  "status") amixer get Capture | gawk 'match($0, /'"$MIC"'.*\[(.*)\]/, a) {print a[1]}' || exit;;
esac

