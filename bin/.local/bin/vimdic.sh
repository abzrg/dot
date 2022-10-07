#!/bin/bash

# calculate the width of the window
[ "$(tput cols)" -lt 80 ] && width=$(tput cols)

# remove any html entity and then show the result
sdcv -n --utf8-output --color "$1" 2>&1 \
    | sed 's/<br>/\n/g' \
    | sed 's/<BR>/\n/g' \
    | sed -e 's/<[^>]*>//g' \
    | fold -s -w "${width:-80}" | less -FRX
