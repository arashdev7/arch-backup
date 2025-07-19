#!/bin/bash

# Variables
SELECTED_WALLPAPER=$1
WALLPAPER_DIR="$HOME/wallpapers"

# Ensure the wallpaper exists
if [ ! -f "$WALLPAPER_DIR/$SELECTED_WALLPAPER.jpg" ]; then
    echo "Error: Wallpaper not found: $SELECTED_WALLPAPER"
    exit 1
fi

# Apply pywal colors
wal -i "$WALLPAPER_DIR/$SELECTED_WALLPAPER.jpg" || { echo "Error: pywal failed"; exit 1; }


# Restart hyprpaper
killall hyprpaper || echo "Warning: No hyprpaper process found"
hyprpaper &

# Reload eww
killall eww || echo "Warning: No eww process found"
eww open-many side-bar notifications

sleep 1

# Update Spotify Player theme
    pkill spotify_player
    pkill glava

    ~/.local/bin/wal-sp.sh || echo "Warning: wal-sp.sh failed"
    ~/.local/bin/wal-glava.sh || echo "Warning: wal-glava.sh failed"


#relauch spotify_player
/home/Deboo/.local/bin/spotify_udao_bc_waal.sh  || echo "Warning: spotify_udao_bc_waal.sh failed" 

# firefox 
pywalfox update
