#!/bin/bash
# Save as ~/.config/polybar/scripts/calendar.sh

cal -m | sed "s/\b$(date +%e)\b/**\0**/g"
