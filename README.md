# WORKFLOW

- Distro
    - Arch Linux from [Garuda](https://garudalinux.org/)
- Desktop
    - [Sway](https://github.com/swaywm/sway) TWM for Wayland
    - [Azote](https://github.com/nwg-piotr/azote) background
    - [Swaylock](https://garudalinux.org/downloads.html) lock screen
    - [QtGreet](https://gitlab.com/marcusbritanicus/QtGreet) login screen
    - [Waybar](https://github.com/Alexays/Waybar) status bar
- Tools
    - Bash shell via [Alacritty](https://github.com/alacritty/alacritty) terminal emulator
    - [Vim](https://github.com/vim/vim) text editor
    - [nnn](https://github.com/jarun/nnn) file browser
    - [swayimg](https://github.com/jarun/advcpmv) img viewer
    - CLI commands
        - [fzf](https://github.com/junegunn/fzf) fuzzy finder
        - [bat](https://github.com/sharkdp/bat) replacement for `cat`
        - [exa](https://github.com/ogham/exa) replacement for `ls`
        - [rg](https://github.com/BurntSushi/ripgrep) replacement for `grep`
        - [fd](https://github.com/sharkdp/fd) replacement for `find`
        - [advcpmv](https://github.com/jarun/advcpmv) replacement for `cp` & `mv`
        - [delta](https://github.com/dandavison/delta) prettifier for `git diff`
        - [z.lua](https://github.com/skywind3000/z.lua) frecency replacement for `cd`


# THEME & COLORS

- `.config/alacritty/alacritty.yml` sets base terminal colors (via import of `theme-nord.yml`)
- `.config/bat/gruvbox-adj.tmTheme` sets bat colors (requires `bat cache --build` to apply)
- `.vim/theme/gruvbox.vim` sets vim colors
- `bash.d/.prompt.sh` adjusts colors based on alacritty
- `bash.d/.theme.sh` sets [fzf colors](https://github.com/junegunn/fzf/wiki/Color-schemes),  [nnn colors](https://github.com/jarun/nnn/wiki/Themes), [exa](https://the.exa.website/docs/colour-themes)/[ls](https://github.com/trapd00r/LS_COLORS) colors (via `bash.d/.dir_colors`)
