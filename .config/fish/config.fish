## GREETING
function fish_greeting
  if test $(tput cols) -gt 100 && test $(tput lines) -gt 30
    set -l LC_TIME 'en_US.UTF-8'
    set -l blue '\e[0;34m'
    set -l reset '\e[m'
    printf "$blue"
    printf '\n ███████╗██╗  ██╗'
    printf '\n ██╔════╝██║ ██╔╝'
    printf '  Sergey Konkin'
    printf '\n ███████╗█████╔╝ '
    printf '  https://github.com/SK607'
    printf '\n ╚════██║██╔═██╗ ' 
    printf "  $(date +'%A %d-%m-%Y %H:%M:%S')"
    printf '\n ███████║██║  ██╗'
    printf '\n ╚══════╝╚═╝  ╚═╝'
    printf "$reset\n"
  end
end


## CONFIGURE ENV VARIABLES
# extend PATH
for bin_path in ~/.local/bin ~/node_modules/.bin ~/.poetry/bin
    if test -d $bin_path
        if not contains -- $bin_path $PATH
            set -p PATH $bin_path
        end
    end
end
# export variable need for qt-theme
if type "qtile" >> /dev/null 2>&1
   set -x QT_QPA_PLATFORMTHEME "qt5ct"
end
# ls date style
set -x TIME_STYLE 'long-iso'
# remove python shell prompt
set -x VIRTUAL_ENV_DISABLE_PROMPT '1'
# set bat as manpager
if test -x "$(command -v bat)"
  set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
end
# configure fzf
if test -x "$(command -v fzf)"
  set -x FZF_DEFAULT_OPTS "$FZF_THEME --bind up:preview-up,down:preview-down --reverse"
end
if test -f ~/.config/fish/fish_plugins
  if grep 'fzf' ~/.config/fish/fish_plugins 1> /dev/null
    set fzf_preview_dir_cmd exa --group-directories-first --icons --all --oneline --color=always
    set fzf_preview_file_cmd bat -p --color=always
    set fzf_fd_opts --hidden
  end
end
# user-defined variables
set -x DOTFILES_PATH "$HOME/code-projects/devops/dotfiles"


### CONFIGURE CLI
# prompt
if status --is-interactive
   source (starship init fish --print-full-init | psub)
end


### ADD FUNCTIONS
function helpd
  "$argv" --help 2>&1 | bat --plain --language=help
end

function edot
  $EDITOR $(fd --type file --unrestricted --ignore-case --full-path --absolute-path -1 "$argv" "$DOTFILES_PATH")
end

function ex --argument archive
  if test -f "$archive"
    switch $archive
      case '*.tar.bz2'
        tar xjf $archive
      case '*.tar.gz'
        tar xzf $archive
      case '*.bz2'
        bunzip2 $archive
      case '*.rar'
        unrar x $archive
      case '*.gz'
        gunzip $archive
      case '*.tar'
        tar xf $archive
      case '*.tbz2'
        tar xjf $archive
      case '*.tgz'
        tar xzf $archive
      case '*.zip'
        unzip $archive
      case '*.Z'
        uncompress $archive
      case '*.7z'
        7z x $archive
      case '*.deb'
        ar x $archive
      case '*.tar.xz'
        tar xf $archive
      case '*.tar.zst'
        unzstd $archive
      case '*'
        echo "'$archive' cannot be extracted via ex()"
    end
  else
    echo "'$archive' is not a valid file"
  end
end


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
alias vw='vim -c "VimwikiIndex"'

# non-harmless defaults
alias lsd='LC_COLLATE=C ls --group-directories-first --color=auto --almost-all'
if test -x "$(command -v exa)"
  alias la='exa --group-directories-first --icons --all'
  alias ll='exa --group-directories-first --icons --all --long --git'
end
if test -x "$(command -v tree)"
  alias treed='tree -C -I "__pycache__|.git" -tr --dirsfirst'
end
if test -x "$(command -v bat)"
  alias b='bat -p'
end

# additional commands
alias jctl='journalctl -p 3 -xb'
alias termbin='nc termbin.com 9999'
alias microcode='grep . /sys/devices/system/cpu/vulnerabilities/*'

# grc-colorized commands
set envd 'env | sort'
set path 'echo $PATH | sed -z '"'"'$ s/\s/\n/g'"'"' | sort'
set biggest 'du -h --max-depth=1 | sort -hr'

if test -x "$(command -v grcat)"
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
end

set -e envd path biggest

# pacman
if test -x "$(command -v pacman)"
    alias pacman='sudo pacman --color=always'
    alias pacupd='sudo pacman --color=always -Syyu'
    alias paclock='sudo rm /var/lib/pacman/db.lck'
    alias pacclean='sudo pacman --color=always -Rns $(pacman -Qtdq)'
    alias pacrecent="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"
    alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
    alias mirrord="sudo reflector --latest 30 --number 10 --sort delay --save /etc/pacman.d/mirrorlist"
    alias mirrors="sudo reflector --latest 30 --number 10 --sort score --save /etc/pacman.d/mirrorlist"
    alias mirrora="sudo reflector --latest 30 --number 10 --sort age --save /etc/pacman.d/mirrorlist"
    alias mirrorx="sudo reflector --age 6 --latest 20  --fastest 20 --threads 5 --sort rate --protocol https --save /etc/pacman.d/mirrorlist"
end

