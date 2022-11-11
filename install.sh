#!/usr/bin/env bash

link_config() {
    if ! test -d "$(dirname "$2")"; then
        mkdir -p "$(dirname "$2")"
    fi
    ln -sfvn "$1" "$2"
}

copy_dotfiles() {
    local wd="$1"
    local settings_line settings cmd path
    while read -r settings_line; do
        read -ra settings -d '' <<<"$settings_line"
        cmd="${settings[0]}"
        path="${settings[1]}"
        if test -x "$(command -v "$cmd")"; then
            link_config "$wd/$path" "$HOME/$path"
        fi
    done < "$wd/install.cfg"
}

update_cache() {
    if test -x "$(command -v bat)"; then
        bat cache --build
    fi
}


CWD="$( dirname -- "$( readlink -f -- "$0"; )"; )"
copy_dotfiles "$CWD"
update_cache
