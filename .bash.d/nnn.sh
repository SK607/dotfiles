if [[ -x "$(command -v nnn)" ]]; then
    export NNN_OPTS='cErux'
    export NNN_BMS="c:$HOME/code-projects;d:$HOME/Downloads;p:$HOME/Pictures;v:$HOME/Videos"
    export NNN_ORDER="t:$HOME/Downloads;t:$HOME/Pictures"
    export NNN_PLUG='i:swayimg;f:fzf-search;g:git-diff;p:preview-tui;r:git-root;z:zlua'
    export NNN_ARCHIVE='\\.(7z|a|ace|alz|arc|arj|bz|bz2|cab|cpio|deb|gz|jar|lha|lz|lzh|lzma|lzo|rar|rpm|rz|t7z|tar|tbz|tbz2|tgz|tlz|txz|tZ|tzo|war|xpi|xz|Z|zip)$'
    export NNN_FIFO='/tmp/nnn.fifo'
    export SPLIT='v'

    # https://github.com/jarun/nnn/tree/master/misc/quitcd
    n () {
        if [[ "${NNNLVL:-0}" -ge 1 ]]; then
            echo "nnn is already running"
            return
        fi

        export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
        LC_COLLATE='C' \nnn "$@"

        if [ -f "$NNN_TMPFILE" ]; then
            . "$NNN_TMPFILE"
            rm -f "$NNN_TMPFILE" > /dev/null
        fi
    }

fi

