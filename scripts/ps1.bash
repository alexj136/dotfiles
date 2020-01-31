blue="\033[0;34m"
reset="\033[0m"

function git_bit {
    local blue="\033[0;34m"
    local reset="\033[0m"
    status_str="$(git status 2> /dev/null)"
    if [ $? -ne 0 ]; then return 0; fi
    printf "$blue[$reset"
    printf "$status_str" | grep "On branch" | awk '{print $3}' | tr -d '\n'
    printf "$blue]$reset "
    unset status_str
}

PS1=" "
if [[ -n $SSH_CLIENT ]]; then
    PS1+="\[$blue\][\[$reset\]\u@\h\[$blue\]]\[$reset\] "
fi
PS1+="\[$blue\][\[$reset\]\W\[$blue\]]\[$reset\] "
PS1+="\$(git_bit)"
PS1+="\$ "

unset blue
unset reset

export PS1
