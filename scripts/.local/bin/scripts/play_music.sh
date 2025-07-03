#!/bin/sh

# Music directory (adjust to match MPD's music_directory)
MUSIC_DIR="$HOME/Music"

mpc update >/dev/null

# Find only leaf directories (no subdirectories), follow symlinks
selected_folder=$(find "$MUSIC_DIR"/m "$MUSIC_DIR"/slsk -mindepth 2 -type d -follow \
  | sed "s|^$MUSIC_DIR/||" \
  | grep -Ev '^(Music/?|slsk$)' \
  | fzf -d '/' --nth '-1' --with-nth '{-2}      {-1}' --no-unicode --no-info --pointer="" --separator="" --no-scrollbar --no-border --margin='20%' --color="bw")
  # | fzf  -d '/' --nth '-1' --with-nth '{-2}       {-1}')

# Exit if no folder was selected
[ -z "$selected_folder" ] && echo "No selection. Exiting." && exit 1

# Clear current playlist
mpc clear >/dev/null

# Add folder and play
mpc add "$selected_folder" >/dev/null
mpc play >/dev/null
