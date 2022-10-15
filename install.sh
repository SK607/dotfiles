#!/usr/bin/env bash

CWD="$( dirname -- "$( readlink -f -- "$0"; )"; )"

link_dot() {
    local src=$1
    local tgt=$2
    if ! [[ -d "$(dirname "$tgt")" ]]; then
        mkdir -p "$(dirname "$tgt")"
    elif [[ -d "$tgt" && ! -L "$tgt" ]]; then
        [[ "$3" = '--backup' ]] && cp -rv "$tgt" "${tgt}~"
        rm -rvi "$tgt"
    fi
    ln -sfvn "$3" "$CWD/$src" "$tgt"
}


## SHELL
link_dot .profile "$HOME/.profile" --backup
link_dot .bash_profile "$HOME/.bash_profile" --backup
link_dot .bashrc "$HOME/.bashrc" --backup
link_dot .bash.d "$HOME/.bash.d"
link_dot .ignore "$HOME/.ignore"
link_dot .inputrc "$HOME/.inputrc"
if test -x "$(command -v alacritty)"; then
    link_dot .config/alacritty "$HOME/.config/alacritty"
fi
if test -x "$(command -v fish)"; then
    link_dot .config/fish "$HOME/.config/fish"
fi
if test -x "$(command -v starship)"; then
    link_dot .config/starship.toml "$HOME/.config/starship.toml"
fi
if test -x "$(command -v vim)"; then
    link_dot .vim "$HOME/.vim"
fi
if test -x "$(command -v git)"; then
    link_dot .config/git "$HOME/.config/git"
fi
if test -x "$(command -v nnn)"; then
    link_dot .config/nnn/plugins "$HOME/.config/nnn/plugins"
fi
if test -x "$(command -v bat)"; then
    link_dot .config/bat "$HOME/.config/bat"
    bat cache --build
fi

## DESKTOP
if test -x "$(command -v azote)"; then
    link_dot .azotebg "$HOME/.azotebg"
    link_dot .config/azote "$HOME/.config/azote"
fi
if test -x "$(command -v fastfetch)"; then
    link_dot .config/fastfetch "$HOME/.config/fastfetch"
fi
if test -x "$(command -v neofetch)"; then
    link_dot .config/neofetch "$HOME/.config/neofetch"
fi
if test -x "$(command -v sway)"; then
    link_dot .config/sway "$HOME/.config/sway"
fi
if test -x "$(command -v waybar)"; then
    link_dot .config/waybar "$HOME/.config/waybar"
fi
if test -x "$(command -v swaylock)"; then
    link_dot .config/swaylock "$HOME/.config/swaylock"
fi

## APPS
if test -x "$(command -v mypy)"; then
    link_dot .config/mypy "$HOME/.config/mypy"
fi
if test -x "$(command -v pylint)"; then
    link_dot .pylintrc "$HOME/.pylintrc" 
fi
if test -x "$(command -v htop)"; then
    link_dot .config/htop "$HOME/.config/htop" 
fi


