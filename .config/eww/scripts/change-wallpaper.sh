#!/bin/bash

SELECTED_WALLPAPER="$1"
WALLPAPER_DIR="$HOME/wallpapers"
WALLPAPER_PATH="$WALLPAPER_DIR/$SELECTED_WALLPAPER.jpg"

if [ ! -f "$WALLPAPER_PATH" ]; then
    echo "Wallpaper not found: $WALLPAPER_PATH"
    exit 1
fi

# Update hyprpaper
HYPRPAPER_CONF="$HOME/.config/hypr/hyprpaper.conf"
HYPRLOCK_CONF="$HOME/.config/hypr/hyprlock.conf"

MONITOR=$(hyprctl monitors -j | jq -r '.[0].name')

cat > "$HYPRPAPER_CONF" <<EOF
ipc = true
splash = false

wallpaper {
    monitor = $MONITOR
    path = $WALLPAPER_PATH
    fit_mode = cover
}
EOF

# Update hyprlock
sed -i \
  "s|path = .*|path = \$HOME/wallpapers/$SELECTED_WALLPAPER.jpg|" \
  "$HYPRLOCK_CONF"

# Reload UI/colors
~/zenities/.config/eww/scripts/update-color.sh "$SELECTED_WALLPAPER"

# Restart hyprpaper cleanly
pkill hyprpaper
hyprpaper &
