#!/usr/bin/env bash
export DISPLAY=:0
export XAUTHORITY=/home/daniel/.Xauthority

#button mapping
sleep 1
xsetwacom set "Wacom Intuos BT S Pad pad" Button 1 "key Delete"
xsetwacom set "Wacom Intuos BT S Pad pad" Button 2 "key +ctrl +shift p -ctrl -shift"
xsetwacom set "Wacom Intuos BT S Pad pad" Button 3 "key +ctrl +shift a -ctrl -shift"
xsetwacom set "Wacom Intuos BT S Pad pad" Button 8 "key +ctrl +alt w -ctrl -alt"
