#
# Alex's bashrc
# ~/.bashrc
#

# Add my local bin directory for my own scripts to the path variable. Doing this
# before the interactivity check allows dmenu to get this path.
export PATH=$PATH:$HOME/bin/

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Run gnome-keyring-daemon to unlock ssh keys when connecting to a server.
if [ -n "$DESKTOP_SESSION" ]; then
    eval $(gnome-keyring-daemon --start --components=ssh)
    export SSH_AUTH_SOCK
fi

# Aliases
alias ls='ls --color=auto'  # Pretty colours for ls
alias :q='exit'             # Quit like it's vim
alias :e='vim'              # Edit like it's vim

# Git command aliases
alias gdf='git --no-pager diff'
alias gst='git status -u'
alias gpl='git pull'
alias gps='git push'
alias gad='git add -A'
alias gcm='git commit -m'
function glg {
    git --no-pager log --reverse --pretty=format:'%C(red)%h%C(reset) -%C(yellow)%d%C(reset) %s %C(green)(%cr) %C(blue)<%an>%C(reset)' --abbrev-commit $@
    echo ""
}


# Prompt style. Include user and host only if on an ssh connection.
if [[ -n $SSH_CLIENT ]]; then SSH_PS1=" \[\e[0;34m\][\[\e[m\]\u@\h\[\e[0;34m\]]\[\e[m\]"; else SSH_PS1=""; fi
PS1="$SSH_PS1 \[\e[0;34m\][\[\e[m\]\W\[\e[0;34m\]]\[\e[m\] \$ "
unset SSH_PS1

# File extensions to ignore in interactive completion
FIGNORE=".aux:.log:.dvi:.class:.o:.pyc:.hi:.swp:.bbl:.blg:"

# Append to histfile when shell exits, rather than overwrite
shopt -s histappend

# Typing only a directory performs a cd there
shopt -s autocd

# Resize shell when terminal resizes
shopt -s checkwinsize

# Set some java options to enable antialiasing and GTK themeing in java apps
# with certain window managers
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true
        -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'

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
