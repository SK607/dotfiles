if test -x "$(command -v nnn)"
  set -x NNN_OPTS 'cEHrx'
  set -x NNN_BMS "c:$HOME/code-projects;d:$HOME/Downloads;p:$HOME/Pictures"
  set -x NNN_ORDER "t:$HOME/Downloads;t:$HOME/Pictures"
  set -x NNN_PLUG 'p:preview-tui;g:git-diff;i:swayimg'
  set -x NNN_ARCHIVE '\\.(7z|a|ace|alz|arc|arj|bz|bz2|cab|cpio|deb|gz|jar|lha|lz|lzh|lzma|lzo|rar|rpm|rz|t7z|tar|tbz|tbz2|tgz|tlz|txz|tZ|tzo|war|xpi|xz|Z|zip)$'
  set -x NNN_FIFO '/tmp/nnn.fifo'
  set -x SPLIT 'v'
end
