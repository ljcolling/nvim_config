let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/.config/kitty/rose-pine
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +38 ~/.config/lvim/config.lua
badd +1 ~/.tmux/.tmux.conf
badd +1 ~/.config/skhd/skhdrc
badd +1 ~/.config/yabai/yabairc
badd +42 ~/.config/spacebar/spacebarrc
badd +99 ~/.config/kitty/kitty.conf
badd +8 rose-pine-dawn.conf
argglobal
%argdel
$argadd ~/.config/alacritty/alacritty.yml
$argadd ~/.tmux/.tmux.conf
$argadd ~/.config/skhd/skhdrc
$argadd ~/.config/yabai/yabairc
$argadd ~/.config/spacebar/spacebarrc
edit rose-pine-dawn.conf
argglobal
if bufexists("rose-pine-dawn.conf") | buffer rose-pine-dawn.conf | else | edit rose-pine-dawn.conf | endif
if &buftype ==# 'terminal'
  silent file rose-pine-dawn.conf
endif
balt ~/.config/kitty/kitty.conf
let s:l = 1 - ((0 * winheight(0) + 13) / 27)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 0
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=OnfxFTtocliI
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
set hlsearch
nohlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
