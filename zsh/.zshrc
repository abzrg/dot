#====[ Xterm title (archwiki) ]===============================================

autoload -Uz add-zsh-hook

function xterm_title_precmd () {
    print -Pn -- '\e]2;%n@%m:%~\a'
    [[ "$TERM" == 'screen'* ]] && print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-}\e\\'
}

function xterm_title_preexec () {
    print -Pn -- '\e]2;%n@%m:%~ — ' && print -n -- "${(q)1}\a"
    [[ "$TERM" == 'screen'* ]] && { print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-} %# ' && print -n -- "${(q)1}\e\\"; }
}

if [[ "$TERM" == (Eterm*|alacritty*|aterm*|gnome*|konsole*|kterm*|putty*|rxvt*|screen*|tmux*|xterm*|st*) ]]; then
    add-zsh-hook -Uz precmd xterm_title_precmd
    add-zsh-hook -Uz preexec xterm_title_preexec
fi


#====[ Misc. Options ]=========================================================

# -----------------------------------------------------------------------------
# Edit small files with the command line editor.
autoload -U zed

# -----------------------------------------------------------------------------
# Report the status of background jobs immediately, rather than
# waiting until just before printing a prompt
setopt notify

# -----------------------------------------------------------------------------
# Change to directory without "cd"
setopt autocd

# -----------------------------------------------------------------------------
# Make cd push the old directory onto the directory stack.
setopt autopushd

# Don't push multiple copies of the same directory onto the directory
# stack
setopt pushdignoredups

# -----------------------------------------------------------------------------
# Do query the user before executing 'rm *' or 'rm path/*'
# $ rm -rf *
# zsh: sure you want to delete all the files in /home/dope/foo [yn]?
setopt normstarsilent

# -----------------------------------------------------------------------------
# If querying the user before executing `rm *' or `rm path/*',
# first wait ten seconds and ignore anything typed in that time.
# This avoids the problem of reflexively answering `yes' to the query
# when one didn't really mean it. The wait and query can always be
# avoided by expanding the `*' in ZLE (with tab).
#setopt no_rm_star_wait

# -----------------------------------------------------------------------------
# Shut up ;)
setopt nobeep

# -----------------------------------------------------------------------------
# Treat the '#', '~' and '^' characters as part of patterns
# for filename generation, etc. (An initial unquoted '~'
# always produces named directory expansion.)
# | $ grep word *~(*.gz|*.bz|*.bz2|*.zip|*.Z)
# searches for word not in compressed files
setopt extendedglob

# -----------------------------------------------------------------------------
# GLOBDOTS lets files beginning with a . be matched without explicitly
# specifying the dot.
setopt glob_dots

# -----------------------------------------------------------------------------
# Report the status of background and suspended jobs before exiting a shell
# with job control; a second attempt to exit the shell will succeed.
setopt checkjobs

# -----------------------------------------------------------------------------
# Disable ctrl-s to freeze terminal.
stty stop undef

# -----------------------------------------------------------------------------
setopt nonomatch
zle_highlight+=(paste:none)
# unsetopt PROMPT_SP # fix % showing up upon starting st

# -----------------------------------------------------------------------------
# Allow comments even in interactive shells i. e.
#   $ uname # This command prints system informations
#   zsh: bad pattern: #
#   $ setopt interactivecomments
#   $ uname # This command prints system informations
#   OpenBSD
setopt interactive_comments

# Try to make the completion list smaller (occupying less lines) by
# printing the matches in columns with different widths.
setopt list_packed

# Print a carriage return just before printing a prompt in the line
# editor. For example:
#  $ echo foo
#  foo
#  $ echo -n foo
#  $ setopt nopromptcr
#  $ echo -n foo
#  foo$
setopt nopromptcr

# History --------------------------------------------------------------------
HISTSIZE=20000000             # How many lines of history to keep in memory
SAVEHIST=10000000             # Number of history entries to save to disk
HISTFILE=~/.cache/zsh/history # History in cache directory:
HISTDUP=erase                 # Erase duplicates in the history file
# HISTORY_IGNORE='([bf]g *|cd ..|l[alsh]#( *)#|less *)' # Does not seem to work

# Append history to the history file (no overwriting)
setopt appendhistory

# Immediately append to the history file, not just when a term is killed
setopt incappendhistory

# When writing out the history file, older commands that duplicate newer ones
# are omitted.
setopt HISTSAVENODUPS

# When searching for history entries in the line editor, do not display
# duplicates of a line previously found, even if the duplicates are not
# contiguous.
setopt HISTFINDNODUPS

# If the internal history needs to be trimmed to add the current command line,
# setting this option will cause the oldest history event that has a duplicate
# to be lost before losing a unique event from the list.
# You should be sure to set the value of HISTSIZE to a larger number
# than SAVEHIST in order to give you some room for the duplicated
# events, otherwise this option will behave just like HIST_IGNORE_ALL_DUPS
# once the history fills up with unique events.
setopt hist_expire_dups_first

# If a new command line being added to the history list duplicates an
# older one, the older command is removed from the list (even if it is
# not the previous event).
setopt hist_ignore_all_dups

# Do not enter command lines into the history list
# if they are duplicates of the previous event.
setopt hist_ignore_dups

# Remove command lines from the history list when the first character on
# the line is a space, or when one of the expanded aliases contains a
# leading space.
# Note that the command lingers in the internal history until the next
# command is entered before it vanishes, allowing you to briefly reuse
# or edit the line.  If you want to make it vanish right away without
# entering another command, type a space and press return.
unsetopt hist_ignore_space

# HIST_REDUCE_BLANKS
# Remove superfluous blanks from each command line
# being added to the history list.
setopt hist_reduce_blanks

# Whenever the user enters a line with history expansion,
# don't execute the line directly; instead, perform
# history expansion and reload the line into the editing buffer.
unsetopt hist_verify

# Remove function definitions from the history list.
# Note that the function lingers in the internal history until the next
# command is entered before it vanishes, allowing you to briefly reuse
# or edit the definition.
unsetopt hist_no_functions

# Remove the history (fc -l) command from the history list
# when invoked.
# Note that the command lingers in the internal history until the next
# command is entered before it vanishes, allowing you to briefly reuse
# or edit the line.
setopt hist_no_store

# If this is set, zsh sessions will append their history list to
# the history file, rather than overwrite it. Thus, multiple parallel
# zsh sessions will all have their history lists added to the
# history file, in the order they are killed
setopt appendhistory

# Immediately append to the history file, not just when a term is killed
setopt incappendhistory

# This option both imports new commands from the history file, and also
# causes your typed commands to be appended to the history file (the
# latter is like specifying INC_APPEND_HISTORY).
# The history lines are also output with timestamps ala
# EXTENDED_HISTORY (which makes it easier to find the spot where
# we left off reading the file after it gets re-written).
# setopt    sharehistory

# Save each command's beginning timestamp (in seconds since the epoch)
# and the duration (in seconds) to the history file.  The format of
# this prefixed data is:
# ':<beginning time>:<elapsed seconds>;<command>'.
# i. e.:
#  : 1054961691:0;/usr/games/fortune -f
# unsetopt extendedhistory

# Allow the short forms of for, select, if, and function constructs, i.
# e.: ``for i (*.o) rm $i'' instead of ``for i in *.o; do rm $i; done''
setopt shortloops

# Do *not* run all background jobs at a lower priority
unsetopt bgnice

# List jobs in the long format by default.
setopt longlistjobs

# Print eight bit characters literally in completion lists, etc.
# This option is not necessary if your system correctly returns the
# printability of eight bit characters (see man page ctype(3)).
setopt printeightbit



#====[ Auto completion ]======================================================

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select

# Auto complete with case insenstivity
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Prevent completion of files for 'make' command in zsh shell
# souce: https://unix.stackexchange.com/a/499322/419393
zstyle ':completion:*:*:make:*' tag-order 'targets'

zmodload zsh/complist
compinit
#  Do not require a leading '.' in a filename to be matched explicitly.
_comp_options+=(globdots)

# Persistent rehash
zstyle ':completion:*' rehash true

# Autocomplete for aliases
setopt completealiases

# If unset, the cursor is set to the end of the word if completion is
# started. Otherwise it stays there and completion is done from both ends.
setopt completeinword

# When listing files that are possible completions, show the
# type of each file with a trailing identifying mark.
setopt list_types

# Try to correct the spelling of all arguments in a line.
# No .. not really .. it's make me crazy *g*
# setopt correctall

# An array (colon separated list) containing the suffixes of files to
# be ignored during filename completion. However, if completion only
# generates files with suffixes in this list, then these files are
# completed anyway.
# Note: U can use ``ls **/*~*(${~${(j/|/)fignore}})(.)'' to list all
#       plain files that do not have extensions listed in `fignore' or
#       ``rm **/*(${~${(j/|/)fignore}})(.)'' to remove.
# source: # https://github.com/strcat/dotfiles/blob/master/zshmisc
# fignore=( .part ,v .aux .toc .lot .lof .blg .bbl .bak .BAK .sav .old .o .trace .swp \~)

# Escape shell characters in a url
autoload -Uz url-quote-magic bracketed-paste-magic
zle -N self-insert url-quote-magic
zle -N bracketed-paste bracketed-paste-magic




#
# Env Vars
#

export EDITOR="nvim"
#
# Alias
#

alias v="$EDITOR"
alias sz="source ~/.zshrc"

#
# Binding
#


# vi mode ---------------------
bindkey -v
export KEYTIMEOUT=1

# vi bindings in tab complete menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'left' vi-backward-char
bindkey -M menuselect 'down' vi-up-line-or-history
bindkey -M menuselect 'up' vi-forward-char
bindkey -M menuselect 'right' vi-down-line-or-history

# # Change cursor shape for different vi modes.
# function zle-keymap-select () {
#     case $KEYMAP in
#         vicmd) echo -ne '\e[1 q';;      # block
#         viins|main) echo -ne '\e[5 q';; # beam
#     esac
# }
# zle -N zle-keymap-select
# zle-line-init() {
#     zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
#     echo -ne "\e[5 q"
# }
# zle -N zle-line-init
# echo -ne '\e[5 q' # Use beam shape cursor on startup.
# precmd() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# ci", ci', ci`, di", etc
autoload -U select-quoted
zle -N select-quoted
for m in visual viopp; do
  for c in {a,i}{\',\",\`}; do
    bindkey -M $m $c select-quoted
  done
done

# ci{, ci(, ci<, di{, etc
autoload -U select-bracketed
zle -N select-bracketed
for m in visual viopp; do
  for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
    bindkey -M $m $c select-bracketed
  done
done

# Increase a number
autoload -Uz incarg
zle -N incarg
bindkey -M emacs "^X^A" incarg
bindkey -M vicmd "^A" incarg

# Get current cursor position
bindkey -M vicmd ga what-cursor-position


# emacs binding ----------------------------
bindkey '\e.' 'insert-last-word'
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^W" backward-kill-word
bindkey "^K" kill-line
bindkey "^B" backward-char
bindkey "^F" forward-char
bindkey "^Y" yank
bindkey '\ew' push-line-or-edit
bindkey -M viins ' ' magic-space
bindkey '^H' backward-kill-word # Ctrl+backspace
bindkey '^o' accept-and-hold
bindkey '^R' history-incremental-pattern-search-backward

# fix backspace bug when switching modes
bindkey "^?" backward-delete-char

# make Alt-backspace less liberal version of Ctrl-w
backward-kill-dir () {
    local WORDCHARS=${WORDCHARS/\/}
    zle backward-kill-word
    zle -f kill
}
zle -N backward-kill-dir
bindkey '^[^?' backward-kill-dir

# history search
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward
bindkey "\C-p" history-beginning-search-backward
bindkey "\C-n" history-beginning-search-forward

# Manage jobs
fg-widget() {
  if [[ $#BUFFER -eq 0 ]]; then
    if jobs %- >/dev/null 2>&1; then
      BUFFER='fg %-'
    else
      BUFFER='fg'
    fi
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fg-widget
bindkey -M emacs "^Z" fg-widget
bindkey -M vicmd "^Z" fg-widget
bindkey -M viins "^Z" fg-widget

# Comment a line interactively
setopt INTERACTIVE_COMMENTS
bindkey '\e3' pound-insert

# Edit line in vim with Alt-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '\ee' edit-command-line

# Enter vim buffer from normal mode
autoload -U edit-command-line && zle -N edit-command-line && bindkey -M vicmd "^v" edit-command-line


#====[ Source scripts ]========================================================

# Load aliases and shortcuts if existent.
[ -f "${HOME}/.aliasrc" ] && source "${HOME}/.aliasrc"

# zoxide ------------------------------------
eval "$(zoxide init zsh)"

# fzf --------------------------------------
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Fzf man pages
# Remember to update the man page index periodically using the command
# `sudo mandb && mandb`
# learn more about zle: https://sgeb.io/posts/zsh-zle-custom-widgets/
fzf-man-widget() {
    gman $(gapropos --long . | fzf | awk '{print $2, $1}' | tr -d '()') 2>/dev/null; :
    zle reset-prompt
}
zle     -N   fzf-man-widget
bindkey '\em' fzf-man-widget

# fzf notes
fzf-notes-widget() {
    nvim "$(find ~/Documents/notes -type f 2>/dev/null | fzf)"
    zle reset-prompt
}
zle     -N   fzf-man-widget
bindkey '\em' fzf-man-widget


#====[ Prompt ]================================================================

autoload -U colors && colors
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git hg
zstyle ':vcs_info:*' disable bzr svn cdv darcs mtn svk tla # I don't use these VCSs
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '!'
zstyle ':vcs_info:*' stagedstr '+'
zstyle ':vcs_info:*' formats ' %F{blue}(%F{yellow}%f %F{magenta}%b%f%F{red}%u%f%F{green}%c%f%F{red}%m%f%F{blue})%f'
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
+vi-git-untracked() {
  if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
     git status --porcelain | grep -m 1 '^??' &>/dev/null
  then
    hook_com[misc]='?'
  fi
}
function precmd() { vcs_info } # Update each time new prompt is rendered
setopt prompt_subst # Allow dynamic command prompt

PS1='%F{cyan}%1~%f${vcs_info_msg_0_}%f'$'%-60(l::\n)'' %(?.%F{green}❯ %f.%F{red}❯%f '
# PS1='%F{cyan}%1~%f $ '

# autoload -U colors && colors
# setopt prompt_subst
# PROMPT='%F{blue}[ %F{cyan}%1~%f %F{blue}]%f %(?.%#.%F{red}%#%f) '

#====[ Extensions ]===========================================================

# Load syntax highlighting; should be last.
source ~/.local/src/fsh/fast-syntax-highlighting.plugin.zsh 2>/dev/null
# Suggest aliases for commands
# source /usr/share/zsh/plugins/zsh-you-should-use/you-should-use.plugin.zsh
# Search repos for programs that can't be found
# source /usr/share/doc/pkgfile/command-not-found.zsh


# OpenFOAM
autoload bashcompinit
bashcompinit


printf "( .-.)\n"
