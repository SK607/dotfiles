# ███████╗██╗  ██╗  BASH PROMPT
# ██╔════╝██║ ██╔╝    ┌── user@host *2 branch:dir  
# ███████╗█████╔╝     └─> 
# ╚════██║██╔═██╗   
# ███████║██║  ██╗  Sergey Konkin 
# ╚══════╝╚═╝  ╚═╝  https://github.com/SK607


__bash_git_cache() {
    if [[ "${_PWD_PREV:-none}" != "$PWD" ]]; then
        export _PWD_PREV=$PWD

        if [[ "${_GIT_ROOT:-none}" != "${PWD:0:${#_GIT_ROOT}}" ]]; then
            git_root=$(git rev-parse --show-toplevel 2>/dev/null)
            export _GIT_ROOT=$git_root
        fi
    fi

    if [[ -n "$_GIT_ROOT" ]]; then
        local git_branch git_branch_modify
        local git_uncommitted git_uncommitted_modify
        git_branch_modify=$(date -r "$_GIT_ROOT/.git/HEAD" +%s)
        git_uncommitted_modify=$(date -r "$_GIT_ROOT" +%s)

        if [[ ${_GIT_BRANCH_MODIFY:-0} -lt $git_branch_modify ]]; then
            git_branch="$(git symbolic-ref --short HEAD):"
            export _GIT_BRANCH_MODIFY=$git_branch_modify
            export _GIT_BRANCH=$git_branch
        fi

        if [[ ${_GIT_UNCOMMITTED_MODIFY:-0} -lt $git_uncommitted_modify ]]; then
            git_uncommitted="*$(git status --porcelain | wc -l) "
            export _GIT_UNCOMMITTED_MODIFY=$git_uncommitted_modify
            export _GIT_UNCOMMITTED=$git_uncommitted
        fi

    elif [[ -n "$_GIT_BRANCH" ]]; then
        export _GIT_BRANCH=''
        export _GIT_UNCOMMITTED=''
    fi
}

__bash_prompt() {
    ## COLORS
    # local black="\[\e[00;38;5;0m\]"
    # local red="\[\e[00;38;5;1m\]"
    local green="\[\e[0;38;5;2m\]"
    local yellow="\[\e[0;38;5;3m\]"
    local blue="\[\e[0;38;5;4m\]"
    local magenta="\[\e[0;38;5;5m\]"
    # local teal="\[\e[0;38;5;6m\]"
    local white="\[\e[2;38;5;7m\]"
    local reset="\[\e[m\]"

    local prompt=''
    ## LINE 1
    prompt+='\n'

    # arrow
    prompt+="$white┌── "

    # user
    if [[ -n "$SUDO_USER" ]]; then
        prompt+="$yellow"
    else
        prompt+="$white"
    fi
    prompt+="$USER"

    # host
    if [[ -n "$SSH_CLIENT" ]] || [[ -n "$SSH_TTY" ]]; then
        prompt+="$yellow"
    else
        prompt+="$white"
    fi
    prompt+="@$HOSTNAME "

    # git
    __bash_git_cache
    prompt+="$green$_GIT_UNCOMMITTED$_GIT_BRANCH"

    # directory
    prompt+="$blue$(basename "$PWD")"
  
    # python env
    if [[ -x "$VIRTUAL_ENV" ]]; then
        prompt+= "$magenta$(basename "$VIRTUAL_ENV") "
    fi

    ## LINE 2
    prompt+='\n'

    # arrow
    prompt+="$white└─> $reset"

    export PS1=$prompt
}

[[ "$VIRTUAL_ENV_DISABLE_PROMPT" != '1' ]] && export VIRTUAL_ENV_DISABLE_PROMPT='1'
export -f __bash_git_cache   
export PROMPT_COMMAND=__bash_prompt

