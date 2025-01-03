#!/bin/sh -e

# fuzzy finder for tmux session switching

session=$(                                                                              \
    tmux list-sessions                                                                  \
    | sk                                                                                \
        --no-multi --reverse                                                            \
        --preview='session=$(echo {} | cut -d : -f 1) && tmux list-windows -t $session' \
        --preview-window 'up:50%'                                                       \
    | cut -d: -f1)
tmux switch-client -t $session

