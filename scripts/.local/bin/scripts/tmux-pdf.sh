#!/bin/sh

DIRS="$HOME/Documents/books $HOME/Documents/papers/*"

# Split DIRS into positional parameters
set -- $DIRS

pdf=$(find "$@" \
          -mindepth 1 -maxdepth 1 -type f -iname '*.pdf' 2>/dev/null \
      | fzf --no-unicode --separator='' --pointer='' --no-scrollbar \
            --no-border --margin=10% --color='bw' --delimiter '/' \
            --with-nth='{-2}:  {-1}')

[ -n "$pdf" ] && open "$pdf"
