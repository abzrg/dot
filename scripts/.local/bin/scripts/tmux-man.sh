#!/bin/sh -e

export MANPATH="$HOME/opt/mpich/mpich-4.3.0/share/man:$MAPATH"

/usr/bin/man $(fzf --margin='20%'  --no-info --no-border --no-scrollbar \
                   --separator='' --pointer='' --color='bw' \
                   < ~/.manpages) 2>/dev/null
