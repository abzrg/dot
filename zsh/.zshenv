# Disable zsh_sessions
# https://apple.stackexchange.com/a/427568/445301
SHELL_SESSIONS_DISABLE=1

# rust
. "$HOME/.cargo/env"

# Allow these aliases to be detected by programs like parallel
alias ytdl="yt-dlp \
            --no-warning \
            --add-metadata -ci \
            --retries inf --retry-sleep 5 \
            -f 'bestvideo[height<=?720]+bestaudio/best'"
alias ytdlpl="ytdl -o '%(playlist_index)s-%(title)s-%(id)s.%(ext)s' \
              --yes-playlist --download-archive archive.txt"
