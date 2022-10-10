let g:vimwiki_list = [{
    \ 'path': '~/code-projects/devops/vimwiki/',
    \ 'syntax': 'markdown',
    \ 'nested_syntaxes': {'bash': 'bash', 'python': 'python'},
    \ 'ext': '.md'
    \ }]
let g:vimwiki_global_ext = 0

nnoremap <Leader>ww :VimwikiTabIndex<CR>

" resolve collision with vim-indentwise
autocmd FileType vimwiki map [= <Plug>(IndentWisePreviousEqualIndent)
autocmd FileType vimwiki map ]= <Plug>(IndentWiseNextEqualIndent)
autocmd FileType vimwiki nnoremap {{ <Plug>VimwikiGoToNextHeader
autocmd FileType vimwiki nnoremap }} <Plug>VimwikiGoToPrevHeader
autocmd FileType vimwiki nnoremap {= <Plug>VimwikiGoToNextSiblingHeader
autocmd FileType vimwiki nnoremap }= <Plug>VimwikiGoToPrevSiblingHeader

