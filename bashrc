#
# Alex's bashrc
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Aliases
alias ls='ls --color=auto'  # Pretty colours for ls
alias vim='vim -p'          # Open each file in a separate tab (console vim)
alias gvim='gvim -p'        # Open each file in a separate tab (gvim)

# Prompt style
PS1='[\u@\h \W]\$ '

# File extensions to ignore
FIGNORE=".aux:.log:.dvi:.class:.o:.pyc:.hi:.swp:"
