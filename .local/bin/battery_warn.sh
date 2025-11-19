#!/bin/bash

# Paths to battery info
BAT_PATH="/sys/class/power_supply/BAT1"
AC_PATH="/sys/class/power_supply/ACAD"

# Read battery capacity (percentage)
capacity=$(cat "$BAT_PATH/capacity")

# Read battery charging status (Charging, Discharging, Full, etc.)
status=$(cat "$BAT_PATH/status")

# You can also check AC adapter directly if needed:
# ac_online=$(cat "$AC_PATH/online")  # 1 = plugged in, 0 = unplugged

# Set the warning threshold
threshold=10

# Check: battery is below threshold and NOT charging
if [ "$capacity" -le "$threshold" ] && [ "$status" = "Discharging" ]; then
    dunstify -u critical \
             -h string:x-dunst-stack-tag:battery \
             -h int:value:"$capacity" \
             "⚠ Battery Low" "Charge your laptop! ($capacity%)"
fi
