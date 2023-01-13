### CONFIGURE ENV VARIABLES
# unified fish/bash env variable import
set -l ENV_CFG "$HOME/.config/shell/env.cfg"
if test -f "$ENV_CFG"
  egrep -v '^#|^\s*$' "$ENV_CFG" | while read line
    echo $line | read -t scope variable value
    if test -x "$(command -v $scope)"
      set -l expanded $(eval "echo $value")
      set -gx $variable $expanded
    end
  end
end

# fish
set -gx SHELL "/bin/fish"

# fzf
if test -f "$HOME/.config/fish/fish_plugins"
  if grep 'fzf' "$HOME/.config/fish/fish_plugins" 1> /dev/null
    set fzf_preview_dir_cmd exa --group-directories-first --icons --all --oneline --color=always
    set fzf_preview_file_cmd bat -p --color=always
    set fzf_fd_opts --hidden
  end
end


### CONFIGURE CLI
# prompt
if status --is-interactive
  source (starship init fish --print-full-init | psub)
end


### ADD FUNCTIONS
if test -d $DOTFILES_HOME
function edot
  $EDITOR "$(\
    fd \
      --type file \
      --unrestricted \
      --ignore-case \
      --full-path \
      --absolute-path \
      "$argv" "$DOTFILES_HOME" \
    | fzf \
      --select-1 \
      --exit-0 \
      --filter "$argv" \
    | head -n 1 \
    )"
end
end

if test -x "$(command -v bat)"
  function helpd
    "$argv" --help 2>&1 | bat --plain --language=help
  end
end

if test -x "$(command -v nnn)"
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

    # set -x LC_COLLATE 'C'
    command nnn $argv

    if test -e $NNN_TMPFILE
        source $NNN_TMPFILE
        /usr/bin/rm $NNN_TMPFILE
    end
  end
end


### ADD ALIASES
set -l ALIAS_CFG "$HOME/.config/shell/alias.cfg"
if test -f "$ALIAS_CFG"
  egrep -v '^#|^\s*$' "$ALIAS_CFG" | while read line
    echo $line | read -t scope variable value
    if test -x "$(command -v $scope)"
      set -l expanded $(eval "echo $value")
      alias $variable $expanded
    end
  end
end
