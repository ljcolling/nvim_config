let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/GitHub/development/bayesplay/tests
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
argglobal
%argdel
edit ~/GitHub/development/bayesplay/tests/_pkgdown.yml
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
wincmd =
argglobal
balt tests/testthat/test-plots.R
let s:l = 18 - ((17 * winheight(0) + 22) / 44)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 18
normal! 0
wincmd w
argglobal
if bufexists("~/GitHub/development/bayesplay/tests/R/classes.r") | buffer ~/GitHub/development/bayesplay/tests/R/classes.r | else | edit ~/GitHub/development/bayesplay/tests/R/classes.r | endif
if &buftype ==# 'terminal'
  silent file ~/GitHub/development/bayesplay/tests/R/classes.r
endif
balt ~/GitHub/development/bayesplay/tests/R/extract_functions.R
let s:l = 103 - ((12 * winheight(0) + 22) / 44)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 103
normal! 0
wincmd w
2wincmd w
wincmd =
tabnext 1
badd +8 tests/testthat/test-plots.R
badd +419 ~/GitHub/development/bayesplay/tests/R/plots.R
badd +37 ~/GitHub/development/bayesplay/tests/tests/testthat/test-posterior.R
badd +18 ~/GitHub/development/bayesplay/tests/_pkgdown.yml
badd +73 ~/GitHub/development/bayesplay/tests/R/extract_functions.R
badd +228 ~/GitHub/development/bayesplay/tests/R/helper_functions.R
badd +103 ~/GitHub/development/bayesplay/tests/R/classes.r
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=tTflxcnioOFI
let &winminheight = s:save_winminheight
let &winminwidth = s:save_winminwidth
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
set hlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
