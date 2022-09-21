let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } }
let g:fzf_colors =
\ { 'fg':         ['fg', 'Normal'],
  \ 'bg':         ['bg', 'Normal'],
  \ 'preview-bg': ['bg', 'NormalFloat'],
  \ 'hl':         ['fg', 'Comment'],
  \ 'fg+':        ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':        ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':        ['fg', 'Statement'],
  \ 'info':       ['fg', 'PreProc'],
  \ 'border':     ['fg', 'Ignore'],
  \ 'prompt':     ['fg', 'Conditional'],
  \ 'pointer':    ['fg', 'Exception'],
  \ 'marker':     ['fg', 'Keyword'],
  \ 'spinner':    ['fg', 'Label'],
  \ 'header':     ['fg', 'Comment'] }

command! FindDir call fzf#run({ 'sink': 'cd', 'source': 'fd --type d --strip-cwd-prefix '.<f-args>.'', 'options': '--preview ''exa --icons --tree --color=always --group-directories-first --sort modified --reverse --ignore-glob "__pycache__|.git" --git-ignore -L 1 {}'' --prompt "$(basename "$PWD")/"' })
command! FindFile call fzf#run(fzf#wrap({ 'source': 'fd --type f --strip-cwd-prefix '.<f-args>.'', 'options': '--preview ''bat -n --color=always {}'' --prompt "$(basename "$PWD")/"'}))

nnoremap <Leader>fd :FindDir<CR>
nnoremap <Leader>ff :FindFile<CR>
nnoremap <Leader>fif :Rg<CR>

