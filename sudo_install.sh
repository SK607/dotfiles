#!/usr/bin/env bash

CWD="$( dirname -- "$( readlink -f -- "$0"; )"; )"

link_dotfile() {
    local src dst_dir dst_file dst
    src=$1
    dst_dir=$2
    dst_file=$3
    if [ -n "$dst_file" ]; then
        dst="$dst_dir/$dst_filename"
    else
        dst="$dst_dir/$(basename "$src")"
    fi
    ! [ -d $dst_dir ] && mkdir -p $dst_dir
    ln -sf $CWD/$file $dst
    ls -l $dst
}

link_dotfile .bashrc /etc bash.bashrc
link_dotfile bash.d/.dir_colors /etc/bash.d
link_dotfile bash.d/.prompt.sh /etc/bash.d
link_dotfile bash.d/.fzf.sh /etc/bash.d

