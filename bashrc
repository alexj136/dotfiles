#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Pretty colours for ls
alias ls='ls --color=auto'

# Prompt style
PS1='[\u@\h \W]\$ '

# File extensions to ignore
FIGNORE=".aux:.log:.dvi:.class:.o:.pyc:.hi:.swp:"
