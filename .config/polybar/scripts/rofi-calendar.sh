#!/bin/bash
# Save as ~/.config/polybar/scripts/rofi-calendar.sh

date '+%H:%M'

case "$1" in
    --popup)
        rofi -modi "calendar:~/.config/polybar/scripts/calendar.sh" -show calendar
        ;;
esac
