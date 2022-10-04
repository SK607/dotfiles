" ============================================================================
" File:        vim-swiftline.vim
" Description: Fast minimalist statusline
" Author:      Sergey.Konkin <sergey.konkin.eth@gmail.com>
" Licence:     MIT
" Website:     https://github.com/SK607/dotfiles
" Version:     1.0
" ============================================================================

if exists('g:loaded_swiftline_plugin')
    finish
endif
let g:loaded_swiftline_plugin = 1

scriptencoding utf-8


def s:Status(): string
    var sname = ''
    var scolor = '%#StatusLineNC#'
    var scolor_reset = '%#StatusLineNC#'
    if g:statusline_winid == win_getid()
        var m = mode(1)
        if index(['R', 'Rc', 'Rv', 'Rx'], m[0]) >= 0
            sname = 'REPLACE'
            scolor = '%#StatusLineInsert#' 
        elseif index(['i', 'ic', 'ix'], m[0]) >= 0
            sname = 'INSERT'
            scolor = '%#StatusLineInsert#'
        elseif index(['v', 'V', "\<C-V>", 's', 'S', "\<C-S>"], m[0]) >= 0
            sname = 'VISUAL'
            scolor = '%#StatusLineVisual#'
        elseif index(['t'], m[0]) >= 0
            sname = 'TERM'
            scolor = '%#StatusLineNormal#' 
        elseif index(['c', 'cv', 'ce', 'r', 'rm', 'r?'], m[0]) >= 0
            sname = 'COMMAND'
            scolor = '%#StatusLineCommand#'
        else
            sname = 'NORMAL'
            scolor = '%#StatusLineNormal#' 
        endif
        scolor_reset = '%#StatusLine#'
    endif
    return scolor
        .. ' ' .. printf('%7S', sname) .. ' '
        .. scolor_reset 
enddef

def s:ALEStatus()
    # implies lint only on save
    if get(b:, 'ale_linted', 0) > 0
        var counts = ale#statusline#Count(bufnr())
        var status = ''
            .. get(g:, 'ale_sign_error', 'e')
            .. counts.error
            .. ' '
            .. get(g:, 'ale_sign_warning', 'w')
            .. counts.warning
        b:swiftline_ale_status = status
    endif
enddef

def s:Sh(command: string): string
    # removes trailing newline
    return trim(system(command))
enddef

def s:GitBranch()
    if !exists('b:swiftline_git_branch')
        var bpath = expand('%:p') 
        var bfile = s:Sh(
            'readlink -f ' .. shellescape(bpath)
        )
        var bdir = s:Sh(
            'dirname ' .. shellescape(bfile)
        )
        var git = s:Sh(
            'cd ' .. shellescape(bdir) .. ' && '
            .. 'git rev-parse --show-toplevel 2>/dev/null'
        )
        if !empty(git)
            var branch = s:Sh(
                'cd ' .. shellescape(bdir)
                .. ' && ! git check-ignore -q '
                .. shellescape(bfile)
                .. ' && git symbolic-ref --short HEAD'
            )
            if !empty(branch) 
                b:swiftline_git_branch = '  ' .. branch
            endif
        endif
    endif
enddef

def SwiftLine(): string
    var bufnr = winbufnr(g:statusline_winid)
    var line = ''
        .. s:Status()
        .. ' %<%f'
        .. '%='
        .. getbufvar(bufnr, 'swiftline_ale_status', '')
        .. getbufvar(bufnr, 'swiftline_git_branch', '')
        .. "  %{&filetype!=#''?&filetype:'none'}"
        .. ' '
    return line
enddef


augroup SwiftLine
    autocmd!
    autocmd BufReadPost,BufWritePost * call s:GitBranch()
    autocmd BufWritePost * :silent call s:ALEStatus()
augroup END

set statusline=%!SwiftLine()

