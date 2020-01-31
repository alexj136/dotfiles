blue="\033[0;34m"
reset="\033[0m"

function git_ps1 {
    local red="\033[0;31m"
    local yellow="\033[0;33m"
    local green="\033[0;32m"
    local ochre="\033[38;5;95m"

    local git_status="$(git status 2> /dev/null)"

    if [[ ! $git_status =~ "working directory clean" ]]; then
        printf $red
    elif [[ $git_status =~ "Your branch is ahead of" ]]; then
        printf $yellow
    elif [[ $git_status =~ "nothing to commit" ]]; then
        printf $green
    else
        printf $ochre
    fi

    local on_branch="On branch ([^${IFS}]*)"
    local on_commit="HEAD detached at ([^${IFS}]*)"

    if [[ $git_status =~ $on_branch || $git_status =~ $on_commit ]]; then
        echo "[${BASH_REMATCH[1]}] "
    fi
}

PS1=""
if [[ -n $SSH_CLIENT ]]; then
    PS1+=" \[$blue\][\[$reset\]\u@\h\[$blue\]]\[$reset\]"
fi
PS1+=" \[$blue\][\[$reset\]\W\[$blue\]]\[$reset\] "
PS1+="\[\$(git_ps1)\]"
PS1+="\[$reset\]\$ "

unset blue
unset reset

export PS1
