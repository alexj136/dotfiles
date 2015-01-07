#
# Alex's bashrc
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Aliases
alias ls='ls --color=auto'  # Pretty colours for ls

# Prompt style
PS1='[\u@\h \W]\$ '

# File extensions to ignore
FIGNORE=".aux:.log:.dvi:.class:.o:.pyc:.hi:.swp:"

# Append to histfile when shell exits, rather than overwrite
shopt -s histappend

# Add my scripts directory to the path variable
export PATH=$PATH:$HOME/scripts/

# Set some java options to enable antialiasing, etcetera
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true
        -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'
