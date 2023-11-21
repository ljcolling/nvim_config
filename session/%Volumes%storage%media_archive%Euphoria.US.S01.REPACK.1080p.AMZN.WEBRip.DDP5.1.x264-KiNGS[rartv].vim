let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd /Volumes/storage/media_archive/Euphoria.US.S01.REPACK.1080p.AMZN.WEBRip.DDP5.1.x264-KiNGS\[rartv]
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +7 /private/var/folders/bs/g5qjpqs524b1jld5h6gkm0_40000gp/T/.tmpgsUUcs
argglobal
%argdel
$argadd /private/var/folders/bs/g5qjpqs524b1jld5h6gkm0_40000gp/T/.tmpgsUUcs
edit /private/var/folders/bs/g5qjpqs524b1jld5h6gkm0_40000gp/T/.tmpgsUUcs
argglobal
let s:l = 7 - ((6 * winheight(0) + 24) / 49)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 7
normal! 019|
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=txlnfcTFOoiI
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
