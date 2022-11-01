let g:ale_completion_enabled = 1
let g:ale_python_auto_poetry = 1
let g:ale_python_pylint_use_msg_id = 1

let g:ale_linters = {
\   'python': ['pylint', 'pylsp', 'mypy'],
\   'sh': ['language_server', 'shellcheck'],
\   'go': ['golangci-lint'],
\   'html': ['vscodehtml', 'htmlhint'],
\}
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'python': ['black'],
\   'html': ['html-beautify']
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
let g:ale_hover_cursor = 0
let g:ale_floating_preview = 1
let g:ale_warn_about_trailing_blank_lines = 0
let g:ale_warn_about_trailing_whitespace = 0
let g:ale_fix_on_save = 0
" let g:ale_floating_window_border = ['│', '─', '╭', '╮', '╯', '╰', '│', '─']
let g:ale_floating_window_border = [] 

nnoremap <Leader>as :ALEGoToDefinition<CR>
nnoremap <Leader>ad :ALEHover<CR>
nnoremap <Leader>ae :ALEDetail<CR>
nnoremap <Leader>af :ALEFix<CR>
nnoremap <Leader>ai :ALEInfo<CR>

