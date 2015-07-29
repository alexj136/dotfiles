#
# Alex's bashrc
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Aliases
alias ls='ls --color=auto'  # Pretty colours for ls
alias :q='exit'             # Quit like it's vim

# Prompt style
PS1='\[\e[0;34m\][\[\e[m\]\u@\h\[\e[0;34m\]] [\[\e[m\]\A \D{%d-%m-%y}\
\[\e[0;34m\]] [\[\e[m\]\W\[\e[0;34m\]]\[\e[m\] \$ '

# File extensions to ignore
FIGNORE=".aux:.log:.dvi:.class:.o:.pyc:.hi:.swp:.bbl:.blg:"

# Append to histfile when shell exits, rather than overwrite
shopt -s histappend

# Add my scripts directory to the path variable
export PATH=$PATH:$HOME/scripts/

# Set some java options to enable antialiasing, etcetera
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
