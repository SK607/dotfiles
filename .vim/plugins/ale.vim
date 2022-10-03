let g:ale_completion_enabled = 1
let g:ale_python_auto_poetry = 1
let g:ale_linters = {
\   'python': ['pylint', 'pylsp'],
\   'sh': ['language_server', 'shellcheck']
\}
let g:ale_linters_explicit = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0 
let g:ale_lint_on_enter = 0
let g:ale_lint_on_filetype_changed = 0
let g:ale_sign_info = 'i'
let g:ale_sign_warning = '!'
let g:ale_sign_error = 'x'
let g:ale_sign_syle_warning = g:ale_sign_warning
let g:ale_sign_style_error = g:ale_sign_error
let g:ale_set_quickfix = 1
let g:ale_set_loclist = 0
let g:ale_open_list = 0
let g:ale_completion_max_suggestions = 10
let g:ale_echo_cursor = 0

nnoremap def :ALEGoToDefinition -tab<CR>
nnoremap doc :ALEHover<CR>
nnoremap err :ALEDetail<CR>

