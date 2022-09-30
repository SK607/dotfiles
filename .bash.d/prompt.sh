# ███████╗██╗  ██╗  BASH PROMPT
# ██╔════╝██║ ██╔╝    ┌── ⇅ → user@host *2 gitbranch:dir  
# ███████╗█████╔╝     └─> |  
# ╚════██║██╔═██╗   
# ███████║██║  ██╗  Sergey Konkin 
# ╚══════╝╚═╝  ╚═╝  https://github.com/SK607


__bash_prompt() {
    ## COLORS
    local black="\[\e[00;38;5;0m\]"
    local red="\[\e[00;38;5;1m\]"
    local green="\[\e[0;38;5;2m\]"
    local yellow="\[\e[0;38;5;3m\]"
    local blue="\[\e[0;38;5;4m\]"
    local magenta="\[\e[0;38;5;5m\]"
    local teal="\[\e[0;38;5;6m\]"
    local white="\[\e[2;38;5;7m\]"
    local reset="\[\e[m\]"

    local prompt=''
    ## LINE 1
    prompt+='\n'

    # arrow
    prompt+="$white┌── "

    # ssh/ login status
    if [[ -n "$SSH_CLIENT" ]] || [[ -n "$SSH_TTY" ]]; then
        prompt+="$white⇅ "
    fi
    if [[ -n "$SUDO_USER" ]]; then
        prompt+="$white→ "
    fi

    # user & host
    prompt+="$white$USER@$HOSTNAME "

    # git
    if [[ "$PWD" != "$OLDPWD" ]]; then
        if [[ "$(git rev-parse --is-inside-work-tree 2>/dev/null)" = 'true' ]]; then
            local branch="$(git rev-parse --abbrev-ref HEAD)"
            local uncommitted="*$(git status --porcelain | wc -l) "
            prompt+="$green$uncommitted$branch:"
        fi
    fi

    # directory
    prompt+="$blue$(basename $PWD)"
  
    # python env
    if [[ -x "$VIRTUAL_ENV" ]]; then
        prompt+= "$magenta$(basename $VIRTUAL_ENV) "
    fi

    ## LINE 2
    prompt+='\n'

    # arrow
    prompt+="$white└─> $reset"

    export PS1=$prompt
}

[[ "$VIRTUAL_ENV_DISABLE_PROMPT" != '1' ]] && export VIRTUAL_ENV_DISABLE_PROMPT='1'
export PROMPT_COMMAND=__bash_prompt

