#!/bin/bash

# Wait a second to ensure Kitty is ready
sleep 0.5

# Only show image if in Kitty and not tmux
if [[ $TERM == xterm-kitty && -z "$TMUX" ]]; then
  neofetch --image_backend kitty --image_source "$HOME/Downloads/your.png" --ascii_distro off
else
  neofetch
fi
