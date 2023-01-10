### Applications
export EDITOR=vim
export SUDO_EDITOR=vim
export VISUAL=vim
export BROWSER=firefox
export TERM=foot
export TERMINAL=foot
export MAIL=thunderbird

### Configs
export RUSTUP_HOME="$HOME/.cache/rustup"
export CARGO_HOME="$HOME/.cache/cargo"
export PYTHONSTARTUP="$HOME/.config/python/pythonstartup"
export _ZL_DATA="$HOME/.cache/.zlua"

### Wayland
if test -x "$(command -v river)"; then
    export MOZ_ENABLE_WAYLAND=1
    export MOZ_DBUS_REMOTE=1
    export QT_QPA_PLATFORM="wayland;xcb"    # enables wayland support if available (xcb is an x11 fallback e.g. for zoom)
    export QT_QPA_PLATFORMTHEME="gtk3"
    export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
    # export QT_QPA_PLATFORMTHEME="qt5ct"     # install qt5ct for a more extensive wayland support
    # export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/dbus/system_bus_socket   # brave bugfix
    # export SSH_AUTH_SOCK=/run/user/$(id -u)/keyring/ssh
fi

### CLI
# PATH
[[ -d $HOME/.local/bin ]] && export PATH=$HOME/.local/bin${PATH:+:${PATH}}
[[ -d $HOME/node_modules/.bin ]] && export PATH=$HOME/node_modules/.bin${PATH:+:${PATH}}
[[ -d /usr/local/cuda-10.0/bin ]] && export PATH=/usr/local/cuda-10.0/bin${PATH:+:${PATH}}
# number of commands stored (cached) in memory
export HISTSIZE=
# number of commands stored in .bash_history (empty=unlimited)
export HISTFILESIZE=
# (ignorespace) lines starting with a white space + (ignoredups) duplicated + (erasedups)
export HISTCONTROL=ignoreboth
# exclude commands from history
export HISTIGNORE='[ \t]*:exit:pwd'
# ls date style
export TIME_STYLE=long-iso
# remove python shell prompt
export VIRTUAL_ENV_DISABLE_PROMPT='1'
# set bat as manpager
[[ -x "$(command -v bat)" ]] && export MANPAGER="sh -c 'col -bx | bat -l man -p'"
# user-defined variables
export DOTFILES_PATH="$HOME/Code/devops/dotfiles"
# nnn
if [[ -x "$(command -v nnn)" ]]; then
    export NNN_OPTS='cErux'
    export NNN_BMS="c:$HOME/Code;d:$HOME/Downloads;p:$HOME/Pictures;v:$HOME/Videos"
    export NNN_ORDER="t:$HOME/Downloads;t:$HOME/Pictures"
    export NNN_PLUG='d:git-diff;i:swayimg;f:fzf-fd;g:fzf-rg;p:preview-tui;r:git-root;z:zlua'
    export NNN_ARCHIVE='\\.(7z|a|ace|alz|arc|arj|bz|bz2|cab|cpio|deb|gz|jar|lha|lz|lzh|lzma|lzo|rar|rpm|rz|t7z|tar|tbz|tbz2|tgz|tlz|txz|tZ|tzo|war|xpi|xz|Z|zip)$'
    export NNN_FIFO='/tmp/nnn.fifo'
    export SPLIT='v'
fi

# [[ -f ~/.bashrc ]] && . ~/.bashrc
