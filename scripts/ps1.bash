blue="\033[0;34m"
reset="\033[0m"

PS1=" "
if [[ -n $SSH_CLIENT ]]; then
    PS1+="\[$blue\][\[$reset\]\u@\h\[$blue\]]\[$reset\] "
fi
PS1+="\[$blue\][\[$reset\]\W\[$blue\]]\[$reset\] "
PS1+="\$ "

unset blue
unset reset

export PS1
