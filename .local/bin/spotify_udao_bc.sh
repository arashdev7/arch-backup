#!/bin/bash

# Kill existing instances
pkill -x spotifyd 2>/dev/null
pkill -x glava 2>/dev/null
pkill -x spotify_player 2>/dev/null

# Launch spotifyd in background
spotifyd & disown

# Wait for it to be ready for playerctl
for i in {1..10}; do
    sleep 0.5
    if playerctl -p spotifyd status &>/dev/null; then
        break
    fi
done

# Launch spotify_player in Kitty (disowned to not block script)
kitty --class spotifyplayer -e spotify_player & disown

# Delay to let Kitty window appear
sleep 1

# Launch Glava as a desktop background visualizer (fully detached)
setsid glava --desktop --force-mod=bars > /dev/null 2>&1 & disown

# Refocus Spotify window, if needed
hyprctl dispatch focuswindow class:^(spotifyplayer)$ & disown

exit 0

