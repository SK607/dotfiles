let g:signify_vcs_list = ['git']
let g:signify_sign_add = ''
let g:signify_sign_delete = ''
let g:signify_sign_change = ''
let g:signify_sign_delete_first_line = g:signify_sign_delete
let g:signify_sign_change_delete = g:signify_sign_change . g:signify_sign_delete_first_line

nnoremap <Leader>gd :SignifyDiff<CR>
nnoremap <Leader>gp :SignifyHunkDiff<CR>
nnoremap <Leader>gu :SignifyHunkUndo<CR>

