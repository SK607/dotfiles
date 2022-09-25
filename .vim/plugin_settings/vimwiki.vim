let g:vimwiki_list = [{
    \ 'path': '~/code-projects/devops/vimwiki/',
    \ 'syntax': 'markdown',
    \ 'nested_syntaxes': {'bash': 'bash', 'python': 'python'},
    \ 'ext': '.md'
    \ }]
let g:vimwiki_global_ext = 0

nmap <Leader>ww :tabnew \| VimwikiIndex<CR>
