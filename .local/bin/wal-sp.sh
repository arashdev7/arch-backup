#!/usr/bin/env bash

# Remove existing wal theme using AWK
awk '
BEGIN { skip = 0 }
/\[\[themes\]\]/ {
    getline
    if ($0 ~ /name = "wal"/) {
        skip = 1
        next
    } else {
        print "[[themes]]"
        print
        next
    }
}
skip && /^\[\[themes\]\]/ { skip = 0 }
!skip
' ~/.config/spotify-player/theme.toml > ~/.config/spotify-player/theme.tmp && mv ~/.config/spotify-player/theme.tmp ~/.config/spotify-player/theme.toml

# Load wal colors
source ~/.cache/wal/colors.sh

# Append updated wal theme
cat <<EOF >> ~/.config/spotify-player/theme.toml

[[themes]]
name = "wal"
[themes.palette]
background = "$background"
foreground = "$foreground"
black = "$color0"
red = "$color1"
green = "$color2"
yellow = "$color3"
blue = "$color4"
magenta = "$color5"
cyan = "$color6"
white = "$color7"
bright_black = "$color8"
bright_red = "$color9"
bright_green = "$color10"
bright_yellow = "$color11"
bright_blue = "$color12"
bright_magenta = "$color13"
bright_cyan = "$color14"
bright_white = "$color15"
EOF


