if [ -n "$NERD_ENABLED" ]; then
    ICON_SSH=' '
    ICON_CHUSER=' '
    ICON_GIT=' '
    ICON_WD=' '
    ICON_PY=' '
fi

black="\[\e[0;38;5;246m\]"
red="\[\e[0;31m\]"
green="\[\e[0;32m\]"
yellow="\[\e[0;33m\]"
blue="\[\e[0;34m\]"
magenta="\[\e[0;35m\]"
teal="\[\e[0;36m\]"
base=$yellow
reset="\[\e[m\]"

__prompt_icons (){
    local icons=''
    if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
        icons+="${ICON_SSH:-S}"
    fi
    if [ -n "$SUDO_USER" ]; then
        icons+="${ICON_CHUSER:-U}"
    fi
    echo -e "$icons"
}

export VIRTUAL_ENV_DISABLE_PROMPT=1
__prompt_pyenv (){
    if ! [ -z ${VIRTUAL_ENV+x} ]; then
        echo -e " $ICON_PY$(basename "$VIRTUAL_ENV")"
    else
        echo ''
    fi
}

PS1="$base┌─"'$(__prompt_icons)'
PS1+=" $black\u"
PS1+=" $base$ICON_WD\W"
PS1+="$green"'$(__git_ps1 " $ICON_GIT%s")'  # TODO: simplify git 
PS1+="$blue"'$(__prompt_pyenv)'
PS1+="\n$base└────> $reset"

unset black red green yellow blue magenta teal base reset

export PS1
export -f __prompt_pyenv __prompt_icons
