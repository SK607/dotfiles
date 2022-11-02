colors everforest

hi QuickScopePrimary gui=underline
hi QuickScopeSecondary gui=underline

" nord theme bg fix
" hi Normal guibg=#282c34
" hi VertSplit guibg=#282c34
" hi EndOfBuffer guibg=#282c34 
" hi Terminal guibg=#282c34

" tabline
hi TabLine guibg=#4a555b guifg=#d3c6aa gui=NONE cterm=NONE
hi TabLineSel guibg=#d3c6aa guifg=#2f383e
hi TabLineFill guibg=#2f383e guifg=#4a555b
hi TabLinePointer guibg=#d3c6aa guifg=#4a555b 
hi link TabLinePointerSel TabLine
hi TabLinePointerNC guibg=#4a555b guifg=#4a555b 
hi link TabLinePointerFirst TabLineSel
hi TabLinePointerFirstNC guibg=#4a555b guifg=#2f383e 
hi TabLinePointerLast guibg=#2f383e guifg=#d3c6aa 
hi link TabLinePointerLastNC TabLineFill

" statusline
hi StatusLine guibg=#4a555b guifg=#d3c6aa gui=NONE cterm=NONE term=NONE
hi StatusLineNC guibg=#404c51 guifg=#d3c6aa gui=NONE cterm=NONE term=NONE
hi StatusLineNormal guibg=#a7c080 guifg=#4a555b 
hi StatusLineInsert guibg=#d3c6aa guifg=#4a555b
hi StatusLineVisual guibg=#e67e80 guifg=#4a555b 
hi StatusLineCommand guibg=#83c092 guifg=#4a555b 
hi! link StatusLineTerm StatusLine
hi! link StatusLineTermNC StatusLineNC
