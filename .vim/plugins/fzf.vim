let g:fzf_preview_window = ['down,70%', 'ctrl-/']
let g:fzf_layout = { 'window': { 'width': 1.0, 'height': 1.0 } }
let g:fzf_commits_log_options = '--graph --color=always --format="%C(green)%h %C(cyan)%as %C(auto)%s - %C(yellow)%an"'
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

nnoremap <Leader>fb :Buffers<CR>
nnoremap <Leader>fh :Helptags<CR>
nnoremap <Leader>fs :Snippets<CR>
nnoremap <Leader>fr :History<CR>
nnoremap <Leader>fgp :Commits<CR>
nnoremap <Leader>fgf :BCommits<CR>

