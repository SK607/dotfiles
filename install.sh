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

