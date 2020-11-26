#!/bin/sh
# Script that takes screenshot with maim

output=$HOME/Pictures/screenshots/"$(date +%s_%h%d_%H:%M:%S).png"

case "$1" in
    "select_no_save") maim -s | xclip -selection clipboard -t image/png || exit;;
    "select_window") maim -i $(xdotool getactivewindow) | xclip -selection clipboard -t image/png || exit;;
    "select") maim -s | tee "$output" | xclip -selection clipboard -t image/png || exit ;;

esac
