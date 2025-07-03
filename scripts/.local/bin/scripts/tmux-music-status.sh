#!/bin/bash

MAX_LEN=50
STATE_FILE="/tmp/tmux-music-scroll-pos"

# Get playback state
state=$(mpc status | awk 'NR==2 {print $1}')
song=$(mpc current)

# Determine icon
case "$state" in
    "[playing]") icon="▶" ;;
    "[paused]")  icon="⏸" ;;
    *)           icon="⏹" ;;
esac

# Use fallback text if nothing is playing
song="${song:-No song playing}"

# Clean any newlines
song_clean=$(echo "$song" | tr -d '\n\r')

# Load scroll position
pos=0
if [[ -f "$STATE_FILE" ]]; then
    read -r pos < "$STATE_FILE"
fi

# If scrolling is needed
if (( ${#song_clean} > MAX_LEN )); then
    # Loop the string with spacer to simulate wraparound scroll
    scroll_text="$song_clean • $song_clean"
    len=${#scroll_text}

    # Ensure wraparound logic
    if (( pos + MAX_LEN > len )); then
        part1=${scroll_text:pos}
        part2=${scroll_text:0:MAX_LEN - ${#part1}}
        display="$part1$part2"
    else
        display=${scroll_text:pos:MAX_LEN}
    fi

    # Update scroll position
    pos=$(( (pos + 1) % ${#song_clean} ))
    echo "$pos" > "$STATE_FILE"
else
    # No scrolling needed
    display="$song_clean"
    echo 0 > "$STATE_FILE"
fi

# Output final string
echo "$icon $display"
