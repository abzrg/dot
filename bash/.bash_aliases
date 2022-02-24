#/bin/bash

# -----------------------------------------------------------------------------
# Disable "spell-correction" for this commands:
alias \
    cp="cp -iv"                                                               \
    mv="mv -iv"                                                               \
    rm="rm -v"                                                                \
    mkd="mkdir -pv"                                                           \
    ln="ln -iv"

# -----------------------------------------------------------------------------
# Colorize commands
alias \
    grep="grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}"           \
    egrep="egrep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}"         \
    fgrep="fgrep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}"         \
    diff="diff"                                                               \

# ----------------------------------------------------------------------------
# ls
alias \
    ls='ls -hFG --color=auto'                                                 \
    l='ls'                                                                    \
    la='ls -A'                                                                \
    ll='ls -Ali'                                                              \
    sl='ls'

# -----------------------------------------------------------------------------
# Long commands
alias \
    bc='bc -ql'                                                               \
    df='df -h'                                                                \
    v="$EDITOR"                                                               \
    g="git"                                                                   \
    ka="killall"                                                              \
    type="type -a"                                                            \
    free='free -m'                                                            \
    chbin='chmod 755'                                                         \
    chreg='chmod 644'                                                         \
    wget="wget --hsts-file ~/.cache/wget-hsts"                                \
    myip="curl http://myip.dnsomatic.com && echo ''"                          \

# -----------------------------------------------------------------------------
# Directories
alias \
    cd..='cd ..'                                                              \
    cf="cd ${XDG_CONFIG_HOME:-$HOME/.config}"                                 \
    dl="cd ${XDG_DOWNLOAD_DIR:-$HOME/Downloads}"                              \
    dt="cd ${XDG_DATA_HOME:-$HOME/.local/share}"                              \
    bin="cd $HOME/.local/bin"                                                 \
    doc="cd ${XDG_DOCUMENTS_DIR:-$HOME/Documents}"                            \
    pic="cd ${XDG_PICTURES_DIR:-$HOME/Pictures}"                              \
    vid="cd ${XDG_VIDEOS_DIR:-$HOME/Movies}"                                  \

# -----------------------------------------------------------------------------
# Config files
alias \
    cfz="$EDITOR $HOME/.zshrc"                                                \
    cfb="$EDITOR $HOME/.bashrc"                                               \
    cfzp="$EDITOR $HOME/.zprofile"                                            \
    cfp="$EDITOR $HOME/.profile"                                              \
    cft="$EDITOR $HOME/.tmux.conf"                                            \
    cfa="$EDITOR ${HOME}/.bash_aliases"                                       \

# -----------------------------------------------------------------------------
# youtube-dl / yt-dlp

alias yt="yt-dlp --add-metadata -ci --external-downloader aria2c --external-downloader-args '-c -x 5 -k 2M '"    \
    yta="yt -x -f bestaudio/best"                                             \
    ytb="yt -f bestvideo+bestaudio"                                           \
    yt7="yt -f 'bestvideo[height<=?720]+bestaudio/best' "                     \
    yts="yt-dlp --all-subs --skip-download"                                   \
    ytas="yt-dlp --skip-download --write-auto-sub --convert-subs=srt"         \
    yt7pl="yt7 -o '%(playlist_index)s-%(title)s.%(ext)s'"                     \
    ytbpl="ytb -o '%(playlist_index)s-%(title)s.%(ext)s'"

# -----------------------------------------------------------------------------
# Other

# vim and neovim config
alias cfv="$EDITOR ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/init.lua"

# ascii table
alias ascii='man ascii | grep -m 1 -A 63 --color=never Oct | less'

# special regex
alias reg_mac='echo ^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$'
alias reg_git_hash='echo \b[0-9a-f]{5,40}\b'

# Pretty print the path
alias path='echo $PATH | tr -s ":" "\n"'

# Use nevim for vim if present.
command -v nvim >/dev/null && alias vimdiff="nvim -d"
