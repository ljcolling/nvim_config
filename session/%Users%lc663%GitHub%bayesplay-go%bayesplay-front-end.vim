let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/GitHub/bayesplay-go/bayesplay-front-end
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +8 docker-compose.yml
badd +6 test/test.py
badd +48 test/calculator.py
badd +13 test/testcases.json
badd +2 test/utils.py
badd +1 ~/GitHub/bayesplay-go/bayesplay-front-end/Dockerfile.test
badd +10 ~/GitHub/bayesplay-go/bayesplay-front-end/Dockerfile.build
badd +2 ~/GitHub/bayesplay-go/bayesplay-front-end/.dockerignore
badd +43 ~/GitHub/bayesplay-go/bayesplay-front-end/package.json
badd +5 ~/GitHub/bayesplay-go/bayesplay-front-end/test/runtests.sh
argglobal
%argdel
$argadd docker-compose.yml
edit test/test.py
argglobal
balt docker-compose.yml
let s:l = 5 - ((4 * winheight(0) + 24) / 49)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 5
normal! 0
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=TnfitFcoOlxI
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
