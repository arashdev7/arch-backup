#!/usr/bin/env bash

WAL_COLORS="$HOME/.cache/wal/colors.sh"
CAVA_CONFIG="$HOME/.config/cava/config"

# Make sure wal colors exist
if [[ ! -f "$WAL_COLORS" ]]; then
  echo "❌ No wal colors found at $WAL_COLORS"
  exit 1
fi

# Source wal palette
source "$WAL_COLORS"

# --- Update background ---
if grep -q "^background = " "$CAVA_CONFIG"; then
  sed -i "s|^background = .*|background = '$background'|" "$CAVA_CONFIG"
else
  sed -i "/^\[color\]/a background = '$background'" "$CAVA_CONFIG"
fi

# --- Update foreground ---
if grep -q "^foreground = " "$CAVA_CONFIG"; then
  sed -i "s|^foreground = .*|foreground = '$foreground'|" "$CAVA_CONFIG"
else
  sed -i "/^\[color\]/a foreground = '$foreground'" "$CAVA_CONFIG"
fi

# Update gradient_color_1 to gradient_color_8
for i in {1..8}; do
  color_var="color$i"
  color_val="${!color_var}"
  line="gradient_color_$i = '$color_val'"

  # If exists, replace it; else insert it under [color]
  if grep -q "^gradient_color_$i" "$CAVA_CONFIG"; then
    sed -i "s|^gradient_color_$i = .*|$line|" "$CAVA_CONFIG"
  else
    sed -i "/^\[color\]/a $line" "$CAVA_CONFIG"
  fi
done

echo "✅ Updated gradient colors for Cava using wal."

# Optional: Restart cava in a new terminal
if pgrep cava > /dev/null; then
  echo "🔁 Restarting cava..."
  pkill cava
  sleep 0.3
  setsid kitty -e cava & disown
fi
