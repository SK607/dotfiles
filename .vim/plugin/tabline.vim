function! s:BufId(n)
    return '[' . a:n . '] '
endfunction

function! s:BufName(n)
    let buftype = getbufvar(a:n, "&buftype")
    if buftype == ''
        let fname = fnamemodify(bufname(a:n), ':t') " pathshorten(bufname(b))
        if fname == ''
            let fname = 'New'
        endif
        let name = fname
    else
        let name = buftype
    endif
    return name
endfunction

function! s:BufModified(n)
    if getbufvar(a:n, "&modified")
        let icon = ' '
    else
        let icon = ''
    endif
    return icon
endfunction

function! s:TabName(n)
    let name = ''
    if a:n == winbufnr(0)
        if a:n == 1
            let name .= "%#TabLinePointerFirst#"
        else
            let name .= "%#TabLinePointer#"
        endif
        let name .= "%#TabLineSel#"
    else
        if a:n == 1
            let name .= "%#TabLinePointerFirstNC#"
        else
            let name .= "%#TabLinePointerNC#"
        endif
        let name .= "%#TabLine#"
    endif
    let name .= s:BufId(a:n)
    let name .= s:BufName(a:n)
    let name .= s:BufModified(a:n)
    if a:n == winbufnr(0)
        if a:n == winnr('$')
            let name .= "%#TabLinePointerLast#"
        else
            let name .= "%#TabLinePointerSel#"
        endif
    else
        if a:n == winnr('$')
            let name .= "%#TabLinePointerLastNC#"
        else
            let name .= "%#TabLinePointerNC#"
        endif
    endif
    let name .= ''
    return name
endfunction

function! TabLine()
    let tabline = ''
    for i in range(tabpagenr('$'))
        for b in tabpagebuflist(i + 1)
            let tabline .= s:TabName(b)
        endfor
    endfor
    let tabline .= "%#TabLineFill#%T"
    return tabline
endfunction

set tabline=%!TabLine()

