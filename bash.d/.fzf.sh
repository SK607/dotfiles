# AUTO-COMPLETION
[[ $- == *i* ]] && source "$HOME/.local/opt/fzf/shell/completion.bash" 2> /dev/null


# DEFAULTS
export FZF_DEFAULT_OPTS='--color=bg+:#282c34,bg:#282c34,spinner:#fb4934,hl:#928374,fg:#ebdbb2,header:#928374,info:#8ec07c,pointer:#fb4934,marker:#fb4934,fg+:#ebdbb2,prompt:#fb4934,hl+:#fb4934 --bind up:preview-up,down:preview-down'


# HISTORY search
export FZF_HIST_PREVIEW='echo {}'
if [ -x "$(command -v bat)" ]; then
    export FZF_HIST_PREVIEW='echo {} | bat -l bash -p --color=always'
fi

__writecmd__() {
    local cmd="$@"
    READLINE_LINE="${READLINE_LINE:0:$READLINE_POINT}$cmd${READLINE_LINE:$READLINE_POINT}"
    READLINE_POINT=$(( READLINE_POINT + ${#cmd} ))
}

__fhist__() {
    local selected
    IFS=: read -ra selected < <(
    export HISTTIMEFORMAT= &&
        export HISTSIZE= &&
        builtin history |
        cut -c 8- |
        fzf $FZF_DEFAULT_OPTS \
        --tiebreak=index \
        --tac \
        --no-multi \
        --reverse \
        --preview-window down:hidden:3:wrap \
        --preview "${FZF_HIST_PREVIEW}" \
        --height ${FZF_TMUX_HEIGHT:-40%} \
        --prompt '> ' \
        --bind 'ctrl-c:execute-silent(echo -n {..} | xclip -sel clip)+abort' \
        --bind 'ctrl-s:toggle-preview' \
        --header 'C-s(how)  C-c(opy)'
    )
    [ -n "${selected[0]}" ] && __writecmd__ "$selected"
}

bind -m emacs-standard '"\er": redraw-current-line'
bind -m emacs-standard -x '"\C-r": __fhist__'
bind -m vi-command -x '"\C-r": __fhist__'
bind -m vi-insert -x '"\C-r": __fhist__'


# DIRECTORY search
export FZF_DIR_PREVIEW='ls --group-directories-first -t {}'
if [ -x "$(command -v exa)" ]; then
    export FZF_DIR_PREVIEW='exa -L 1 --group-directories-first --sort=modified --reverse --icons {}'
fi

fcd() {
    local CMD DIR
    CMD="fd --type d --follow --no-hidden -a . $@"
    DIR=$(
    FZF_DEFAULT_COMMAND="$CMD" \
        fzf $FZF_DEFAULT_OPTS \
        --no-multi \
        --reverse \
        --preview-window hidden:wrap \
        --preview "$FZF_DIR_PREVIEW" \
        --height ${FZF_TMUX_HEIGHT:-40%} \
        --prompt '> ' \
        --bind 'ctrl-s:toggle-preview' \
        --bind "ctrl-a:change-prompt(all> )+reload($CMD --unrestricted)" \
        --bind "ctrl-b:change-prompt(> )+reload($CMD)" \
        --header 'C-s(how)  C-a(ll)  C-b(ase)' 
    )
    [ -n "$DIR" ] && cd "$DIR"
}


# FILE search
export FZF_FILE_PREVIEW='head -1000 {1}'
if [ -x "$(command -v bat)" ]; then
    export FZF_FILE_PREVIEW='bat -n {1} --color=always --highlight-line {2}'
fi

fvi() {
    local CMD FILES
    CMD="fd --type f --follow --no-hidden -a . $@"
    FILES=$(
    FZF_DEFAULT_COMMAND="$CMD" \
        fzf $FZF_DEFAULT_OPTS \
        --multi \
        --reverse \
        --preview-window hidden:wrap \
        --preview "$FZF_FILE_PREVIEW" \
        --height ${FZF_TMUX_HEIGHT:-40%} \
        --prompt '> ' \
        --bind 'ctrl-s:toggle-preview' \
        --bind "ctrl-a:change-prompt(all> )+reload($CMD --unrestricted)" \
        --bind "ctrl-b:change-prompt(> )+reload($CMD)" \
        --header 'C-s(how)  C-a(ll)  C-b(ase)' 
    )
    echo "$FILES"
    [ -n "${FILES}" ] && vim -O -- $FILES
}


# STRING search
if [ -x "$(command -v rg)" ]; then
    fvis() {
        local FZF_STR_CMD initial_query
        FZF_STR_CMD="rg --column --line-number --no-heading --color=always --smart-case "
        initial_query="${*:-}"
        IFS=: read -ra selected < <(
            FZF_DEFAULT_COMMAND="$FZF_STR_CMD $(printf %q "$initial_query")" \
            fzf $FZF_DEFAULT_OPTS \
            --ansi \
            --no-multi \
            --disabled --query "$initial_query" \
            --delimiter ':' \
            --preview "$FZF_FILE_PREVIEW" \
            --preview-window 'up,70%,border-bottom' \
            --prompt 'rg> ' \
            --bind "change:reload:sleep 0.1; $FZF_STR_CMD {q} || true" \
            --bind "ctrl-f:unbind(change,ctrl-f)+change-prompt(fzf> )+enable-search+clear-query+rebind(ctrl-r)" \
            --bind "ctrl-r:unbind(ctrl-r)+change-prompt(rg> )+disable-search+reload($FZF_STR_CMD {q} || true)+rebind(change,ctrl-f)" \
            --header 'C-r(g)  C-f(zf)'
        )
        [ -n "${selected[0]}" ] && vim "${selected[0]}" "+${selected[1]}"
    }
fi


# FIREFOX HISTORY search
if compgen -G "$HOME/.mozilla/firefox/*.default*/places.sqlite" &> /dev/null; then
    fff() {
        local last_update selected
        last_update="$(date -r '/tmp/ffh' +%s 2> /dev/null)";
        if (( $(date +%s) - ${last_update:-0} > 1000)); then
            cp -f ~/.mozilla/firefox/*.default*/places.sqlite /tmp/ffh
        fi
        IFS=' ' read -ra selected < <(
        sqlite3 -readonly \
            -separator ' ' \
            /tmp/ffh \
            "SELECT DISTINCT
                    (CASE WHEN mb.fk IS NOT NULL THEN '[B]' ELSE '[H]' END) as typ,
                    '[' || mp.title || ']' as title,
                    printf(\"%c[38;5;109m%s%c[0m\", char(27), url, char(27)) as url
                    FROM moz_places mp
                    LEFT JOIN moz_bookmarks mb ON mb.fk= mp.id
                    WHERE mp.title is not null
                    ORDER BY mp.last_visit_date;" |
            fzf $FZF_DEFAULT_OPTS \
            --ansi \
            --multi \
            --height ${FZF_TMUX_HEIGHT:-40%} \
            --prompt 'firefox> ' \
            --tiebreak=index |
            sed 's#.*\(https*://\)#\1#'
        )
        [ -n "${selected}" ] && xdg-open "${selected}"
    }
fi

# GIT LOG search
__fdiff__() {
    local PREVIEW_PAGER="less --tabs=4 -Rc"
    local ENTER_PAGER=${PREVIEW_PAGER}
    if command -v delta &> /dev/null; then
        PREVIEW_PAGER="delta | ${PREVIEW_PAGER}"
        ENTER_PAGER="delta | sed -e '1,4d' | ${ENTER_PAGER}"
    fi
    local PREVIEW_COMMAND='git diff --color=always '$@' -- \
        $(echo $(git diff --name-status -R '$@' | grep {}) | cut -d" " -f 2-) \
        | '$PREVIEW_PAGER
    local ENTER_COMMAND='git diff --color=always '$@' -U10000 -- \
        $(echo $(git diff --name-status -R '$@' | grep {}) | cut -d" " -f 2-) \
        | '$ENTER_PAGER

    git diff --name-only $@ |
        fzf ${FZF_DEFAULT_OPTS} \
        --ansi \
        --reverse \
        --height=100% \
        --exit-0 \
        --preview "${PREVIEW_COMMAND}" \
        --preview-window=top:85% \
        --bind "enter:execute:${ENTER_COMMAND}"
}

fgit() {
    local PREVIEW_CMD='f() {
    set -- $(echo -- "$@" | grep -o "[a-f0-9]\{7\}")
    [ $# -eq 0 ] || (
    git show --no-patch --color=always $1
    echo
    git show --stat --format="" --color=always $1 |
        while read line; do
            tput dim
            echo " $line" | sed "s/\x1B\[m/\x1B\[2m/g"
            tput sgr0
        done |
            tac | sed "1 a \ " | tac
        )
    }; f {}'
    local ENTER_CMD='(grep -o "[a-f0-9]\{7\}" | head -1 |
        xargs -I % bash -ic "__fdiff__ %^1 %") <<- "FZF-EOF"
        {}
        FZF-EOF'

    git log --graph \
        --color=always \
        --format="%C(yellow)%h %C(auto)%as %s - %C(cyan)%an" |
        fzf ${FZF_DEFAULT_OPTS} \
        --ansi \
        --reverse \
        --height=100% \
        --no-sort \
        --tiebreak=index \
        --preview "${PREVIEW_CMD}" \
        --preview-window=top:50% \
        --bind "enter:execute:${ENTER_CMD}" \
        --bind 'ctrl-c:execute-silent(echo -n {2..2} | xclip -sel clip)+abort'
}


# Command completions
_fzf_comprun() {
    local command=$1
    shift

    case "$command" in
        cd)           fzf "$@" --preview 'exa -L 1 --group-directories-first --sort=modified --reverse --icons {}' ;;
        export|unset) fzf "$@" --preview "eval 'echo \$'{}" ;;
        *)            fzf "$@" ;;
    esac
}
