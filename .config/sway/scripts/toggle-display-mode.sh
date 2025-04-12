#!/bin/bash
# ~/.config/sway/scripts/toggle-display-mode.sh

# Check if state file exists, create it if not
STATE_FILE=~/.config/sway/display_mode
if [ ! -f "$STATE_FILE" ]; then
    echo "extended" > "$STATE_FILE"
fi

# Read current mode from state file
CURRENT_MODE=$(cat "$STATE_FILE")

# Toggle between extended and duplicate modes
if [ "$CURRENT_MODE" = "extended" ]; then
    # Switch to duplicate mode
    swaymsg "output LVDS-1 mode 1366x768 position 0 0"
    swaymsg "output VGA-1 mode 1366x768 position 0 0"
    
    # Move all workspaces to primary display in duplicate mode
    for i in {1..10}; do
        swaymsg "workspace $i, move workspace to output LVDS-1"
    done
    
    echo "duplicate" > "$STATE_FILE"
    notify-send "Display Mode" "Switched to duplicate mode"
else
    # Switch to extended mode
    swaymsg "output LVDS-1 mode 1366x768 position 0 0"
    swaymsg "output VGA-1 mode 1280x1024 position -1280 0"
    
    # Return to the default workspace assignments from your config
    # Workspaces 1-9 go to primary, workspace 10 goes to secondary
    for i in {1..7}; do
        swaymsg "workspace $i, move workspace to output LVDS-1"
    done

    for i in {8..10}; do
        swaymsg "workspace $i, move workspace to output VGA-1"
    done
    
    echo "extended" > "$STATE_FILE"
    notify-send "Display Mode" "Switched to extended mode"
fi
