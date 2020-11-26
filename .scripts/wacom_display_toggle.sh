#!/bin/bash
temp="/home/daniel/.scripts/wacom_display_toggle.tmp"

if [[ ! -e $temp ]]
then
  echo "HEAD-1">"$temp"
fi

display=`head -1 $temp`
echo "$display"

if [[ $display == "HEAD-0" ]]
then 
  echo "HEAD-1">"$temp"
  xsetwacom set "Wacom Intuos BT S Pen stylus" MapToOutput HEAD-1
  notify-send "Wacom tablet set to right monitor"
fi

if [[ $display == "HEAD-1" ]]
then 
  echo "BOTH">"$temp"
  xsetwacom set "Wacom Intuos BT S Pen stylus" MapToOutput 4480x1440+0+0
  notify-send "Wacom tablet set to both monitors"
fi

if [[ $display == "BOTH" ]]
then 
  echo "HEAD-0">"$temp"
  xsetwacom set "Wacom Intuos BT S Pen stylus" MapToOutput HEAD-0
  notify-send "Wacom tablet set to left monitor"
fi
