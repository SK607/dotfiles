
## Features

Developer-aware file classification with ~500 additonal rules (~600 in total) for terminals with x256 color suppport.

- ![183](https://via.placeholder.com/15/d7afff/d7afff.png) code — .sh, .cpp, .js, .css, .py, ....
- ![116](https://via.placeholder.com/15/87d7d7/87d7d7.png) config/certificate — .dockerignore, .vimrc, .ini, .cert, ...
- ![111](https://via.placeholder.com/15/87afff/87afff.png) build — Makefile, Dockerfile. .make, ...
- ![255](https://via.placeholder.com/15/eeeeee/eeeeee.png) documentation — .md, .rst, README, LICENCE, ...
- ![102](https://via.placeholder.com/15/878787/878787.png) log — .log, .lock, .swp, .bak, ...
- ![222](https://via.placeholder.com/15/ffd787/ffd787.png) data — .xml, .json, .csv, ...
- ![181](https://via.placeholder.com/15/d7afaf/d7afaf.png) document — .docx, .xls, .epub, .pdf, ...
- ![180](https://via.placeholder.com/15/d7af87/d7af87.png) archive
- ![210](https://via.placeholder.com/15/ff8787/ff8787.png) executable
- ![108](https://via.placeholder.com/15/87af87/87af87.png) font
- ![192](https://via.placeholder.com/15/d7ff87/d7ff87.png) image
- ![115](https://via.placeholder.com/15/87d7af/87d7af.png) audio
- ![113](https://via.placeholder.com/15/87d75f/87d75f.png) video
- ![117](https://via.placeholder.com/15/87d7ff/87d7ff.png) link
- ![223](https://via.placeholder.com/15/ffd7af/ffd7af.png) <ins>directory</ins>

Colors are based on [ayu theme (mirage)](https://github.com/ayu-theme/ayu-colors). Language support is based on [vscode](https://github.com/microsoft/vscode/tree/main/extensions)



## Installation
```bash
# install
wget .dircolors -O ~/.dircolors
echo 'eval `dircolors ~/.dircolors`' >> ~/.bashrc
echo 'alias ls='\''ls --color=auto'\''' >> ~/.bashrc
source ~/.bashrc

# use
ls -a
```


## Configuration

### Terminal

If you are using terminal that is missing in `.dircolors`:
```bash
echo $TERM >> ~/.dircolors
```

### Rules

To change rules - add /remove / comment / uncomment lines in `.dircolors`.

Typical line looks like:
```text
.zip                    00;48;5;203;38;5;0
```

First part - file extension:
- `.zip` (match `my.zip`)
- `*zip` (match `my.zip` and `my.gzip`)

Second part - text format string:
- `00;`: extra attributes applied
    - 00 (none)
    - 01 (bold)
    - 02 (muted)
    - 03 (italic)
    - 04 (underscore)
    - 05 (blink)
    - 07 (reverse foreground and background)
    - 08 (concealed)
- `48;5;203;`
    - `48;` (set background)
    - `5;`
    - `203;` (0-255 color code)
- `38;5;0`
    - `48;` (set foreground)
    - `5;`
    - `0;` (0-255 color code)

Background part (`48;5;203;`) may be omitted.

To test format - type terminal:
```bash
# \e[<format><text>\e[00m
printf '\e[05;48;5;255;38;5;0mtest text\e[00m'
```

### System-wide usage

For colors to be available to other users & under sudo you need to install them globally:
1. move `.dircolors` to `/etc/.dircolors`
2. modify `/etc/bash.bashrc`
```bash
# enable dircolors
if [[ -x /usr/bin/dircolors && -r /etc/.dircolors ]]; then
    eval "$(dircolors -b /etc/.dircolors)" || eval "$(dircolors -b)"
fi

alias ls='ls --color=auto'
alias sudo='sudo '  # https://askubuntu.com/questions/22037/aliases-not-available-when-using-sudo
```
3. restart your terminal
