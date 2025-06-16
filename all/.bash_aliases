# ~/.bash_aliases

# General aliases
alias ls='ls --color=auto'      # Pretty colours for ls
alias grep='grep --color=auto'  # Likewise for grep
alias diff='diff --color=auto'  # Likewise for diff
alias :q='exit'                 # Quit like it's vim
alias vim='nvim'                # Use neovim
alias :e='nvim'                 # Edit like it's (n)vim
alias tmux='tmux -2'            # Force tmux to use 256 colours
function pcp {
    python3 -c "from math import *; from random import *; print($@)"
}

# Git command aliases
alias gst='git status -u'
alias gpl='git pull'
alias gps='git push'
alias gcm='git commit -m'
alias gd='cd $(git rev-parse --show-toplevel)'
function glg {
    if [ $# -eq 0 ]; then
        local current_branch=$(git rev-parse --abbrev-ref HEAD)
        local default_branch=$(git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@')
        if [[ "$default_branch" == "$current_branch" ]]; then
            local args="-1"
        else
            local args="$default_branch..$current_branch"
        fi
    else
        local args=$@
    fi
    git --no-pager log --reverse --pretty=format:'%C(red)%h%C(reset)%C(yellow)%d%C(reset) %C(green)(%cr) %C(blue)<%an>%C(reset)%n%s' --abbrev-commit $args
    echo ""
}

# Use (n)vim please
export EDITOR=vim
export VISUAL="$EDITOR"
