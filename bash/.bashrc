# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Environment variables
export LANG="en_US.UTF-8"
export EDITOR="nvim"
export VISUAL="nvim"
# export TERMINAL="st"
export BROWSER="brave"
# export READER="zathura"
export PAGER="less"
export LESSOPEN='|/usr/bin/lesspipe.sh %s' # allow less to view non-text files
export LESS_TERMCAP_mb=$'\e[1;32m'      # begin bold
export LESS_TERMCAP_md=$'\e[1;32m'      # begin blink
export LESS_TERMCAP_me=$'\e[0m'         # reset bold/blink
export LESS_TERMCAP_so=$'\e[01;33m'     # begin reverse video
export LESS_TERMCAP_se=$'\e[0m'         # reset reverse video
export LESS_TERMCAP_us=$'\e[1;4;31m'    # begin underline
export LESS_TERMCAP_ue=$'\e[0m'         # reset underline
export LESS=-R
export COLORTERM="truecolor"

# SHell OPTions
shopt -s checkwinsize # checks term size when bash regains control
shopt -s autocd # change to named directory
shopt -s cdspell # autocorrects cd misspellings
shopt -s cmdhist # save multi-line commands in history as single line
# shopt -s direxpand # If set, Bash replaces directory names with the results of word expansion when performing filename completion.
shopt -s dotglob # Wildcards match dotfiles ("*.sh" => "foo.sh")
shopt -s histappend # append to the history file, do not overwrite history
shopt -s expand_aliases # expand aliases. use C-A-e for expantion
shopt -s no_empty_cmd_completion
shopt -s globstar # Allow ** for recursive matches ('lib/**/*.sh' => 'lib/a/b/c.sh')
stty -ixon # Disable ctrl-s and ctrl-q.

# Ignore duplicate and line starting space
HISTCONTROL=ignoreboth:erasedups
HISTIGNORE="clear:bg:fg:cd:cd -:cd ..:exit:date:w:* --help:ls:l:ll:lll"

# Size of the history file
HISTSIZE=""
HISTFILESIZE=""
export HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/history"

# Change title of terminals
case ${TERM} in
  xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|alacritty|st*|konsole*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"'
        ;;
  screen*)
    PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\"'
    ;;
esac

# Only retain 2 trailing directory components when expanding \w prompt string escape. Characters are replaced with an ellipsis.
#PROMPT_DIRTRIM=2

# NOTE:
#   - `history -a`: append history lines from this session to the history file
#   - you don't need to, and should not, export PS1, since it's a shell
#   setting, not an environment variable. A bash PS1 setting wouldn't be
#   understood by other shells.

# Git prompt for bash
source $HOME/.git-prompt.sh

function __prompt_path() {

    # If we're in HOME then just return ~
    if [ "$PWD" = "$HOME" ]; then
        printf "~"
        return
    fi

    local __cur_dir_name="${PWD##*/}"
    local __cur_dir_parents="$(echo ${PWD%/*} | sed 's#$HOME#~#' )"

    local __path_repr=$(printf "$__cur_dir_parents" | sed -e "s;\(/\.\?.\)[^/]*;\1;g" -e "s;/h/s;~;" -e "s;\./;;")
    printf "%s/%s" "$__path_repr" "$__cur_dir_name"
    # printf "%s" "$(printf \"$__cur_dir_parents\" | sed -e 's|\(/\.\?.\)[^/]*|\1|g' -e 's;/h/s;~;' -e 's;\./;;\')"

}

# A prompt inspired by Luke Smith's prompt
PS1='$(history -a)\[\e[0;32m\]\u@\h\[\e[0m\]:\[\e[1;34m\]$(__prompt_path)\[\e[0;38;5;229m\]$(__git_ps1)\[\e[0m\]\n$ '
# PS1='$(history -a)\W $(__git_ps1)$ '

# A very simple prompt
# PS1='$(history -a)\w $ '

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|*rxvt*)
    PS1="\[\e]0;\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# Aliases
# [ -f "$HOME/.bash_aliases" ] && source "$HOME/.bash_aliases"

# Functions
# [ -f "$HOME/.bash_functions" ] && source "$HOME/.bash_functions"

# Fzf
# [ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Fix problems of delete key in terminal
printf '\033[?1h\033=' >/dev/tty

# Colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Enable programmable completion features
# (you don't need to enable this, if it's already enabled in /etc/bash.bashrc
# and /etc/profile sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

alias v=nvim
alias of2112='. ~/OpenFOAM/OpenFOAM-v2112/etc/bashrc'
alias sz='. ~/.bashrc'
alias cfb='$EDITOR ~/.bashrc'

# enable color support of ls and also add handy aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

echo -ne '\e[2 q'

# bash completion
[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh" 2>/dev/null



alias \
    cfz="$EDITOR $HOME/.zshrc"                                                 \
    cfzp="$EDITOR $HOME/.zprofile"                                             \
    cft="$EDITOR $HOME/.tmux.conf"                                             \
    cfa="$EDITOR ${HOME}/.zsh-aliases"                                         \
    cfA="$EDITOR ${XDG_CONFIG_HOME:-$HOME/.config}/alacritty/alacritty.yml"    \
    cfk="$EDITOR ${XDG_CONFIG_HOME:-$HOME/.config}/kitty/kitty.conf"           \


alias mkd='mkdir -p'

# zoxide
eval "$(zoxide init bash)"
alias z='zoxide'
. "$HOME/.cargo/env"
