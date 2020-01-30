#
# Alex's bashrc
# ~/.bashrc
#

# Add additional paths: ~/bin/ and ~/.local/bin/
export PATH=$PATH:$HOME/bin/:$HOME/.local/bin

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

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
function glg {
    git --no-pager log --reverse --pretty=format:'%C(red)%h%C(reset)%C(yellow)%d%C(reset) %C(green)(%cr) %C(blue)<%an>%C(reset)%n%s' --abbrev-commit $@
    echo ""
}
function gcl {
    if [[ $# -eq 1 ]]; then
        git clone "git+ssh://git@github.com/alexj136/$1.git"
    elif [[ $# -eq 2 ]]; then
        git clone "git+ssh://git@github.com/$1/$2.git"
    else
        echo "Usage: gcl username? reponame"
        echo "Default user: alexj136"
    fi
}
function gd {
    # cd to the root of the git repo we're in, if any
    git status &> /dev/null
    if [ $? -ne 0 ]; then
        echo "fatal: not a git repository (or any of the parent directories): .git"
        return 1
    fi
    GIT_ROOT=$(git rev-parse --show-toplevel)
    echo "cd $GIT_ROOT"
    cd "$GIT_ROOT"
    unset GIT_ROOT
}

# Prompt style. Include user and host only if on an ssh connection.
if [[ -n $SSH_CLIENT ]]; then SSH_PS1=" \[\e[0;34m\][\[\e[m\]\u@\h\[\e[0;34m\]]\[\e[m\]"; else SSH_PS1=""; fi
PS1="$SSH_PS1 \[\e[0;34m\][\[\e[m\]\W\[\e[0;34m\]]\[\e[m\] \$ "
unset SSH_PS1

# File extensions to ignore in interactive completion
FIGNORE=".aux:.log:.dvi:.class:.o:.pyc:.hi:.swp:.bbl:.blg:.toc:"

# Append to histfile when shell exits, rather than overwrite
shopt -s histappend

# Typing only a directory performs a cd there
shopt -s autocd

# Resize shell when terminal resizes
shopt -s checkwinsize

# Enable fzf (fuzzy finder) if installed - run with Ctrl+T or **<Tab>
if [ -x "$(command -v fzf)" ]; then
    source /usr/share/fzf/key-bindings.bash
    source /usr/share/fzf/completion.bash
fi

# Python expression evaluator
function pcp {
    python -c "
from math import *
print($@)
"
}

# Source bash completion files
for file in $(find $HOME/.dotfiles/completions/ -type f); do
    source "$file"
done
unset file

# Source a local bashrc if available
if [ -f "$HOME/.bashrc.local" ]; then
    source "$HOME/.bashrc.local"
fi
