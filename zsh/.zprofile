export LANG="en_US.UTF-8"
export EDITOR="nvim"
export VISUAL="nvim"
export TERMINAL="alacritty"
# export BROWSER="open -a 'Brave Browser'"
export READER="zathura"
export PAGER="less"
export TERM="tmux-256color"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export LESSHISTFILE='-' # no history file for less

# PATH
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi
if [ -d "$HOME/.local/bin/scripts" ] ; then
    PATH="$HOME/.local/bin/scripts:$PATH"
fi
if [ -d "$HOME/go/bin" ] ; then
    PATH="$HOME/go/bin:$PATH"
fi

# brew (macos)
if [ $(uname -s) = "Darwin" ]
then
    eval "$(/opt/homebrew/bin/brew shellenv)"

    # Ruby
    if [ -d "/opt/homebrew/opt/ruby/bin" ]; then
        export PATH=/opt/homebrew/opt/ruby/bin:$PATH
        export PATH=`gem environment gemdir`/bin:$PATH
    fi

    # C
    # export LD_LIBRARY_PATH=/opt/homebrew/lib/:$LD_LIBRARY_PATH

    # Necessary for OpenFOAM-esi on M1 Mac
    export CPATH="/opt/homebrew/include:$CPATH"
    export LIBRARY_PATH="/opt/homebrew/lib:$LIBRARY_PATH"

    # LLVM
    export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
    # export CC="/opt/homebrew/opt/llvm/bin/clang"
    # export CXX="/opt/homebrew/opt/llvm/bin/clang++"
    # export LDFLAGS="$LDFLAGS -L/opt/homebrew/opt/llvm/lib"
    # export CPPFLAGS="$CPPFLAGS -I/opt/homebrew/opt/llvm/include -Wall -Wextra"
    # export CFLAGS="$CFLAGS -I/opt/homebrew/opt/llvm/include -Wall -Wextra"

    # Enable memory leak detection for clang sanitizers
    export ASAN_OPTIONS=detect_leaks=1

    # curl
    export PATH="/opt/homebrew/opt/curl/bin:$PATH"
    # export LDFLAGS="$LDFLAGS -L/opt/homebrew/opt/curl/lib"
    # export CPPFLAGS="$CPPFLAGS -I/opt/homebrew/opt/curl/include"

    # For pkg-config to find curl you may need to set:
    export PKG_CONFIG_PATH="/opt/homebrew/opt/curl/lib/pkgconfig"

    # gnu's version of info (texinfo)
    export PATH="/opt/homebrew/opt/texinfo/bin:$PATH"

    # gnu coreutils
    export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"

    # gnused (needed by openfoam)
    export PATH="/opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH"

    # gnu find, xargs
    export PATH="/opt/homebrew/opt/findutils/libexec/gnubin:$PATH"

    # gnu make
    export PATH="/opt/homebrew/opt/make/libexec/gnubin:$PATH"

    # paraview and friends
    export PATH="/Applications/ParaView-5.10.1.app/Contents/bin:$PATH"

    # java (keg-only)
    export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

    # Dotnet
    export DOTNET_ROOT="/opt/homebrew/opt/dotnet/libexec"

    # M4
    export PATH="/opt/homebrew/opt/m4/bin:$PATH"

    # libxml2
    export PATH="/opt/homebrew/opt/libxml2/bin:$PATH"
    # export LDFLAGS="-L/opt/homebrew/opt/libxml2/lib $LDFLAGS"
    # export CPPFLAGS="-I/opt/homebrew/opt/libxml2/include $CPPFLAGS"

    # LAMMPS
    export DYLD_LIBRARY_PATH="$HOME/.local/lib:$DYLD_LIBRARY_PATH"  # Macos

    # pkg config
    PKG_CONFIG_PATH="/opt/homebrew/lib/pkgconfig:$PKG_CONFIG_PATH"
    PKG_CONFIG_PATH="$HOME/.local/lib/pkgconfig:$PKG_CONFIG_PATH"
    export PKG_CONFIG_PATH
fi


# Colorful googletest in CMake
export GTEST_COLOR=1


# # python startup file
# export PYTHONSTARTUP=~/.pystartup

# # Python 3.13 environment as the base environment without prompt
# VIRTUAL_ENV_DISABLE_PROMPT=1 source ~/opt/py/3.13/bin/activate


# Added by `rbenv init`
eval "$(rbenv init - --no-rehash zsh)"

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
# source ~/.orbstack/shell/init.zsh 2>/dev/null || :


# Neomutt
# On mac, probably for dns lookups, it opens with a 5-7 seconds startup delay,
# so, I bulid from source, with an extra flag: --with-domain
export PATH="$PATH:$HOME/opt/neomutt/bin"

# OpenCL cpp headers
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:/opt/homebrew/opt/opencl-clhpp-headers/share/pkgconfig"

# rust
export PATH="$PATH:$HOME/.rustup/toolchains/stable-aarch64-apple-darwin/bin"
export PATH="$HOME/.cargo/bin:$PATH"

# haskell
export PATH="$HOME/.ghcup/bin:$PATH"


cal -A1 -B1

# (macos) Turn off icon bouncing (alacritty)
# https://github.com/alacritty/alacritty/issues/2950#issuecomment-706610878
printf "\e[?1042l"



# PETSC
export PETSC_DIR=/opt/homebrew/Cellar/petsc/3.23.3
export PETSC_ARCH=arch-darwin-c-opt

# Create some issues with Openfoam+Petsc
export HWLOC_COMPONENTS=-opencl

# PLANS
export PLANFILE="$HOME/..plann"
