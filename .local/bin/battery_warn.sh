#!/bin/bash

# Get battery device (e.g., /org/freedesktop/UPower/devices/battery_BAT0)
battery=$(upower -e | grep battery)

# Exit if no battery is found
[ -z "$battery" ] && exit 1

# Get battery info
battery_info=$(upower -i "$battery")

# Extract percentage
percent=$(echo "$battery_info" | awk -F: '/percentage/ {gsub(/%/, "", $2); gsub(/^ +/, "", $2); print $2}')

# Extract state (charging/discharging/fully-charged)
state=$(echo "$battery_info" | awk -F: '/state/ {gsub(/^ +/, "", $2); print $2}')

# Round percent to integer
percent=${percent%.*}

# Test log (optional)
# echo "Battery: $percent%, State: $state"

# Set warning threshold here (use 80 to test)
threshold=80

# Show notification only if below threshold and discharging
if [[ "$state" == "discharging" && "$percent" -lt "$threshold" ]]; then
    notify-send -u critical -t 10000 "⚠️ Battery Low" "Battery at ${percent}%. Plug in your charger!"
fi
