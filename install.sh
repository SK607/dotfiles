#!/usr/bin/env bash

CWD=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

link_dotfile() {
    local file=$1
    local dst=$2
    ! [ -d $dst] && mkdir -p $dst
    [[ $3 -ne 'f' ]] && dst=$dst/$file
    ! [ -L $dst ] && ln -s $CWD/$file $dst
    ls -l $dst
}


if ! [ -d /etc/bash.d ]; then
    link_dotfile .bashrc $HOME
    link_dotfile .dir_colors $HOME
    link_dotfile .prompt.sh $HOME
    link_dotfile .fzf.sh $HOME
fi

link_dotfile .gitconfig $HOME
link_dotfile .ignore $HOME
link_dotfile .inputrc $HOME
link_dotfile .fzf.bash $HOME

link_dotfile .config/kitty/kitty.conf $HOME
link_dotfile .config/kitty/ssh.conf $HOME
link_dotfile .config/alacritty $HOME
link_dotfile .config/neofetch $HOME
link_dotfile .config/nnn/plugins $HOME
link_dotfile .config/bat $HOME
link_dotfile .config/sublime-text-3/Packages/User $HOME

/usr/bin/bat cache --build
