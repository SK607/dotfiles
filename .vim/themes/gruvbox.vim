colors gruvbox

hi QuickScopePrimary gui=underline
hi QuickScopeSecondary gui=underline

" nord theme bg fix
hi Normal guibg=#282c34
hi VertSplit guibg=#282c34
hi SignColumn guibg=#282c34
hi GruvboxRedSign guibg=NONE
hi GruvboxGreenSign guibg=NONE
hi GruvboxYellowSign guibg=NONE
hi GruvboxBlueSign guibg=NONE
hi GruvboxPurpleSign guibg=NONE
hi GruvboxAquaSign guibg=NONE
hi GruvboxOrangeSign guibg=NONE

" tabline
hi TabLine guibg=#3b4252 guifg=#81a1c1 gui=NONE cterm=NONE
hi TabLineSel guibg=#81a1c1 guifg=#282c34
hi TabLineFill guibg=#282c34 guifg=#3b4252
hi TabLinePointer guibg=#81a1c1 guifg=#3b4252 
hi link TabLinePointerSel TabLine
hi TabLinePointerNC guibg=#3b4252 guifg=#3b4252 
hi link TabLinePointerFirst TabLineSel
hi TabLinePointerFirstNC guibg=#3b4252 guifg=#282c34 
hi TabLinePointerLast guibg=#282c34 guifg=#81a1c1 
hi link TabLinePointerLastNC TabLineFill

" statusline
hi StatusLine guibg=#3b4252 guifg=#e5e9f0 gui=NONE cterm=NONE term=NONE
hi StatusLineNC guibg=#2e3440 guifg=#e5e9f0 gui=NONE cterm=NONE term=NONE
hi StatusLineNormal guibg=#81a1c1 guifg=#3b4252 
hi StatusLineInsert guibg=#e5e9f0 guifg=#3b4252
hi StatusLineVisual guibg=#8fbcbb guifg=#3b4252 
hi StatusLineCommand guibg=#98c379 guifg=#3b4252 
hi! link StatusLineTerm StatusLine
hi! link StatusLineTermNC StatusLineNC
