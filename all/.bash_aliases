# ~/.bash_aliases

# Run gnome-keyring-daemon to unlock ssh keys when connecting to a server.
if [ -x "$(command -v gnome-keyring-daemon)" -a -n "$DESKTOP_SESSION" ]; then
    eval $(gnome-keyring-daemon --start --components=ssh)
    export SSH_AUTH_SOCK
fi

# Aliases
alias ls='ls --color=auto'      # Pretty colours for ls
alias grep='grep --color=auto'  # Likewise for grep
alias diff='diff --color=auto'  # Likewise for diff
alias :q='exit'                 # Quit like it's vim
alias vim='nvim'                # Use neovim
alias :e='nvim'                 # Edit like it's (n)vim
alias tmux='tmux -2'            # Force tmux to use 256 colours

# Git command aliases
alias gdf='git --no-pager diff'
alias gst='git status -u'
alias gpl='git pull'
alias gps='git push'
alias gcm='git commit -m'
alias gd='cd $(git rev-parse --show-toplevel)'

# Use (n)vim please
export EDITOR=vim
export VISUAL="$EDITOR"
