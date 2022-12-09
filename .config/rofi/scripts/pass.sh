#!/usr/bin/env bash

list_accounts() {
    fd --type file --no-ignore --color 'never' \
        . "$HOME/.password-store/"
}

clean_name() {
    sed -r "s/^[a-z\/]+\.password-store\/(.+)\.gpg$/\1\\\0icon\\\x1fdialog-password/"
}

list_menu() {
    echo -en "$(list_accounts | clean_name)"
}


if test -z "$1"; then
    list_menu
else
    pass -c "$1" > /dev/null 2>&1 &
    # pass -c2 "$1"
fi
