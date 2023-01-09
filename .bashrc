# ███████╗██╗  ██╗
# ██╔════╝██║ ██╔╝
# ███████╗█████╔╝   Sergey Konkin
# ╚════██║██╔═██╗   https://github.com/SK607
# ███████║██║  ██╗
# ╚══════╝╚═╝  ╚═╝

### DO NOTHING IF NOT INTERACTIVE
[[ $- != *i* ]] && return


### CONFIGURE CLI
shopt -s checkwinsize  # auto-adjust term size
shopt -s histappend  # append to the history file
shopt -s cmdhist  # save multi-line as single line
shopt -s cdspell  # auto-correct minor dirname errors
# nnn, fzf, ls themes
[[ -f "$HOME/.bash.d/themes/everforest.sh" ]] && source "$HOME/.bash.d/themes/everforest.sh"
# nnn configuration
[[ -f "$HOME/.bash.d/nnn.sh" ]] && source "$HOME/.bash.d/nnn.sh"
# fzf configuration
[[ -f "$HOME/.bash.d/fzf.sh" ]] && source "$HOME/.bash.d/fzf.sh"
# z.lua configuration
[[ -d "$HOME/.local/opt/z.lua" ]] && eval "$(lua "$HOME/.local/opt/z.lua/z.lua" --init bash enhanced once)"
# prompt
if [[ -x "$(command -v starship)" ]]; then
    eval "$(starship init bash)"
else
    [[ -f "$HOME/.bash.d/prompt.sh" ]] && source "$HOME/.bash.d/prompt.sh"
fi


### ADD COMPLETIONS
if ! shopt -oq posix; then
    if  [[ -z "$BASH_COMPLETION_VERSINFO" ]]; then
        if [ -r /usr/share/bash-completion/bash_completion ]; then
            . /usr/share/bash-completion/bash_completion
        elif [ -r /etc/bash_completion ]; then
            . /etc/bash_completion
        fi
    fi
fi


### ADD FUNCTIONS
# render help wtih bat
help() { "$@" --help 2>&1 | bat --plain --language=help; }

# copy current prompt to clipboard
if [[ -x "$(command -v wl-copy)" ]]; then
    copyline() { printf %s "$READLINE_LINE" | wl-copy; }
elif [[ -x "$(command -v xsel)" ]]; then
    copyline() { printf %s "$READLINE_LINE" | xsel -ib; }
fi
[[ $(type -t copyline) == function ]] && bind -x '"\C-xc":copyline'

# find dotfile dir and file in it
edot() {
    $EDITOR "$(\
      fd \
        --type file \
        --unrestricted \
        --ignore-case \
        --full-path \
        --absolute-path \
        "$@" "$DOTFILES_PATH" \
      | fzf \
        --select-1 \
        --exit-0 \
        --filter "$@" \
      | head -n 1 \
      )"
}

# extract archive
ex ()
{
  if [ -f "$1" ] ; then
    case $1 in
      *.tar.bz2)   tar xjf "$1"   ;;
      *.tar.gz)    tar xzf "$1"   ;;
      *.bz2)       bunzip2 "$1"   ;;
      *.rar)       unrar x "$1"   ;;
      *.gz)        gunzip "$1"    ;;
      *.tar)       tar xf "$1"    ;;
      *.tbz2)      tar xjf "$1"   ;;
      *.tgz)       tar xzf "$1"   ;;
      *.zip)       unzip "$1"     ;;
      *.Z)         uncompress "$1";;
      *.7z)        7z x "$1"      ;;
      *.deb)       ar x "$1"      ;;
      *.tar.xz)    tar xf "$1"    ;;
      *.tar.zst)   unzstd "$1"    ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# foot shell integration
# https://codeberg.org/dnkl/foot/wiki#user-content-bash
if [[ $TERM =~ ^foot ]]; then
  osc7_cwd() {
      local strlen=${#PWD}
      local encoded=""
      local pos c o
      for (( pos=0; pos<strlen; pos++ )); do
          c=${PWD:$pos:1}
          case "$c" in
              [-/:_.!\'\(\)~[:alnum:]] ) o="${c}" ;;
              * ) printf -v o '%%%02X' "'${c}" ;;
          esac
          encoded+="${o}"
      done
      printf '\e]7;file://%s%s\e\\' "${HOSTNAME}" "${encoded}"
  }
  PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }osc7_cwd
fi

# nnn
if [[ -x "$(command -v nnn)" ]]; then
    # https://github.com/jarun/nnn/tree/master/misc/quitcd
    n () {
        if [[ "${NNNLVL:-0}" -ge 1 ]]; then
            echo "nnn is already running"
            return
        fi

        export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
        LC_COLLATE='C' \nnn "$@"

        if [ -f "$NNN_TMPFILE" ]; then
            . "$NNN_TMPFILE"
            rm -f "$NNN_TMPFILE" > /dev/null
        fi
    }
fi


### ADD ALIASES
# https://askubuntu.com/questions/22037/aliases-not-available-when-using-sudo
alias sudo='sudo '

# harmless defaults
alias chmod='chmod --preserve-root'
alias grep='grep --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ls='ls --color=auto'
alias rm='rm -iv'
alias cp='cp -iv'
alias mv='mv -iv'
alias ga='git add .'
alias gs='git status -s'
alias gd='git diff HEAD'
alias gc='git commit'
alias vw='vim ~/Code/devops/vimwiki/index.md'

# non-harmless defaults
alias lsd='LC_COLLATE=C ls --group-directories-first --color=auto --almost-all'
[[ -x "$(command -v exa)" ]] && alias la='exa --group-directories-first --icons --all'
[[ -x "$(command -v exa)" ]] && alias ll='exa --group-directories-first --icons --all --long --git'
[[ -x "$(command -v tree)" ]] && alias treed='tree -C -I "__pycache__|.git" -tr --dirsfirst'
[[ -x "$(command -v bat)" ]] && alias b='bat -p'

# additional commands
alias jctl='journalctl -p 3 -xb'
alias termbin='nc termbin.com 9999'
alias microcode='grep . /sys/devices/system/cpu/vulnerabilities/*'

# grc-colorized commands
envd='env | sort'
path='echo $PATH | sed -z '"'"'$ s/:/\n/g'"'"' | sort'
biggest="du -h --max-depth=1 | sort -hr"

if [[ -x $(command -v grcat) ]]; then
    alias envd="$envd | grcat /usr/share/grc/conf.env"
    alias path="$path | grcat /usr/share/grc/conf.lsattr"
    alias biggest="$biggest | grcat /usr/share/grc/conf.du"
    alias sensorsd='grc sensors'
    alias pingd='grc ping'
    alias statd='grc stat'
    alias gccd='grc gcc'
else
    alias envd="$envd"
    alias path="$path"
    alias biggest="$biggest"
fi

unset envd path biggest

# pacman
if [ -x "$(command -v pacman)" ]; then
    alias pacman='sudo pacman --color=always'
    alias pac-search='sudo pacman -Ss'
    alias pac-update='sudo pacman -Syyu'
    alias pac-rm='sudo pacman -Rns'
    alias pac-list='sudo pacman Q'
    alias pac-list-user='sudo pacman -Qe'
    alias pac-list-recent="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"
    alias pac-clean-cache='sudo pacman -Sc'
    alias pac-clean-orphan='sudo pacman -Rns $(pacman -Qtdq)' 
    alias pac-clean-lock='sudo rm /var/lib/pacman/db.lck'
    alias pac-mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
    alias pac-mirror-d="sudo reflector --latest 30 --number 10 --sort delay --save /etc/pacman.d/mirrorlist"
    alias pac-mirror-s="sudo reflector --latest 30 --number 10 --sort score --save /etc/pacman.d/mirrorlist"
    alias pac-mirror-a="sudo reflector --latest 30 --number 10 --sort age --save /etc/pacman.d/mirrorlist"
    alias pac-mirror-x="sudo reflector --age 6 --latest 20  --fastest 20 --threads 5 --sort rate --protocol https --save /etc/pacman.d/mirrorlist"
fi

