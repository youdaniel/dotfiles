#!/bin/sh

case "$1" in
  "toggle") amixer set Capture toggle || exit;;
  "status") amixer | gawk 'match($0, /Mono.*\[(.*)\]/, a) {print a[1]}' || exit;;
esac
