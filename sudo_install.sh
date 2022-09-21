#!/usr/bin/env bash

CWD=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

link_dotfile() {
    local file=$1
    local dst=$2
    ! [ -d $dst] && mkdir -p $dst
    [ "$3" != 'f' ] && dst=$dst/$file
    ln -sf $CWD/$file $dst
    ls -l $dst
}

link_dotfile .bashrc /etc/bash.bashrc -f
link_dotfile bash.d/.dir_colors /etc
link_dotfile bash.d/.prompt.sh /etc
link_dotfile bash.d/.fzf.sh /etc

