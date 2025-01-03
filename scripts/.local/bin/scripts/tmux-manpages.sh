#!/bin/sh

man `man -k '.' 2>/dev/null | awk '{print $1}' | fzf | sed -E 's/\([0-9n]\),?$//'`
