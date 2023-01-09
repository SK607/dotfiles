let g:vimwiki_list = [{
    \ 'path': '~/Code/devops/vimwiki/',
    \ 'syntax': 'markdown',
    \ 'nested_syntaxes': {'bash': 'bash', 'python': 'python'},
    \ 'ext': '.md'
    \ }]
let g:vimwiki_global_ext = 0
let g:vimwiki_key_mappings = { 'table_mappings': 0, }
let g:vimwiki_folding='expr'

nnoremap <Leader>ww :VimwikiTabIndex<CR>

augroup VimWikiSettings
    " resolve collision with vim-indentwise
    autocmd FileType vimwiki map [= <Plug>(IndentWisePreviousEqualIndent)
    autocmd FileType vimwiki map ]= <Plug>(IndentWiseNextEqualIndent)
    autocmd FileType vimwiki map [+ <Plug>(IndentWiseNextGreaterIndent)
    autocmd FileType vimwiki map ]+ <Plug>(IndentWisePreviousGreaterIndent)
    autocmd FileType vimwiki nnoremap {{ <Plug>VimwikiGoToPrevHeader
    autocmd FileType vimwiki nnoremap }} <Plug>VimwikiGoToNextHeader
    autocmd FileType vimwiki nnoremap {= <Plug>VimwikiGoToPrevSiblingHeader
    autocmd FileType vimwiki nnoremap }= <Plug>VimwikiGoToNextSiblingHeader
    autocmd FileType vimwiki nnoremap {+ <Plug>VimwikiGoToParentHeader
    autocmd FileType vimwiki nnoremap }+ <Plug>VimwikiGoToParentHeader
augroup END
