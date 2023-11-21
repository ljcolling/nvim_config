let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/Library/Mobile\ Documents/com~apple~CloudDocs/teaching/matlab-marking/submissions/244896/Assessment\ 1
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +1 ~/Library/Mobile\ Documents/com~apple~CloudDocs/teaching/matlab-marking/submissions/244896/Assessment\ 1/Scripts/Stoop_task.m
badd +1 ~/Library/Mobile\ Documents/com~apple~CloudDocs/teaching/matlab-marking/submissions/244896/Assessment\ 1/Functions/MakeTrialsIn.m
badd +23 ~/Library/Mobile\ Documents/com~apple~CloudDocs/teaching/matlab-marking/submissions/244896/Assessment\ 1/Functions/MakeTrialsC.m
argglobal
%argdel
edit ~/Library/Mobile\ Documents/com~apple~CloudDocs/teaching/matlab-marking/submissions/244896/Assessment\ 1/Functions/MakeTrialsIn.m
argglobal
balt ~/Library/Mobile\ Documents/com~apple~CloudDocs/teaching/matlab-marking/submissions/244896/Assessment\ 1/Functions/MakeTrialsC.m
let s:l = 19 - ((18 * winheight(0) + 21) / 43)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 19
normal! 044|
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=flOTFcotxinI
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
set hlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
