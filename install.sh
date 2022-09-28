#!/usr/bin/env bash

CWD="$( dirname -- "$( readlink -f -- "$0"; )"; )"

link_dot() {
    local src=$1
    local tgt=$2
    if ! [[ -d "$(dirname $tgt)" ]]; then
        mkdir -p "$(dirname $tgt)"
    elif [[ -d "$tgt" && ! -L "$tgt" ]]; then
        [[ "$3" = '--backup' ]] && cp -rv "$tgt" "${tgt}~"
        rm -rv "$tgt"
    fi
    ln -sfvn $3 "$CWD/$src" "$tgt"
}


#link_dot .profile $HOME/.profile --backup
#link_dot .bash_profile $HOME/.bash_profile --backup
#link_dot .bashrc $HOME/.bashrc --backup
#link_dot .bash.d $HOME/.bash.d

#link_dot .gitconfig $HOME/.gitconfig
#link_dot .ignore $HOME/.ignore
#link_dot .inputrc $HOME/.inputrc
#link_dot .azotebg $HOME/.azotebg

link_dot .vim $HOME/.vim

#link_dot .config/alacritty $HOME
#link_dot .config/bat $HOME
#bat cache --build
