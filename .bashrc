# ███████╗██╗  ██╗
# ██╔════╝██║ ██╔╝
# ███████╗█████╔╝   Sergey Konkin
# ╚════██║██╔═██╗   https://github.com/SK607
# ███████║██║  ██╗
# ╚══════╝╚═╝  ╚═╝

### DO NOTHING IF NOT INTERACTIVE
[[ $- != *i* ]] && return


### EXPORT
# number of commands stored (cached) in memory
export HISTSIZE=
# number of commands stored in .bash_history (empty=unlimited)
export HISTFILESIZE=
# (ignorespace) lines starting with a white space + (ignoredups) duplicated + (erasedups)
export HISTCONTROL=ignoreboth
# exclude commands from history
export HISTIGNORE='[ \t]*:exit:pwd'

# for vim themes
export TERM="xterm-256color"

# default text editor
export EDITOR="vim"
export VISUAL="vim"

# ls date style
export TIME_STYLE=long-iso

# gnome-ssh-agent
[ -z "$SSH_AUTH_SOCK" ] && export SSH_AUTH_SOCK=/run/user/$(id -u)/keyring/ssh

# set bat as manpager
[ -x "$(command -v bat)" ] && export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# nnn, fzf, ls themes
[ -f /etc/bash.d/.theme.sh ] && source /etc/bash.d/.theme.sh
[ -f ~/.theme.sh ] && source ~/.theme.sh

# nnn configuration
[ -f /etc/bash.d/.nnn.sh ] && source /etc/bash.d/.nnn.sh
[ -f ~/.nnn.bash ] && source ~/.nnn.bash

# fzf configuration
[ -f /etc/bash.d/.fzf.sh ] && source /etc/bash.d/.fzf.sh
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# z.lua configuration
[ -d ~/.local/opt/z.lua ] && eval "$(lua ~/.local/opt/z.lua/z.lua --init bash enhanced once)"

# path
[ -d /usr/local/cuda-10.0/bin ] && export PATH=/usr/local/cuda-10.0/bin${PATH:+:${PATH}}
[ -d /usr/local/go/bin ] && export PATH=/usr/local/go/bin${PATH:+:${PATH}}
[ -d $HOME/.poetry/bin ] && export PATH=$HOME/.poetry/bin${PATH:+:${PATH}}
[ -d $HOME/.local/bin ] && export PATH=$HOME/.local/bin${PATH:+:${PATH}}


### SHOPT
shopt -s checkwinsize  # auto-adjust term size
shopt -s histappend  # append to the history file
shopt -s cmdhist  # save multi-line as single line
shopt -s cdspell  # auto-correct minor dirname errors


# COMPLETIONS
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi
source /usr/share/bash-completion/completions/git


# ALIASES
# https://askubuntu.com/questions/22037/aliases-not-available-when-using-sudo
alias sudo='sudo '

# defaults
alias rm='rm -i'
alias chmod='chmod --preserve-root'
alias grep='grep --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ls='LC_COLLATE=C ls --group-directories-first --color=auto'
alias df='df -h'
alias env='env | sort'
alias path='echo "${PATH//:/$'"'"'\n'"'"'}" | sort'

# commands
alias jctl='journalctl -p 3 -xb'
alias termbin='nc termbin.com 9999'
alias biggest="du -h --max-depth=1 | sort -hr"
alias microcode='grep . /sys/devices/system/cpu/vulnerabilities/*'

# extensions
[ -x "$(command -v exa)" ] && alias exad='exa --group-directories-first --icons -a'
[ -x "$(command -v exa)" ] && alias exagit='exa --group-directories-first --icons -al --git'
[ -x "$(command -v tree)" ] && alias treed='tree -C -I "__pycache__|.git" -tr --dirsfirst'
[ -x "$(command -v cpg)" ] && alias cp='advcp -gi'
[ -x "$(command -v mvg)" ] && alias mv='advmv -gi'
[ -x "$(command -v nnn)" ] && alias n='LC_COLLATE="C" nnn'
[ -x "$(command -v bat)" ] && alias batd='bat -p'
if [ -x "$(command -v pacman)" ]; then
    alias pacman='sudo pacman --color auto'
    alias pacupd='sudo pacman --color auto -Syyu'
    alias paclock='sudo rm /var/lib/pacman/db.lck'
    alias pacclean='sudo pacman -Rns $(pacman -Qtdq)'
    alias pacrecent="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"
    alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
    alias mirrord="sudo reflector --latest 30 --number 10 --sort delay --save /etc/pacman.d/mirrorlist"
    alias mirrors="sudo reflector --latest 30 --number 10 --sort score --save /etc/pacman.d/mirrorlist"
    alias mirrora="sudo reflector --latest 30 --number 10 --sort age --save /etc/pacman.d/mirrorlist"
    alias mirrorx="sudo reflector --age 6 --latest 20  --fastest 20 --threads 5 --sort rate --protocol https --save /etc/pacman.d/mirrorlist"
fi
if [ -x "$(command -v fish)" ]; then
    alias tobash="sudo chsh $USER -s /bin/bash && echo 'Now log out.'"
    alias tofish="sudo chsh $USER -s /usr/bin/fish && echo 'Now log out.'"
fi
if [ -x "$(command -v yt-dlp)" ]; then
    alias yta-mp3="yt-dlp --extract-audio --audio-format mp3 "
    alias yta-m4a="yt-dlp --extract-audio --audio-format m4a "
    alias ytv-best="yt-dlp -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio' --merge-output-format mp4 "
fi


# FUNCTIONS
# render help wtih bat
help() { "$@" --help 2>&1 | bat --plain --language=help; }

# copy current prompt to clipboard
if [ -x "$(command -v wl-copy)" ]; then
    copyline() { printf %s "$READLINE_LINE" | wl-copy; }
elif [ -x "$(command -v xsel)" ]; then
    copyline() { printf %s "$READLINE_LINE" | xsel -ib; }
fi
[ $(type -t copyline) == function ] && bind -x '"\C-xc":copyline'

# find dotfile dir and file in it
edot() {
    $EDITOR $(fd --type file --unrestricted --ignore-case --full-path --absolute-path "$@"  "$HOME/code-projects/devops/dotfiles/")
}

# Advanced command-not-found hook
# source /usr/share/doc/find-the-command/ftc.bash

# extract archive
ex ()
{
  if [ -f "$1" ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   unzstd $1    ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}


# PROMPT
NERD_ENABLED='1'
[ -f /etc/bash.d/.prompt.sh ] && source /etc/bash.d/.prompt.sh
[ -f ~/.prompt.bash ] && source ~/.prompt.bash
