let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/Library/Mobile\ Documents/com~apple~CloudDocs/teaching/matlab-marking/untitled\ folder/Archive/old-submissins/244975/New\ folder
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +16 MakeTrials.m
badd +3 ~/Library/Mobile\ Documents/com~apple~CloudDocs/teaching/matlab-marking/untitled\ folder/Archive/old-submissins/244975/New\ folder/flanker_task.m
argglobal
%argdel
$argadd MakeTrials.m
edit MakeTrials.m
argglobal
balt ~/Library/Mobile\ Documents/com~apple~CloudDocs/teaching/matlab-marking/untitled\ folder/Archive/old-submissins/244975/New\ folder/flanker_task.m
let s:l = 62 - ((15 * winheight(0) + 13) / 27)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 62
normal! 03|
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=OioTltcxnfFI
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
