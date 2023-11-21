set laststatus=3
" set winbar=%m\ %F
nnoremap <silent>Q gqap
set guifont=Liga\ SFMono\ Nerd\ Font

nmap z= :Telescope spell_suggest<cr>

let g:slime_target = "kitty"

let g:slime_no_mappings = 1

let g:vim_markdown_fenced_languages = ['javascript=ojs', 'r']

highlight TSStrong gui=bold cterm=bold  guifg=#808080
highlight TSEmphasis gui=italic cterm=italic guifg=#808080

highlight TSTextReference gui=underline cterm=underline
" highlight confComment gui=italic cterm=italic guifg=grey
highlight Folded gui=italic guifg=#grey guibg=#1d446f

highlight comment gui=italic guifg=grey60

highlight SpellBad gui=underline guifg=red
highlight CursorLineNR gui=bold guifg=grey90
highlight LineNr guifg=grey
highlight VirtColumn guifg=grey70
set modeline

let g:neovide_cursor_vfx_mode=""
let g:neovide_cursor_animation_length=0
let g:neovide_fullscreen=0
set cc=80
