### GREETING
function echo_battery
  set -l capacity $(acpi -b | grep -oP '\d{2,}(?=%)')
  set -l icon ''
  if acpi -a | grep -q 'on-line'
    set icon ''
  else if test "$capacity" -gt 90
    set icon ''
  else if test "$capacity" -gt 75
    set icon ''
  else if test "$capacity" -gt 50
    set icon ''
  else if test "$capacity" -gt 25
    set icon ''
  end
  echo "$icon $capacity%%"
end

function fish_greeting
  if test $(tput cols) -gt 100 \
      && test $(tput lines) -gt 30 \
      && not test "$POETRY_ACTIVE" = '1'
    set -l LC_TIME 'en_US.UTF-8'
    set -l blue '\e[0;34m'
    set -l reset '\e[m'
    printf "$blue"
    printf '\n ███████╗ ██╗  ██╗'
    printf '\n ██╔════╝ ██║ ██╔╝'
    printf "  $(date +'%A %d-%m-%Y %H:%M:%S')"
    printf '\n ███████╗ █████╔╝ '
    printf "  Battery: $(echo_battery)"
    printf '\n ╚════██║ ██╔═██╗ ' 
    printf "  ACPI: $(acpi -t | grep -oP '\d+\.\d')°C"
    printf '\n ███████║ ██║  ██╗'
    printf '\n ╚══════╝ ╚═╝  ╚═╝'
    printf "$reset\n"
  end
end


### CONFIGURE ENV VARIABLES
# theme for CLI apps
if test -f "$HOME/.config/fish/themes/everforest.fish"
    source "$HOME/.config/fish/themes/everforest.fish"
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
  $EDITOR "$(\
    fd \
      --type file \
      --unrestricted \
      --ignore-case \
      --full-path \
      --absolute-path \
      "$argv" "$DOTFILES_PATH" \
    | fzf \
      --select-1 \
      --exit-0 \
      --filter "$argv" \
    | head -n 1 \
    )"
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

if test -x "$(command -v nnn)"
  # https://github.com/jarun/nnn/blob/master/misc/quitcd/quitcd.fish
  function n --wraps nnn --description 'support nnn quit and change directory'
    if test -n "$NNNLVL" -a "$NNNLVL" -ge 1
        echo "nnn is already running"
        return
    end

    if test -n "$XDG_CONFIG_HOME"
        set -x NNN_TMPFILE "$XDG_CONFIG_HOME/nnn/.lastd"
    else
        set -x NNN_TMPFILE "$HOME/.config/nnn/.lastd"
    end

    # set -x LC_COLLATE 'C'
    command nnn $argv

    if test -e $NNN_TMPFILE
        source $NNN_TMPFILE
        /usr/bin/rm $NNN_TMPFILE
    end
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
alias vw='vim ~/Code/devops/vimwiki/index.md'

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
end

