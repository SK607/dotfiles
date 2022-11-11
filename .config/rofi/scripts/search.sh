#!/usr/bin/env sh

url() {
    query=$(echo "$*" | sed 's/[a-z]+://' | sed 's/\s+/+/g')
    case "$*" in
        g:*) url='https://github.com/search?q=' ;;
        y:*) url='https://www.youtube.com/results?search_query=' ;;
        ya:*) url='https://yandex.ru/yandsearch?text=' ;;
        go:*) url='https://www.google.com/search?q=' ;;
        dd:*) url='https://www.duckduckgo.com/?q=' ;;
        *) url='https://search.brave.com/search?source=desktop&q=' ;;
    esac
    echo "$url$query";
}

if test -n "$*"; then
    xdg-open "$(url "$*")" > /dev/null 2>&1 & 
fi
