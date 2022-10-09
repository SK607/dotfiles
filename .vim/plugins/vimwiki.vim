let g:vimwiki_list = [{
    \ 'path': '~/code-projects/devops/vimwiki/',
    \ 'syntax': 'markdown',
    \ 'nested_syntaxes': {'bash': 'bash', 'python': 'python'},
    \ 'ext': '.md'
    \ }]
let g:vimwiki_global_ext = 0

nnoremap <Leader>ww :VimwikiTabIndex<CR>

" resolve collision with vim-indentwise
map [= <Plug>(IndentWisePreviousEqualIndent)
map ]= <Plug>(IndentWiseNextEqualIndent)
nnoremap h[[ <Plug>VimwikiGoToNextHeader
nnoremap h]] <Plug>VimwikiGoToPrevHeader
nnoremap h[= <Plug>VimwikiGoToNextSiblingHeader
nnoremap h]= <Plug>VimwikiGoToPrevSiblingHeader

