#!/bin/sh -e

# MacOS's dictionary?
# pip install dictionarytools or something
source ~/opt/py/3.12/bin/activate
word="`fzf </usr/share/dict/words`"
dict.py "$word" | less -R
