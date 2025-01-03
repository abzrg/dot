# Do not highlight things paste in the terminal
zle_highlight+=(paste:none)

# Create a hash table for globally stashing variables without polluting main scope with a
# bunch of identifiers.
typeset -A __USER
__USER[ITALIC_ON]=$'\e[3m'
__USER[ITALIC_OFF]=$'\e[23m'

# %---[ Options ]---%

setopt AUTO_PARAM_SLASH NO_NOMATCH LIST_PACKED NOBEEP COMPLETEALIASES COMPLETEINWORD LIST_TYPES
setopt PUSHD_IGNORE_DUPS PUSHD_SILENT AUTOCD AUTOPUSHD PUSHDIGNOREDUPS
setopt NORMSTARSILENT EXTENDEDGLOB GLOB_DOTS CLOBBER
setopt CHECKJOBS NOTIFY LONGLISTJOBS AUTO_RESUME # PRINT_EXIT_VALUE
unsetopt BGNICE
setopt NO_FLOW_CONTROL INTERACTIVE_COMMENTS PROMPTCR SHORTLOOPS PRINTEIGHTBIT COMPLETE_ALIASES
setopt INC_APPEND_HISTORY HIST_SAVE_NO_DUPS HIST_FIND_NO_DUPS HIST_EXPIRE_DUPS_FIRST \
       HIST_IGNORE_ALL_DUPS HIST_IGNORE_DUPS HIST_IGNORE_SPACE HIST_REDUCE_BLANKS \
       HIST_NO_STORE EXTENDEDHISTORY # SHAREHISTORY

HISTSIZE=20000000
SAVEHIST=10000000
HISTFILE=$HOME/.cache/zsh/history
HISTDUP=erase
hISTORY_IGNORE='([bf]g *|cd ..|l[alsh]#( *)#|less *)'

# %---[ Completion ]---%

autoload -Uz compinit
compinit -u

zstyle ':completion:*' completer _extensions _complete _approximate
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"
zstyle ':completion:*' menu select
zstyle ':completion:*' rehash true
zstyle ':completion:*' matcher-list '' '+m:{[:lower:]}={[:upper:]}' \
                                    '+m:{[:upper:]}={[:lower:]}' '+m:{_-}={-_}' \
                                    'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

zstyle ':completion:*:*:make:*' tag-order 'targets'
zstyle -e ':completion:*' special-dirs '[[ $PREFIX = (../)#(..) ]] && reply=(..)'
zstyle ':completion:*:complete:(cd|pushd):*' tag-order 'local-directories named-directories'

zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format %F{default}%B%{$__USER[ITALIC_ON]%}--- %d \
                                           ---%{$__ALI[ITALIC_OFF]%}%b%f
zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:*:-command-:*:*' group-order alias builtins functions commands

zstyle ':completion:*:*:v:*' file-patterns \
    '^(__pycache__|*.egg-info|*.dSYM|.cache|build|venv|*.o|.pytest_cache|.git|*.pdf):directories'
zstyle ':completion:*:*:vi:*' file-patterns  \
    '^(__pycache__|*.egg-info|*.dSYM|.cache|build|venv|*.o|.pytest_cache|.git|*.pdf):directories'
zstyle ':completion:*:*:vim:*' file-patterns \
    '^(__pycache__|*.egg-info|*.dSYM|.cache|build|venv|*.o|.pytest_cache|.git|*.pdf):directories'
zstyle ':completion:*:*:nvim:*' file-patterns \
    '^(__pycache__|*.egg-info|*.dSYM|.cache|build|venv|*.o|.pytest_cache|.git|*.pdf):directories'
zstyle ':completion:*:*:python:*' file-patterns \
    '^(__pycache__|*.egg-info|build|venv|*.o|.pytest_cache|.git):directories'

unset '_comps[source]'

_comp_options+=(globdots)

# fpath=(~/.zsh/completion $fpath)
# fpath=(~/.zsh/completion/cmake $fpath)
# fpath=(~/.zsh/completion/docker $fpath)
# fpath=(~/.zsh/completion/rust $fpath)
# fpath=(~/.zsh/completion/curl $fpath)

# %---[ Bindings ]---%

bindkey -v
export KEYTIMEOUT=1

zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'left' vi-backward-char
bindkey -M menuselect 'down' vi-up-line-or-history
bindkey -M menuselect 'up' vi-forward-char
bindkey -M menuselect 'right' vi-down-line-or-history

# function zle-keymap-select () {
#  case $KEYMAP in
#      vicmd) echo -ne '\e[2 q';;      # block
#      viins|main) echo -ne '\e[6 q';; # beam
#  esac
# }
# zle -N zle-keymap-select
# zle-line-init() {
#  zle -K viins
#  echo -ne "\e[6 q"
# }
# zle -N zle-line-init
# echo -ne '\e[6 q'
# precmd() { echo -ne '\e[6 q' ;}

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

# cs, ds, ys
autoload -Uz surround
zle -N delete-surround surround
zle -N add-surround surround
zle -N change-surround surround
bindkey -M vicmd cs change-surround
bindkey -M vicmd ds delete-surround
bindkey -M vicmd ys add-surround
bindkey -M visual S add-surround

# c-a, c-x
autoload -Uz incarg
zle -N incarg
bindkey -M emacs "^X^A" incarg
bindkey -M vicmd "^A" incarg

# ga
bindkey -M vicmd ga what-cursor-position

# alt-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '\ee' edit-command-line

# ---

# c-o
stty discard undef

# emacs
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

bindkey "^?" backward-delete-char

bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward
bindkey "\C-p" history-beginning-search-backward
bindkey "\C-n" history-beginning-search-forward

# %---[ Source ]---%

# async-zsh (must come before prompt setting)
source ~/.zsh/plugins/zsh-async/async.zsh
async_init

[ -e "$HOME/.zsh-aliases" ] && . "$HOME/.zsh-aliases"
[ -e "$HOME/.zsh-functions" ] && . "$HOME/.zsh-functions"
[ -e "$HOME/.zsh-widgets" ] && . "$HOME/.zsh-widgets"
[ -e "$HOME/.zsh-prompt" ] && . "$HOME/.zsh-prompt"

# source <(fzf --zsh)

eval "$(zoxide init zsh)"
