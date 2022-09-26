if [ -x "$(command -v nnn)" ]; then
    export NNN_OPTS='cEHrx'
    export NNN_BMS="c:$HOME/code-projects;d:$HOME/Downloads;p:$HOME/Pictures"
    export NNN_ORDER="t:$HOME/Downloads;t:$HOME/Pictures"
    export NNN_PLUG='p:preview-tui;g:git-diff;i:swayimg'
    export NNN_COLORS='#bc6ede72;1234'
    export NNN_FCOLORS="bcbcded2bcbc6e6e6ed2d2bc"
    # export NNN_FCOLORS="$BLK$CHR$DIR$EXE$REG$HARDLINK$SYMLINK$MISSING$ORPHAN$FIFO$SOCK$OTHER"
    export NNN_ARCHIVE='\\.(7z|a|ace|alz|arc|arj|bz|bz2|cab|cpio|deb|gz|jar|lha|lz|lzh|lzma|lzo|rar|rpm|rz|t7z|tar|tbz|tbz2|tgz|tlz|txz|tZ|tzo|war|xpi|xz|Z|zip)$'
    export NNN_FIFO='/tmp/nnn.fifo'
    export SPLIT='v'
fi
