#
# Alex's bashrc
# ~/.bashrc
#

# Additional paths:
# ~/bin/
# ~/.local/bin/
export PATH=$PATH:$HOME/bin/:$HOME/.local/bin

# Ruby gems stuff
export GEM_HOME=$HOME/.gem
export PATH="$PATH:$(ruby -e 'print Gem.user_dir')/bin"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Run gnome-keyring-daemon to unlock ssh keys when connecting to a server.
if [ -n "$DESKTOP_SESSION" ]; then
    eval $(gnome-keyring-daemon --start --components=ssh)
    export SSH_AUTH_SOCK
fi

# Aliases
alias ls='ls --color=auto'      # Pretty colours for ls
alias grep='grep --color=auto'  # Likewise for grep
alias diff='diff --color=auto'  # Likewise for diff
alias :q='exit'                 # Quit like it's vim
alias :e='vim'                  # Edit like it's vim
alias tmux='tmux -2'            # Force tmux to use 256 colours

# Git command aliases
alias gdf='git --no-pager diff'
alias gst='git status -u'
alias gpl='git pull'
alias gps='git push'
alias gad='git add -A'
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

# Set some java options to enable antialiasing and GTK themeing in java apps
# with certain window managers
#export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true
#        -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'

# A helpful function to separate text on the terminal. Prints two lines of
# equal signs, and if any arguments are given, the appear between the lines.
function divider {
    function line {
        for j in {1..80}
        do
            printf "="
        done
        printf "\n"
    }
    line
    if [ "$#" -gt "0" ]; then
        echo "$@"
    fi
    line
    unset line
}

function pcp {
    python -c "print($@)"
}
