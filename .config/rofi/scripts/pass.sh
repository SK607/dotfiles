#!/usr/bin/env bash

list_accounts() {
    accounts=$(\
        fd --type file --unrestricted --color 'never' \
        . "$HOME/.password-store/" \
    )
    for account in $accounts; do
       name=$(echo "$account" | \
           sed -rn "s/^.+password-store\/(.+)\.gpg$/\1/p")
       echo -en "$name\0icon\x1fdialog-password\n"
    done
}


if test -z "$1"; then
    list_accounts
else
    pass -c "$1" > /dev/null 2>&1 &
fi

