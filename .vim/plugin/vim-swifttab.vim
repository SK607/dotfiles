" ============================================================================
" File:        vim-swifttab.vim
" Description: Fast minimalist tabline
" Author:      Sergey.Konkin <sergey.konkin.eth@gmail.com>
" Licence:     MIT
" Website:     https://github.com/SK607/dotfiles
" Version:     1.0
" ============================================================================

if exists('g:loaded_swifttab_plugin')
    finish
endif
let g:loaded_swifttab_plugin = 1

scriptencoding utf-8


def s:BufId(bufnr: number): string
    return '[' .. bufnr .. '] '
enddef

def s:BufName(bufnr: number): string
    var buftype = getbufvar(bufnr, "&buftype")
    var name = buftype
    if buftype == ''
        var fname = fnamemodify(bufname(bufnr), ':t')
        if fname == ''
            fname = '*'
        endif
        name = fname
    endif
    return name
enddef

def s:BufModified(bufnr: number): string
    var icon = ' '
    if getbufvar(bufnr, "&modified")
        icon = ' '
    endif
    return icon
enddef

def s:TabPointerStart(bufnr: number): string
    var pointer = ''
    if bufnr == winbufnr(0)
        if bufnr == 1
            pointer ..= "%#TabLinePointerFirst#"
        else
            pointer ..= "%#TabLinePointer#"
        endif
        pointer ..= "%#TabLineSel#"
    else
        if bufnr == 1
            pointer ..= "%#TabLinePointerFirstNC#"
        else
            pointer ..= "%#TabLinePointerNC#"
        endif
        pointer ..= "%#TabLine#"
    endif
    return pointer
enddef

def s:TabPointerEnd(bufnr: number): string
    var pointer = ''
    var lastbufnr = tabpagebuflist(tabpagenr('$'))[-1]
    if bufnr == winbufnr(0)
        if bufnr == lastbufnr
            pointer ..= "%#TabLinePointerLast#"
        else
            pointer ..= "%#TabLinePointerSel#"
        endif
    else
        if bufnr == lastbufnr
            pointer ..= "%#TabLinePointerLastNC#"
        else
            pointer ..= "%#TabLinePointerNC#"
        endif
    endif
    pointer ..= ''
    return pointer
enddef

def s:TabName(bufnr: number): string
    var name = ''
        .. s:TabPointerStart(bufnr)
        .. s:BufId(bufnr)
        .. s:BufName(bufnr)
        .. s:BufModified(bufnr)
        .. s:TabPointerEnd(bufnr) 
    return name
enddef

def SwiftTab(): string
    var tabline = ''
    for i in range(tabpagenr('$'))
        for b in tabpagebuflist(i + 1)
            tabline ..= s:TabName(b)
        endfor
    endfor
    tabline ..= "%#TabLineFill#%T"
    return tabline
enddef


def s:BufTabNr(bufnr: number): number
   var tabnr = 0
   for tnr in range(tabpagenr('$'))
      if index(tabpagebuflist(tnr + 1), bufnr) >= 0
          tabnr = tnr + 1
          break
      endif
   endfor
   return tabnr
enddef

def GoToBuf(bufnr: number)
    if bufwinnr(bufnr) == -1
        execute 'silent tabnext ' .. s:BufTabNr(bufnr)
    endif
    execute ':' .. bufwinnr(bufnr) .. 'wincmd w'
enddef


set tabline=%!SwiftTab()

nnoremap <silent> <Leader>1 :call GoToBuf(1)<CR>
nnoremap <silent> <Leader>2 :call GoToBuf(2)<CR>
nnoremap <silent> <Leader>3 :call GoToBuf(3)<CR>
nnoremap <silent> <Leader>4 :call GoToBuf(4)<CR>
nnoremap <silent> <Leader>5 :call GoToBuf(5)<CR>
nnoremap <silent> <Leader>6 :call GoToBuf(6)<CR>
nnoremap <silent> <Leader>7 :call GoToBuf(7)<CR>
nnoremap <silent> <Leader>8 :call GoToBuf(8)<CR>
nnoremap <silent> <Leader>9 :call GoToBuf(9)<CR>

