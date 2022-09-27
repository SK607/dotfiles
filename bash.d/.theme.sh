# https://github.com/junegunn/fzf/wiki/Color-schemes
export FZF_THEME="""
--color=fg:#ebdbb2,bg:#282c34,hl:#928373,fg+:#ebdbb2,bg+:#282c34,hl+:#fb4934 
--color=pointer:#fb4934,info:#8ec07c,spinner:#fb4934,header:#928374,prompt:#fb4934,marker:#fb4933
"""


# https://github.com/jarun/nnn/wiki/Usage#configuration
export NNN_COLORS='#bc6ede72;1234'
export NNN_FCOLORS="bcbcded2bcbc6e6e6ed2d2bc"
# export NNN_FCOLORS="$BLK$CHR$DIR$EXE$REG$HARDLINK$SYMLINK$MISSING$ORPHAN$FIFO$SOCK$OTHER"


# ls color support
if [ -x "$(command -v dircolors)" ]; then
    if [ -r /etc/bash.d/.dir_colors ]; then
        eval "$(dircolors -b /etc/bash.d/.dir_colors)"
    elif [ -r ~/.dir_colors ]; then
        eval "$(dircolors -b ~/.dir_colors)"
    else
        eval "$(dircolors -b)"
    fi
fi

