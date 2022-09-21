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
export HISTCONTROL=ignoreboth:erasedups
# exclude commands from history
export HISTIGNORE='[ \t]*:exit:pwd:git commit*'

# color support
export TERM="xterm-256color"
if [ -x "$(command -v dircolors)" ]; then
    if [ -r /etc/bash.d/.dir_colors ]; then
        eval "$(dircolors -b /etc/bash.d/.dir_colors)"
    else
        eval "$(dircolors -b)"
    fi
fi

# default text editor
export EDITOR="vim"
export VISUAL="vim"

# ls date style
export TIME_STYLE=long-iso

# set bat as manpager
[ -x "$(command -v bat)" ] && export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# nnn configuration
if [ -x "$(command -v nnn)" ]; then
    export NNN_OPTS='e'
    export NNN_PLUG='p:preview-tui;d:dragdrop;i:imgview;f:fzcd'
    export NNN_FCOLORS='bcbcdfd2bc74747474d2d2bc'
    export NNN_COLORS='#dfdfdfdf;1234'
    export NNN_ARCHIVE='\\.(7z|a|ace|alz|arc|arj|bz|bz2|cab|cpio|deb|gz|jar|lha|lz|lzh|lzma|lzo|rar|rpm|rz|t7z|tar|tbz|tbz2|tgz|tlz|txz|tZ|tzo|war|xpi|xz|Z|zip)$'
    export NNN_FIFO='/tmp/nnn.fifo'
    export SPLIT='v'
fi

# fzf configuration
[ -f /etc/bash.d/.fzf.sh ] && source /etc/bash.d/.fzf.sh
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

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
[ -x "$(command -v exa)" ] && alias exa='exa --group-directories-first --icons -a'
[ -x "$(command -v exa)" ] && alias exagit='exa --group-directories-first --icons -a --git'
[ -x "$(command -v tree)" ] && alias tree='tree -C -I "__pycache__|.git" -tr --dirsfirst'
[ -x "$(command -v cpg)" ] && alias cp='cpg -gi'
[ -x "$(command -v mvg)" ] && alias mv='mvg -gi'
[ -x "$(command -v bat)" ] && alias bat='bat -p'
if [ -x "$(command -v pacman)" ]; then
    alias pacman='sudo pacman --color auto'
    alias pacupdate='sudo pacman --color auto -Syyu'
    alias pacunlock='sudo rm /var/lib/pacman/db.lck'
    alias pacclean='sudo pacman -Rns $(pacman -Qtdq)'
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
if [ -x "$(command -v xclip)" ]; then
    copyline() { printf %s "$READLINE_LINE" | xclip -sel clip; }
    bind -x '"\C-xc":copyline'
fi

# find dotfile dir and file in it
# edot() {}

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
