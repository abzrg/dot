#!/bin/bash

# check for operating system
if [ `uname -s` = 'Darwin' ]; then
    _word="$(pbpaste)"
else
    _word="$(xclip -sel clip -o)"
fi

# calculate the width of the window
[ $(tput cols) -lt 80 ] && local width=$(tput cols)

# remove any html entity and then show the result
sdcv -n --utf8-output --color "$_word" 2>&1 \
    | sed 's/<br>/\n/g' \
    | sed 's/<BR>/\n/g' \
    | sed -e 's/<[^>]*>//g' \
    | fold -s -w ${width:-80} | less -FRX
