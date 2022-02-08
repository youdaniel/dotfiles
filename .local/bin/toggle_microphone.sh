#!/bin/sh

state=`amixer set Capture toggle | gawk 'match($0, /Mono.*\[(.*)\]/, a) {print a[1]}'`
notify-send "Mic $state"
