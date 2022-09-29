if test -f ~/.local/opt/z.lua/z.lua 
  lua ~/.local/opt/z.lua/z.lua --init fish enhanced once | source
  set -gx _ZL_CD cd
end
