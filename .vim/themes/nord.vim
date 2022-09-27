set background=dark
if &t_Co >= 256
  set termguicolors
endif
colors nord

hi QuickScopePrimary gui=underline cterm=underline
hi QuickScopeSecondary gui=underline cterm=underline
hi! link LineNr Type
hi! link LineNrAbove Comment
hi! link LineNrBelow Comment

let s:nord0_gui = "#2E3440"
let s:nord1_gui = "#3B4252"
let s:nord2_gui = "#434C5E"
let s:nord3_gui = "#4C566A"
let s:nord3_gui_bright = "#616E88"
let s:nord4_gui = "#D8DEE9"
let s:nord5_gui = "#E5E9F0"
let s:nord6_gui = "#ECEFF4"
let s:nord7_gui = "#8FBCBB"
let s:nord8_gui = "#88C0D0"
let s:nord9_gui = "#81A1C1"
let s:nord10_gui = "#5E81AC"
let s:nord11_gui = "#BF616A"
let s:nord12_gui = "#D08770"
let s:nord13_gui = "#EBCB8B"
let s:nord14_gui = "#A3BE8C"
let s:nord15_gui = "#B48EAD"
" tabline {{{2
hi TabLine guibg=#504945 ctermbg=239 guifg=#bdae93 ctermfg=248 cterm=NONE term=NONE
hi TabLineSel guibg=#bdae93 ctermbg=248 guifg=#282c34 ctermfg=237 cterm=NONE term=NONE
hi TabLineFill guibg=#282c34 ctermbg=237 guifg=#504945 ctermfg=239 cterm=NONE term=NONE
hi TabLinePointer guibg=#bdae93 ctermbg=248 guifg=#504945 ctermfg=239
hi link TabLinePointerSel TabLine
hi TabLinePointerNC guibg=#504945 ctermbg=239 guifg=#504945 ctermfg=239
hi link TabLinePointerFirst TabLineSel
hi TabLinePointerFirstNC guibg=#504945 ctermbg=239 guifg=#282c34 ctermfg=237
hi TabLinePointerLast guibg=#282c34 ctermbg=237 guifg=#bdae93 ctermfg=248
hi link TabLinePointerLastNC TabLineFill

" statusline {{{2
hi StatusLine guibg=#665c54  ctermbg=241 guifg=#bdae93 ctermfg=248 cterm=NONE
hi StatusLineNC guibg=#504945  ctermbg=239 guifg=#bdae93 ctermfg=248 cterm=NONE
hi StatusLineNormal guibg=#bdae93 ctermbg=248 guifg=#282c34 ctermfg=237
hi StatusLineInsert guibg=#fabd2f ctermbg=214 guifg=#282c34 ctermfg=237
hi StatusLineVisual guibg=#ebdbb2 ctermbg=223 guifg=#282c34 ctermfg=237
hi StatusLineCommand guibg=#b8bb26 ctermbg=142 guifg=#282c34 ctermfg=237
hi! link StatusLineTerm StatusLine
hi! link StatusLineTermNC StatusLineNC
