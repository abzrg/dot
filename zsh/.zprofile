# Defualt programs
export LANG="en_US.UTF-8"
export EDITOR="nvim"
export VISUAL="nvim"
export TERMINAL="alacritty"
export BROWSER="brave"
export READER="zathura"
export PAGER="less"

# ~/ Clean up
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"
# export CARGO_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/cargo"
# export RUSTUP_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/cargo"
# export STARDICT_DATA_DIR=$XDG_DATA_HOME/stardict # contained searched words
# export DICS="/usr/share/stardict/dic/" # path to dictionaries
export LESSHISTFILE='-' # no history file for less
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc

export FZF_DEFAULT_COMMAND='fd -t f -t l -H' # Including hidden files in search
export FZF_DEFAULT_OPTS="
    --layout=reverse --height 40% --preview-window=border-sharp
"
export CHEAT_USE_FZF=true
export LESSOPEN='|/usr/bin/lesspipe.sh %s' # allow less to view non-text files
export LESS=-R
export COLORTERM="truecolor"

# set local location for libraries. If not set compilers cannot find the
# libraries and give us the error:
# export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
export CPATH=/opt/homebrew/include
# export ld_library_path=/opt/homebrew/lib/:$ld_library_path
export LIBRARY_PATH=/opt/homebrew/lib

# llvm, system and homebrewe problem
# export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
# # For compilers to find llvm you may need to set:
# export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
# export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private stuff if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/.local/scripts" ] ; then
    PATH="$HOME/.local/scripts:$PATH"
fi

# Brew thing
eval "$(/opt/homebrew/bin/brew shellenv)"

# Linuxify
# source: https://gist.github.com/skyzyx/3438280b18e4f7c490db8a2a2ca0b9da?permalink_comment_id=3049694#gistcomment-3049694
if type brew &>/dev/null; then
  HOMEBREW_PREFIX=$(brew --prefix)
  # gnubin; gnuman
  for d in ${HOMEBREW_PREFIX}/opt/*/libexec/gnubin; do export PATH=$d:$PATH; done
  for d in ${HOMEBREW_PREFIX}/opt/*/libexec/gnuman; do export MANPATH=$d:$MANPATH; done
fi
