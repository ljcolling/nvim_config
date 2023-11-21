vim.cmd([[
    set tw=80 fo=cqt wm=0  
    highlight OverLength guibg=#45475A guifg=lightgrey
    match OverLength /\%84v.*/
    setlocal spell
    set spelllang=en_gb
]])

local keymap_wk = function(mode, map, action, desc)
  map = "<leader>" .. map
  local opts = { noremap = true, silent = true, desc = desc }
  vim.api.nvim_set_keymap(mode, map, action, opts)
end

keymap_wk(
"v",
"/",
":lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
"Commment toggle linewise (visual)")


vim.cmd([[
  "" command! Say :%! pandoc --from=markdown --to=plain | say
  command! Unwrap :%! pandoc --from=markdown --to=markdown --wrap=none

  "" see http://andreasmhallberg.github.io/text-to-speech-in-vim/
 function! TTS()
  " call system('osascript ~/killspot.scpt')
  call system('echo '. shellescape(@x) .' | pandoc --from=latex --to=plain | say -v daniel -r 240 &') 
  nnoremap <buffer><silent> <esc> :call system('killall say')<CR>
endfunction

  vnoremap <silent> s "xy:call TTS()<cr>

  nnoremap <silent><leader><leader>s vip "xy:call TTS()<cr>
]])
