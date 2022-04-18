# -- Defualt programs --

    export LANG="en_US.UTF-8"
    export EDITOR="nvim"
    export VISUAL="nvim"
    export TERMINAL="alacritty"
    export BROWSER="brave"
    export READER="zathura"
    export PAGER="less"

# -- ~/ Clean up --

    export XDG_CONFIG_HOME="$HOME/.config"
    export XDG_DATA_HOME="$HOME/.local/share"
    export XDG_CACHE_HOME="$HOME/.cache"
    export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"
    export CARGO_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/cargo"
    export RUSTUP_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/cargo"
    export LESSHISTFILE='-' # no history file for less
    export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc


# -- fzf settings --

    export FZF_DEFAULT_COMMAND='fd -t f -t l -H' # Including hidden files in search
    export FZF_DEFAULT_OPTS="
        --layout=reverse --height 40% --preview-window=border-sharp
    "
    export CHEAT_USE_FZF=true
    export LESSOPEN='|/usr/bin/lesspipe.sh %s' # allow less to view non-text files
    export LESS=-R
    export COLORTERM="truecolor"


# -- if running bash --

    if [ -n "$BASH_VERSION" ]; then
        # include .bashrc if it exists
        if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
        fi
    fi


# -- set PATH so it includes user's private stuff if it exists --

    if [ -d "$HOME/bin" ] ; then
        PATH="$HOME/bin:$PATH"
    fi

    if [ -d "$HOME/.local/bin" ] ; then
        PATH="$HOME/.local/bin:$PATH"
    fi

    if [ -d "$HOME/.local/scripts" ] ; then
        PATH="$HOME/.local/scripts:$PATH"
    fi


# -- brew (on macos) --

    if [ -d /opt/homebrew ]; then
      export HOMEBREW_PREFIX="/opt/homebrew"
      export HOMEBREW_CELLAR="/opt/homebrew/Cellar"
      export HOMEBREW_NO_AUTO_UPDATE=1
      export HOMEBREW_REPOSITORY="/opt/homebrew"
    fi

    if [ $(uname -s) = "Darwin" ]
    then
        # set local location for libraries. If not set compilers cannot find the
        # libraries and give us the error:
        export CPATH=/opt/homebrew/include
        # export ld_library_path=/opt/homebrew/lib/:$ld_library_path
        export LIBRARY_PATH=/opt/homebrew/lib

        # llvm, system and homebrew problem
        export PATH="/opt/homebrew/opt/llvm/bin:$PATH"

        # For compilers to find llvm you may need to set:
        export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
        export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"

        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [ $(uname -s) = "Linux" ]
    then
        export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
    fi
