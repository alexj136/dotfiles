blue="\033[0;34m"
reset="\033[0m"

function git_color {
    local red="\033[0;31m"
    local yellow="\033[0;33m"
    local green="\033[0;32m"
    local ochre="\033[38;5;95m"

    local git_status="$(git status 2> /dev/null)"

    if [[ ! $git_status =~ "working directory clean" ]]; then
        echo -e $red
    elif [[ $git_status =~ "Your branch is ahead of" ]]; then
        echo -e $yellow
    elif [[ $git_status =~ "nothing to commit" ]]; then
        echo -e $green
    else
        echo -e $ochre
    fi
}

function git_branch {
  local git_status="$(git status 2> /dev/null)"
  local on_branch="On branch ([^${IFS}]*)"
  local on_commit="HEAD detached at ([^${IFS}]*)"

  if [[ $git_status =~ $on_branch ]]; then
    local branch=${BASH_REMATCH[1]}
    echo "[$branch] "
  elif [[ $git_status =~ $on_commit ]]; then
    local commit=${BASH_REMATCH[1]}
    echo "[$commit] "
  fi
}

PS1=""
if [[ -n $SSH_CLIENT ]]; then
    PS1+=" \[$blue\][\[$reset\]\u@\h\[$blue\]]\[$reset\]"
fi
PS1+=" \[$blue\][\[$reset\]\W\[$blue\]]\[$reset\] "
PS1+="\[\$(git_color)\]"
PS1+="\$(git_branch)"
PS1+="\[$reset\]\$ "

unset blue
unset reset

export PS1
