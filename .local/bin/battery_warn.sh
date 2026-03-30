#!/bin/bash

export WAYLAND_DISPLAY=wayland-1
export XDG_RUNTIME_DIR="/run/user/$(id -u)"

while true; do
    BAT=$(find /sys/class/power_supply -maxdepth 1 -name 'BAT*' | head -n 1 | xargs basename)
    STATUS=$(cat /sys/class/power_supply/$BAT/status)
    CAPACITY=$(cat /sys/class/power_supply/$BAT/capacity)

    if [ "$STATUS" = "Discharging" ] && [ "$CAPACITY" -le 10 ]; then

        source "$HOME/.cache/wal/colors.sh"
        export BORDER="$color2"
        export FG="$color1"
        export CAPACITY

        FONT=$(fc-match monospace --format='%{family}' 2>/dev/null | cut -d, -f1)

        pw-play "$HOME/.local/bin/st_gate.mp3" 2>/dev/null || \
        paplay  "$HOME/.local/bin/st_gate.mp3" 2>/dev/null &

        foot --title="battery_warn" -o "font=${FONT}:size=16" -- bash -c "
            export TERM=xterm-256color
             printf '\n\n\n'
            /usr/bin/gum style \
                --border double \
                --border-foreground \"\$BORDER\" \
                --foreground \"\$FG\" \
                --padding '0 0' \
                --bold \
                '  🗲 BATTERY CRITICAL' \
                \"  \$CAPACITY% remaining — plug in now.\"
            sleep 60
        "

        sleep 10
    else
        sleep 60
    fi
done