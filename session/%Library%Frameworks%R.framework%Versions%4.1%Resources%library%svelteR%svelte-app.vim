let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/GitHub/learning/svelte/svelte-app
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
argglobal
%argdel
$argadd ~/GitHub/learning/svelte/index.Rmd
tabnext 1
badd +14 ~/GitHub/learning/svelte/index.Rmd
badd +2 docs/index.html
badd +7 src/App.svelte
badd +1 rollup.config.js
badd +12 src/main.js
badd +59 /Library/Frameworks/R.framework/Versions/4.1/Resources/library/svelteR/svelte-app/README.md
badd +1 /Library/Frameworks/R.framework/Versions/4.1/Resources/library/svelteR/svelte-app/docs/index.html
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=TiFxftOconlI
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
