#!/usr/bin/env bash

# Paths
WAL_COLORS="$HOME/.cache/wal/colors.sh"
GLAVA_BARS="$HOME/.config/glava/bars.glsl"

# Check if wal colors exist
if [ ! -f "$WAL_COLORS" ]; then
    echo "❌ $WAL_COLORS not found. Run 'wal -i wallpaper' first."
    exit 1
fi

# Source Pywal colors
source "$WAL_COLORS"

# Helper: Convert hex to vec3
hex_to_vec3() {
    hex=${1#"#"}
    r=$((16#${hex:0:2}))
    g=$((16#${hex:2:2}))
    b=$((16#${hex:4:2}))
    printf "vec3(%.3f, %.3f, %.3f)" \
        "$(echo "scale=3; $r / 255" | bc -l)" \
        "$(echo "scale=3; $g / 255" | bc -l)" \
        "$(echo "scale=3; $b / 255" | bc -l)"
}

# Convert colors
accent_1=$(hex_to_vec3 "$color1")     # red
accent_2=$(hex_to_vec3 "$color4")     # blue
bg_color=$(hex_to_vec3 "$background")
fg_color=$(hex_to_vec3 "$foreground")

# Clean insert block
NEW_BLOCK=$(cat <<EOF
// WAL-COLORS-START
uniform vec3 accent_1 = $accent_1;
uniform vec3 accent_2 = $accent_2;
uniform vec3 bg_color  = $bg_color;
uniform vec3 fg_color  = $fg_color;
// WAL-COLORS-END
EOF
)

# Replace block in bars.glsl safely
awk -v new="$NEW_BLOCK" '
BEGIN { in_block=0 }
/\/\/ WAL-COLORS-START/ { print new; in_block=1; next }
/\/\/ WAL-COLORS-END/ { in_block=0; next }
!in_block { print }
' "$GLAVA_BARS" > "$GLAVA_BARS.tmp" && mv "$GLAVA_BARS.tmp" "$GLAVA_BARS"

echo "✅ Cleanly updated colors in $GLAVA_BARS"




