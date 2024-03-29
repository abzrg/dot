# -- Defualt programs --

    export LANG="en_US.UTF-8"
    export EDITOR="nvim"
    export VISUAL="nvim"
    export TERMINAL="alacritty"
    export BROWSER="brave"
    export READER="zathura"
    export PAGER="less"
    export TERM="tmux-256color"

# -- ~/ Clean up (meh) --

    export XDG_CONFIG_HOME="$HOME/.config"
    export XDG_DATA_HOME="$HOME/.local/share"
    export XDG_CACHE_HOME="$HOME/.cache"
    export LESSHISTFILE='-' # no history file for less
    export BIB="$HOME/Documents/bib/references.bib"  # Mega bibliography file for Latex


# -- fzf settings --

    # export FZF_DEFAULT_COMMAND='fd -t f -t l -H' # Including hidden files in search
    export FZF_DEFAULT_OPTS="--layout=reverse --height 40% --preview-window=border-sharp"
    export CHEAT_USE_FZF=true
    # allow less to view non-text files
    if [ $(uname -s) = "Darwin" ]; then
      export LESSOPEN='|/opt/homebrew/bin/lesspipe.sh %s'
    else
      export LESSOPEN='|/usr/bin/lesspipe.sh %s' # allow less to view non-text files
    fi
    export LESS=-R
    export COLORTERM="truecolor"


# -- if running bash --

    if [ -n "$BASH_VERSION" ]; then
        # include .bashrc if it exists
        if [ -f "$HOME/.bashrc" ]; then
            . "$HOME/.bashrc"
        fi
    fi


# -- Notes

    export NOTES_DIR='~/Git/projects/notes/'


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

    if [ $(uname -s) = "Darwin" ]
    then
        # -- brew
        eval "$(/opt/homebrew/bin/brew shellenv)"

        # -- set local location for libraries. If not set compilers cannot find the libraries and give us the error:
        export ld_library_path=/opt/homebrew/lib/:$ld_library_path
        export CPATH=/opt/homebrew/include
        export LIBRARY_PATH=/opt/homebrew/lib

        # -- llvm, system and homebrew problem
            export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
            export CXX="/opt/homebrew/opt/llvm/bin/clang++"
            export CC="/opt/homebrew/opt/llvm/bin/clang"
            #export LDFLAGS="-L/opt/homebrew/opt/llvm/lib/c++ -Wl,-rpath,/opt/homebrew/opt/llvm/lib/c++"

            # For compilers to find llvm you may need to set:
            #export LDFLAGS="$LDFLAGS -L/opt/homebrew/opt/llvm/lib -lm"
            #export CPPFLAGS="$LDFLAGS -I/opt/homebrew/opt/llvm/include -Wall -Wextra"
            #export CFLAGS="$CFLAGS -I/opt/homebrew/opt/llvm/include -Wall -Wextra"

            # Enable memory leak detection for clang sanitizers
            #export ASAN_OPTIONS=detect_leaks=1

        # -- curl
            export PATH="/opt/homebrew/opt/curl/bin:$PATH"
            #export LDFLAGS="$LDFLAGS -L/opt/homebrew/opt/curl/lib"
            #export CPPFLAGS="$CPPFLAGS -I/opt/homebrew/opt/curl/include"

            # For pkg-config to find curl you may need to set:
            # export PKG_CONFIG_PATH="/opt/homebrew/opt/curl/lib/pkgconfig"

        # -- gnu's version of info (texinfo)
        #export PATH="/opt/homebrew/opt/texinfo/bin:$PATH"

        # -- gnu coreutils
        export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"

        # -- gnused (needed by openfoam)
        export PATH="/opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH"

        # -- gnu find, xargs
        export PATH="/opt/homebrew/opt/findutils/libexec/gnubin:$PATH"

        # -- gnu make
        export PATH="/opt/homebrew/opt/make/libexec/gnubin:$PATH"

        # -- paraview and friends
        export PATH="/Applications/ParaView-5.10.1.app/Contents/bin:$PATH"

        # -- java (keg-only)
        #export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

        # -- Python pip packages
        export PATH="/opt/homebrew/opt/python@3.12/libexec/bin:$PATH"
        export PATH="/opt/homebrew/lib/python3.12/site-packages:$PATH"
        export PATH="/opt/homebrew/opt/python@3.11/libexec/bin:$PATH"
        export PATH="/opt/homebrew/lib/python3.11/site-packages:$PATH"
        export PATH="/opt/homebrew/opt/python@3.10/libexec/bin:$PATH"
        export PATH="/opt/homebrew/lib/python3.10/site-packages:$PATH"
    fi


# -- Colorful googletest in CMake

    export GTEST_COLOR=1
