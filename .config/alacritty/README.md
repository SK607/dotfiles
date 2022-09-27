# Sway app launching

`gtk-launch` fails with alacritty.

To fix this:
1. `ln -s /usr/bin/alacritty /usr/bin/xterm`
2. add `--login` to shell args in alacritty config (otherwise apps (e.g. vim, fzf, ...) will load unconfigured)
