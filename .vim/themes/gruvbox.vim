colors gruvbox

hi QuickScopePrimary gui=underline
hi QuickScopeSecondary gui=underline
hi Normal guibg=#282c34
hi VertSplit guibg=#282c34
" ALE & signify
hi SignColumn guibg=#282c34
hi GruvboxRedSign guibg=NONE
hi GruvboxGreenSign guibg=NONE
hi GruvboxYellowSign guibg=NONE
hi GruvboxBlueSign guibg=NONE
hi GruvboxPurpleSign guibg=NONE
hi GruvboxAquaSign guibg=NONE
hi GruvboxOrangeSign guibg=NONE
" line numbers
hi LineNr guifg=#b8bb26 
hi LineNrAbove guifg=#bdae93 
hi LineNrBelow guifg=#bdae93 

" tabline {{{2
hi TabLine guibg=#504945 guifg=#bdae93 gui=NONE cterm=NONE
hi TabLineSel guibg=#bdae93 guifg=#282c34
hi TabLineFill guibg=#282c34 guifg=#504945
hi TabLinePointer guibg=#bdae93 guifg=#504945 
hi link TabLinePointerSel TabLine
hi TabLinePointerNC guibg=#504945 guifg=#504945 
hi link TabLinePointerFirst TabLineSel
hi TabLinePointerFirstNC guibg=#504945 guifg=#282c34 
hi TabLinePointerLast guibg=#282c34 guifg=#bdae93 
hi link TabLinePointerLastNC TabLineFill

" statusline {{{2
hi StatusLine guibg=#434c5e guifg=#d8dee9 gui=NONE cterm=NONE
hi StatusLineNC guibg=#2e3440 guifg=#d8dee9 gui=NONE cterm=NONE
hi StatusLineNormal guibg=#434c5e guifg=#d8dee9  
hi StatusLineInsert guibg=#ebcb8b guifg=#282c34 
hi StatusLineVisual guibg=#b48ead guifg=#282c34 
hi StatusLineCommand guibg=#98c379 guifg=#282c34 
hi! link StatusLineTerm StatusLine
hi! link StatusLineTermNC StatusLineNC
