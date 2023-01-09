#!/usr/bin/env bash

make_link() {
    if ! test -d "$(dirname "$2")"; then
        mkdir -p "$(dirname "$2")"
    fi
    ln -sfvn "$1" "$2"
}

link_dotfile() {
    local settings="$1"
    local wd="$2"
    local settings_arr
    read -ra settings_arr -d '' <<<"$settings"
    local cmd="${settings_arr[0]}"
    local path="${settings_arr[1]}"
    if test -x "$(command -v "$cmd")"; then
        make_link "$wd/$path" "$HOME/$path"
    fi
}

install_dotfiles() {
    local wd="$1"
    while read -r config_line; do
        if ! [[ $config_line = '' || $config_line = \#* ]]; then
            link_dotfile "$config_line" "$wd"
        fi
    done < "$wd/install.cfg"
}

update_cache() {
    if test -x "$(command -v bat)"; then
        bat cache --build
    fi
}

CWD="$( dirname -- "$( readlink -f -- "$0"; )"; )"
install_dotfiles "$CWD"
update_cache

# fix bug with fastfetch & nnn plugins
