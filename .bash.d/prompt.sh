if [ -n "$PROMPT_NERD_ENABLED" ]; then
    ICON_SSH=' '
    ICON_CHUSER=' '
    ICON_GIT=' '
    ICON_WD=' '
    ICON_PY=' '
fi

red="\[\e[00;38;5;1m\]"
green="\[\e[0;38;5;2m\]"
yellow="\[\e[0;38;5;3m\]"
blue="\[\e[0;38;5;4m\]"
magenta="\[\e[0;38;5;5m\]"
teal="\[\e[0;38;5;6m\]"
black="\[\e[00;38;5;8m\]"
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

__prompt_pyenv (){
    if ! [ -z ${VIRTUAL_ENV+x} ]; then
        echo -e " $ICON_PY$(basename "$VIRTUAL_ENV")"
    else
        echo ''
    fi
}

! [ -x "$(command -v __git_ps_1)" ] && source /usr/share/git/git-prompt.sh

# git rev-parse --git-dir --is-inside-git-dit --is-bar-repository --is-inside-work-tree --short HEAD
# git describe --contains --all head

PS1="$black┌───"' $(__prompt_icons)'
PS1+="$black\u"
PS1+=" $blue$ICON_WD\W"
PS1+="$green"'$(__git_ps1 " $ICON_GIT%s")'  # TODO: simplify git 
PS1+="$magenta"'$(__prompt_pyenv)'
PS1+="\n$black└─> $reset"

unset red green yellow blue magenta teal black reset

export PS1
export -f __prompt_pyenv __prompt_icons
