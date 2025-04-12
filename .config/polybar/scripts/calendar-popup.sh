#!/bin/bash
# Save as ~/.config/polybar/scripts/calendar-popup.sh

case "$1" in
    --popup)
        # Generate a calendar with the current date highlighted
        cal_output=$(cal -m | sed "s/\b$(date +%e)\b/<b>$(date +%e)<\/b>/")
        
        # Display as notification
        notify-send "Calendar" "$cal_output" -t 10000
        ;;
    *)
        # Just output the time for the bar
        date "+%H:%M"
        ;;
esac
