function! s:StatusBlock()
    if g:statusline_winid == win_getid()
        let m = mode(1)
        if index(["R", "Rc", "Rv", "Rx"], m[0]) >= 0
            let name = 'REPLACE'
            let color = "%#StatusLineInsert#" 
        elseif index(["i", "ic", "ix"], m[0]) >= 0
            let name = ' INSERT'
            let color = "%#StatusLineInsert#"
        elseif index(["v", "V", "\<C-V>", "s", "S", "\<C-S>"], m[0]) >= 0
            let name = ' VISUAL'
            let color = "%#StatusLineVisual#"
        elseif index(["t"], m[0]) >= 0
            let name = '   TERM'
            let color = "%#StatusLineNormal#" 
        elseif index(["c", "cv", "ce", "r", "rm", "r?"], m[0]) >= 0
            let name = 'COMMAND'
            let color = "%#StatusLineCommand#"
        else
            let name = ' NORMAL'
            let color = "%#StatusLineNormal#" 
        endif
        let color_reset = "%#StatusLine#"
    else
        let name = '       '
        let color = '%#StatusLineNC#'
        let color_reset = "%#StatusLineNC#"
    endif
    return color.' '.name.' '.color_reset
endfunction

" function! s:ALEBlock()
"   if get(g:, 'ale_enabled', 0) == 0
"     return ''
"   endif
"   let l:line = ' ' . get(g:, 'ale_sign_error', 'e') .
"              \ ' ' . l:counts.error .
"              \ ' ' . get(g:, 'ale_sign_warning', 'w') .
"              \ ' ' . l:counts.warning
"   return l:line
" endfunction

function! GitBranch()
    if !exists('b:statusline_git_branch')
        let git_branch = gitbranch#name()
        if len(git_branch) != 0
            let git_branch = ' '.git_branch
        endif
        let b:statusline_git_branch = git_branch
    endif
endfunction

augroup MyStatusLine
    autocmd!
    autocmd BufReadPost * :silent call GitBranch()
augroup END

function! StatusLine()
    let bufnr = winbufnr(g:statusline_winid)
    let line  = ''
    let line .= s:StatusBlock()
    let line .= ' %<%f'
    let line .= '%='
    let line .= getbufvar(bufnr, 'statusline_git_branch', '')
    let line .= "  %{&filetype!=#''?&filetype:'none'} "
    " let line .= s:ALEBlock()
    return line
endfunction

set statusline=%!StatusLine()

