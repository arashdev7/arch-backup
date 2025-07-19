#!/bin/bash
set -e

# Use the already cloned repo as the backup directory
BACKUP_DIR=~/arch-backup

echo ">>> Ensuring necessary folders exist"
mkdir -p "$BACKUP_DIR/.config"
mkdir -p "$BACKUP_DIR/.local/bin"

echo ">>> Backing up core dotfiles"
cp ~/.gitconfig ~/.gtkrc-2.0 ~/.fehbg "$BACKUP_DIR"

echo ">>> Backing up zsh + tmux configs (resolving symlinks)"
cp -L ~/.zshrc ~/.p10k.zsh ~/.tmux.conf "$BACKUP_DIR"

echo ">>> Backing up selected .config directories"
CONFIGS=(hypr kitty eww waybar wal bottom dunst glava htop qt5ct rofi spotify-player spotifyd wofi yazi
         gtk-3.0 gtk-4.0)

for cfg in "${CONFIGS[@]}"; do
    SRC=~/.config/$cfg
    DEST=$BACKUP_DIR/.config/$cfg
    [ -e "$SRC" ] || continue
    [ -L "$SRC" ] && SRC=$(readlink -f "$SRC")
    rsync -a --delete "$SRC/" "$DEST/"
done

echo ">>> Backing up local bin scripts"
rsync -a --delete ~/.local/bin/ "$BACKUP_DIR/.local/bin/"

echo ">>> Saving package list"
pacman -Qqe > "$BACKUP_DIR/pkglist.txt"
yay -Qqe > "$BACKUP_DIR/aur-packages.txt"  # or paru if you use that

echo ">>> Git commit"
cd "$BACKUP_DIR"
git add .
git commit -m "Backup on $(date)" || echo "No changes to commit."
git push

echo "✅ Backup complete."
