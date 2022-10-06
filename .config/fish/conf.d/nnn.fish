if test -x "$(command -v nnn)"
  set -x NNN_OPTS 'cErux'
  set -x NNN_BMS "c:$HOME/code-projects;d:$HOME/Downloads;p:$HOME/Pictures;v:$HOME/Videos"
  set -x NNN_ORDER "t:$HOME/Downloads;t:$HOME/Pictures"
  set -x NNN_PLUG 'p:preview-tui;g:git-diff;i:swayimg;z:zlua;r:git-root'
  set -x NNN_ARCHIVE '\\.(7z|a|ace|alz|arc|arj|bz|bz2|cab|cpio|deb|gz|jar|lha|lz|lzh|lzma|lzo|rar|rpm|rz|t7z|tar|tbz|tbz2|tgz|tlz|txz|tZ|tzo|war|xpi|xz|Z|zip)$'
  set -x NNN_FIFO '/tmp/nnn.fifo'
  set -x SPLIT 'v'
  set -x LC_COLLATE 'C'

  # https://github.com/jarun/nnn/blob/master/misc/quitcd/quitcd.fish
  function n --wraps nnn --description 'support nnn quit and change directory'
    if test -n "$NNNLVL" -a "$NNNLVL" -ge 1
        echo "nnn is already running"
        return
    end

    if test -n "$XDG_CONFIG_HOME"
        set -x NNN_TMPFILE "$XDG_CONFIG_HOME/nnn/.lastd"
    else
        set -x NNN_TMPFILE "$HOME/.config/nnn/.lastd"
    end

    command nnn $argv

    if test -e $NNN_TMPFILE
        source $NNN_TMPFILE
        /usr/bin/rm $NNN_TMPFILE
    end
  end
end
