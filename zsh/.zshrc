# Profile zsh
# -> https://blog.askesis.pl/post/2017/04/how-to-debug-zsh-startup-time.html
#zmodload zsh/zprof


source "$HOME/.zsh-opts"
source "$HOME/.zsh-histories"
source "$HOME/.zsh-completions"
source "$HOME/.zsh-keybinds"
source "$HOME/.zsh-aliases"
source "$HOME/.zsh-functions"
source "$HOME/.zsh-widgets"
PROMPT='%1~ %% '

eval "$(zoxide init zsh)"


# End profile zsh
#zprof
