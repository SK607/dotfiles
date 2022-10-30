#!/usr/bin/env bash

CWD="$( dirname -- "$( readlink -f -- "$0"; )"; )"

read -r -d '' DOTS << EOM
bash        .bash.d
bash        .profile
bash        .bash_profile
bash        .bashrc
bash        .inputrc
fd          .ignore
alacritty   .config/alacritty
kitty       .config/kitty
fish        .config/fish
starship    .config/starship.toml
vim         .vim
git         .config/git
nnn         .config/nnn/plugins
bat         .config/bat
fastfetch   .config/fastfetch
neofetch    .config/neofetch
sway        .config/sway
waybar      .config/waybar
swaylock    .config/swaylock
mypy        .config/mypy
pylint      .config/pylint
black       .config/black
htop        .config/htop
zathura     .config/zathura
EOM


link_dot() {
    ! test -d "$(dirname $2)" && mkdir -p "$(dirname $2)"
    ln -sfvn "$1" "$2"
}


while read line; do
    arr=($line)
    cmd="${arr[0]}"
    config="${arr[1]}"
    if test -x "$(command -v $cmd)"; then
        link_dot "$CWD/$config" "$HOME/$config"
    fi
done <<< "$DOTS"


if test -x "$(command -v bat)"; then
    bat cache --build
fi


if test -x "$(command -v gnome-shell)"; then
    THEMES=( 'Everforest-Dark-BL Nordic-v40' )
    for theme in $THEMES;
    do
        NAME=$(echo "$theme" | 
               tr '[:upper:]' '[:lower:]' |
               grep -oE '^[^-]+' )
        CONFIG="$HOME/.themes/$theme/gnome-shell/gnome-shell.css"
        if ! grep -q '@import' "$CONFIG"; then
            EXTRA="$CWD/themes/$NAME/gnome-shell.css"
            echo -e "@import url(\"$EXTRA\");\n$(cat $CONFIG)" > $CONFIG
        fi
        ln -svf "$CWD/.themes/$NAME/workspaces-bar.css" \
                "$HOME/.local/share/gnome-shell/extensions/workspaces-bar@fthx/stylesheet.css"
    done
fi

