set background=dark
if &t_Co >= 256
  set termguicolors
endif
colors gruvbox

hi QuickScopePrimary gui=underline
hi QuickScopeSecondary gui=underline
hi Normal guibg=#282c34
hi VertSplit guibg=#282c34
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
hi StatusLine guibg=#665c54 guifg=#bdae93 gui=NONE cterm=NONE
hi StatusLineNC guibg=#504945 guifg=#bdae93 gui=NONE cterm=NONE
hi StatusLineNormal guibg=#bdae93 guifg=#282c34 
hi StatusLineInsert guibg=#fabd2f guifg=#282c34 
hi StatusLineVisual guibg=#ebdbb2 guifg=#282c34 
hi StatusLineCommand guibg=#b8bb26 guifg=#282c34 
hi! link StatusLineTerm StatusLine
hi! link StatusLineTermNC StatusLineNC
