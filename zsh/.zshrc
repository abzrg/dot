# -- Global --

    # Create a hash table for globally stashing variables without polluting main
    # scope with a bunch of identifiers.
    typeset -A __ALI
    __ALI[ITALIC_ON]=$'\e[3m'
    __ALI[ITALIC_OFF]=$'\e[23m'

    # # syntax highlighting for man pages
    # export LESS_TERMCAP_mb=$'\e[1;32m'
    # export LESS_TERMCAP_md=$'\e[1;32m'
    # export LESS_TERMCAP_me=$'\e[0m'
    # export LESS_TERMCAP_se=$'\e[0m'
    # export LESS_TERMCAP_so=$'\e[01;33m'
    # export LESS_TERMCAP_ue=$'\e[0m'
    # export LESS_TERMCAP_us=$'\e[1;4;31m'

# -- Options --

    # -- completion
    setopt MENU_COMPLETE            # auto-insert first possible ambiguous completion
    setopt AUTO_PARAM_SLASH         # tab completing directory appends a slash
    setopt NO_NOMATCH               # [default] unmatched patterns are left unchanged
    setopt LIST_PACKED              # try to make the completion list smaller (occupying less lines) by printing the matches in columns with different widths.
    setopt NOBEEP                   # shut up ;)
    setopt COMPLETEALIASES          # autocomplete for aliases
    setopt COMPLETEINWORD           # if unset, the cursor is set to the end of the word if completion is started. Otherwise it stays there and completion is done from both ends.
    setopt LIST_TYPES               # when listing files that are possible completions, show the type of each file with a trailing identifying mark.
    setopt CORRECT                  # [default] command auto-correction
    setopt CORRECTALL               # [default] argument auto-correction

    # -- cd & pushd
    setopt PUSHD_IGNORE_DUPS        # don't push multiple copies of same dir onto stack
    setopt PUSHD_SILENT             # [default] don't print dir stack after pushing/popping
    setopt AUTOCD                   # change to directory without "cd"
    setopt AUTOPUSHD                # make cd push the old directory onto the directory stack.
    setopt PUSHDIGNOREDUPS          # don't push multiple copies of the same directory onto the directory stack

    # -- globbing
    setopt NORMSTARSILENT           # do query the user before executing 'rm *' or 'rm path/*'
    #setopt NO_RM_STAR_WAIT         # if querying the user before executing `rm *' or `rm path/*', first wait ten seconds and ignore anything typed in that time. this avoids the problem of reflexively answering `yes' to the query when one didn't really mean it. The wait and query can always be avoided by expanding the `*' in ZLE (with tab).
    setopt EXTENDEDGLOB             # treat the '#', '~' and '^' characters as part of patterns for filename generation, etc. (An initial unquoted '~' always produces named directory expansion.) | $ grep word *~(*.gz|*.bz|*.bz2|*.zip|*.Z) searches for word not in compressed files
    setopt GLOB_DOTS                # gLOBDOTS lets files beginning with a . be matched without explicitly specifying the dot.
    setopt CLOBBER                  # allow clobbering with >, no need to use >!

    # -- jobs
    setopt CHECKJOBS                # report the status of background and suspended jobs before exiting a shell with job control; a second attempt to exit the shell will succeed.
    setopt NOTIFY                   # report the status of background jobs immediately, rather than waiting until just before printing a prompt
    unsetopt BGNICE                 # do *not* run all background jobs at a lower priority
    setopt LONGLISTJOBS             # list jobs in the long format by default.
    setopt PRINT_EXIT_VALUE         # [default] for non-zero exit status
    setopt AUTO_RESUME              # allow simple commands to resume backgrounded jobs

    # -- misc.
    setopt NO_FLOW_CONTROL          # disable start (C-s) and stop (C-q) characters
    setopt INTERACTIVE_COMMENTS     # [default] allow comments, even in interactive shells
    setopt PROMPTCR                 # [default] print a carriage return just before printing a prompt in the line
    setopt SHORTLOOPS               # allow the short forms of for, select, if, and function constructs, i.e.: ``for i (*.o) rm $i'' instead of ``for i in *.o; do rm $i; done''
    setopt PRINTEIGHTBIT            # print eight bit characters literally in completion lists, etc. this option is not necessary if your system correctly returns the printability of eight bit characters (see man page ctype(3)).

    # -- history
    HISTSIZE=20000000                   # how many lines of history to keep in memory
    SAVEHIST=10000000                   # number of history entries to save to disk
    HISTFILE=$HOME/.cache/zsh/history   # history in cache directory:
    HISTDUP=erase                       # erase duplicates in the history file
    hISTORY_IGNORE='([bf]g *|cd ..|l[alsh]#( *)#|less *)'

    setopt appendhistory                # append history to the history file (no overwriting)
    setopt incappendhistory             # immediately append to the history file, not just when a term is killed
    setopt HISTSAVENODUPS               # when writing out the history file, older commands that duplicate newer ones are omitted.
    setopt HISTFINDNODUPS               # when searching for history entries in the line editor, do not display duplicates of a line previously found, even if the duplicates are not contiguous.
    setopt hist_expire_dups_first       # if the internal history needs to be trimmed to add the current command line, setting this option will cause the oldest history event that has a duplicate to be lost before losing a unique event from the list. you should be sure to set the value of HISTSIZE to a larger number than SAVEHIST in order to give you some room for the duplicated events, otherwise this option will behave just like HIST_IGNORE_ALL_DUPS once the history fills up with unique events.
    setopt hist_ignore_all_dups         # if a new command line being added to the history list duplicates an older one, the older command is removed from the list (even if it is not the previous event).
    setopt hist_ignore_dups             # do not enter command lines into the history list if they are duplicates of the previous event.
    unsetopt hist_ignore_space          # remove command lines from the history list when the first character on the line is a space, or when one of the expanded aliases contains a leading space. note that the command lingers in the internal history until the next command is entered before it vanishes, allowing you to briefly reuse or edit the line.  If you want to make it vanish right away without entering another command, type a space and press return.
    setopt hist_reduce_blanks           # hIST_REDUCE_BLANKS: remove superfluous blanks from each command line being added to the history list.
    #unsetopt hist_verify                # whenever the user enters a line with history expansion, don't execute the line directly; instead, perform history expansion and reload the line into the editing buffer.
    unsetopt hist_no_functions          # remove function definitions from the history list. note that the function lingers in the internal history until the next command is entered before it vanishes, allowing you to briefly reuse or edit the definition.
    setopt hist_no_store                # remove the history (fc -l) command from the history list when invoked. note that the command lingers in the internal history until the next command is entered before it vanishes, allowing you to briefly reuse or edit the line.
    setopt appendhistory                # if this is set, zsh sessions will append their history list to the history file, rather than overwrite it. Thus, multiple parallel zsh sessions will all have their history lists added to the history file, in the order they are killed
    setopt incappendhistory             # immediately append to the history file, not just when a term is killed
    #setopt    sharehistory              # this option both imports new commands from the history file, and also causes your typed commands to be appended to the history file (the latter is like specifying INC_APPEND_HISTORY). the history lines are also output with timestamps ala eXTENDED_HISTORY (which makes it easier to find the spot where we left off reading the file after it gets re-written).
    #unsetopt extendedhistory            # save each command's beginning timestamp (in seconds since the epoch) and the duration (in seconds) to the history file.  The format of this prefixed data is: ':<beginning time>:<elapsed seconds>;<command>'. i.e.: : 1054961691:0;/usr/games/fortune -f


# -- completion --

    # Extra zsh completion for Docker, CMake etc.
    fpath=(~/.zsh/completion $fpath)
        # fpath=(~/.zsh/completion/cmake $fpath)
        # fpath=(~/.zsh/completion/docker $fpath)
        fpath=(~/.zsh/completion/rust $fpath)
        # fpath=(~/.zsh/completion/curl $fpath)

    autoload -U compinit
    compinit -u

    # autoload -Uz compinit && compinit

    # Enable keyboard navigation of completions in menu
    # (not just tab/shift-tab but cursor keys as well):
    zstyle ':completion:*' menu select


    # Make completion:
    # - Try exact (case-sensitive) match first.
    # - Then fall back to case-insensitive.
    # - Accept abbreviations after . or _ or - (ie. f.b -> foo.bar).
    # # - Substring complete (ie. bar -> foobar).
    zstyle ':completion:*' matcher-list '' '+m:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}' '+m:{_-}={-_}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

    # # prevent completion of files for 'make' command in zsh shell
    # # src https://unix.stackexchange.com/a/499322/419393
    # zstyle ':completion:*:*:make:*' tag-order 'targets'

    # Allow completion of ..<Tab> to ../ and beyond. (CANCER: autocompletes the name of scripts where only path completion make sense)
    zstyle -e ':completion:*' special-dirs '[[ $PREFIX = (../)#(..) ]] && reply=(..)'

    # $CDPATH is overpowered (can allow us to jump to 100s of directories) so tends
    # to dominate completion; exclude path-directories from the tag-order so that
    # they will only be used as a fallback if no completions are found.
    zstyle ':completion:*:complete:(cd|pushd):*' tag-order 'local-directories named-directories'

    # Categorize completion suggestions with headings:
    zstyle ':completion:*' group-name ''
    zstyle ':completion:*:descriptions' format %F{default}%B%{$__ALI[ITALIC_ON]%}--- %d ---%{$__ALI[ITALIC_OFF]%}%b%f

    # Enable keyboard navigation of completions in menu
    # (not just tab/shift-tab but cursor keys as well):
    zstyle ':completion:*' menu select

    # stop the stupidity around the completion for 'source' command
    #
    # zsh searches through the PATH to find completion for the 'source' command
    # and this is really annoying when I'm working with virtualenv as I always
    # choose 'venv' as the name of the virtualenv directory.
    unset '_comps[source]'

    # do not require a leading '.' in a filename to be matched explicitly.
    _comp_options+=(globdots)

    # persistent rehash
    zstyle ':completion:*' rehash true

    # an array (colon separated list) containing the suffixes of files to
    # be ignored during filename completion. However, if completion only
    # generates files with suffixes in this list, then these files are
    # completed anyway.
    # note: U can use ``ls **/*~*(${~${(j/|/)fignore}})(.)'' to list all
    #       plain files that do not have extensions listed in `fignore' or
    #       ``rm **/*(${~${(j/|/)fignore}})(.)'' to remove.
    # source: # https://github.com/strcat/dotfiles/blob/master/zshmisc
    #fignore=( .part ,v .aux .toc .lot .lof .blg .bbl .bak .BAK .sav .old .o .trace .swp \~)

    # Do not include this pattern when autocomplete for neovim/vim
    zstyle ':completion:*:*:v*:*' file-patterns '^(__pycache__|*.egg-info|build|venv|*.o|.pytest_cache|.git):directories'
    zstyle ':completion:*:*:vi:*' file-patterns '^(__pycache__|*.egg-info|build|venv|*.o|.pytest_cache|.git):directories'
    zstyle ':completion:*:*:vim:*' file-patterns '^(__pycache__|*.egg-info|build|venv|*.o|.pytest_cache|.git):directories'
    zstyle ':completion:*:*:nvim:*' file-patterns '^(__pycache__|*.egg-info|build|venv|*.o|.pytest_cache|.git):directories'
    zstyle ':completion:*:*:python:*' file-patterns '^(__pycache__|*.egg-info|build|venv|*.o|.pytest_cache|.git):directories'


# -- vi mode --

    # enable vi mode
    bindkey -v

    # faster escape
    export KEYTIMEOUT=1

    # # vi bindings in tab complete menu
    # zmodload zsh/complist
    # bindkey -M menuselect 'h' vi-backward-char
    # bindkey -M menuselect 'k' vi-up-line-or-history
    # bindkey -M menuselect 'l' vi-forward-char
    # bindkey -M menuselect 'j' vi-down-line-or-history
    # bindkey -M menuselect 'left' vi-backward-char
    # bindkey -M menuselect 'down' vi-up-line-or-history
    # bindkey -M menuselect 'up' vi-forward-char
    # bindkey -M menuselect 'right' vi-down-line-or-history

    # # change cursor shape for different vi modes.
    # #    0: Blinking block
    # #    1: Blinking block (default)
    # #    2: Steady block (“â–ˆ”)
    # #    3: Blinking underline
    # #    4: Steady underline ("_")
    # #    5: Blinking bar
    # #    6: Steady bar ("|")
    # function zle-keymap-select () {
    #     case $KEYMAP in
    #         vicmd) echo -ne '\e[2 q';;      # block
    #         viins|main) echo -ne '\e[6 q';; # beam
    #     esac
    # }
    # zle -N zle-keymap-select
    # zle-line-init() {
    #     zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    #     echo -ne "\e[6 q"
    # }
    # zle -N zle-line-init
    # echo -ne '\e[6 q' # use beam shape cursor on startup.
    # precmd() { echo -ne '\e[6 q' ;} # use beam shape cursor for each new prompt.

    # # ci", ci', ci`, di", etc
    # autoload -U select-quoted
    # zle -N select-quoted
    # for m in visual viopp; do
    #   for c in {a,i}{\',\",\`}; do
    #     bindkey -M $m $c select-quoted
    #   done
    # done

    # # ci{, ci(, ci<, di{, etc
    # autoload -U select-bracketed
    # zle -N select-bracketed
    # for m in visual viopp; do
    #   for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
    #     bindkey -M $m $c select-bracketed
    #   done
    # done

    # # increase a number
    # autoload -Uz incarg
    # zle -N incarg
    # bindkey -M emacs "^X^A" incarg
    # bindkey -M vicmd "^A" incarg

    # # get ascii info for current cursor position, just like in vim
    # bindkey -M vicmd ga what-cursor-position

    # edit line in vim with Alt-e:
    autoload edit-command-line; zle -N edit-command-line
    bindkey '\ee' edit-command-line

    # # enter vim buffer from normal mode
    # autoload -U edit-command-line && zle -N edit-command-line && bindkey -M vicmd "^v" edit-command-line


# -- bindings --

    # Allow terminal to "see" C-O.
    # src: https://apple.stackexchange.com/a/3255/158927
    stty discard undef

    # some familiar emacs binding
    bindkey '\e.' 'insert-last-word'
    bindkey "^A" beginning-of-line
    bindkey "^E" end-of-line
    bindkey "^W" backward-kill-word
    bindkey '^U' kill-whole-line
    bindkey "^K" kill-line
    bindkey "^B" backward-char
    bindkey "^F" forward-char
    bindkey "^Y" yank
    bindkey '\ew' push-line-or-edit
    bindkey -M viins ' ' magic-space
    bindkey '^H' backward-kill-word # ctrl+backspace
    bindkey '^o' accept-and-hold
    bindkey '^R' history-incremental-pattern-search-backward
    bindkey '\ef' forward-word
    bindkey '\eb' backward-word
    bindkey '\ed' kill-word
    bindkey '^D' delete-char-or-list

    # fix backspace bug when switching modes
    bindkey "^?" backward-delete-char

    # history search
    bindkey "^[[A" history-beginning-search-backward
    bindkey "^[[B" history-beginning-search-forward
    bindkey "\C-p" history-beginning-search-backward
    bindkey "\C-n" history-beginning-search-forward


# -- Misc.

    # Do not highlight things paste in the terminal
    zle_highlight+=(paste:none)


# -- OpenFOAM --

    autoload bashcompinit
    bashcompinit


# -- Plugins --

    # -- async-zsh (put it before prompt setting)
    source ~/.zsh/plugins/zsh-async/async.zsh
    async_init


# -- Settings in other files

    # -- aliases
    [ -e "$HOME/.zsh-aliases" ] && . "$HOME/.zsh-aliases"

    # -- functions
    [ -e "$HOME/.zsh-functions" ] && . "$HOME/.zsh-functions"

    # -- widgets
    [ -e "$HOME/.zsh-widgets" ] && . "$HOME/.zsh-widgets"

    # -- prompt and title here
    [ -e "$HOME/.zsh-prompt" ] && . "$HOME/.zsh-prompt"

    # -- zoxide
    eval "$(zoxide init zsh)"
