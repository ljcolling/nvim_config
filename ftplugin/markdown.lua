---@diagnostic disable: unused-local, param-type-mismatch
vim.cmd([[
    set tw=80 fo=cqt wm=0  
    highlight OverLength guibg=#45475A guifg=lightgrey
    match OverLength /\%84v.*/
    setlocal spell
    set spelllang=en_gb
    " -- don't need this if I'm using markdown_inline treesitter grammar
    " -- I think this is a bit slower than using the inbuilt
    augroup markdown
        autocmd!
        " autocmd BufNewFile,BufRead *.qmd set syntax=markdown
        " autocmd BufNewFile,BufRead *.qmd set ft=markdown
        " autocmd BufNewFile,BufRead *.qmd set conceallevel=0
        lua require('cmp').setup.buffer { enabled = false }
    augroup END

    nnoremap <silent> <leader><leader><cr> :Handout<cr>
    set foldmarker=```{,```
    set foldmethod=marker
]])


vim.cmd([[

  command! Say :%! pandoc --from=markdown --to=plain | say
  command! Unwrap :%! pandoc --from=markdown --to=markdown --wrap=none

  "" see http://andreasmhallberg.github.io/text-to-speech-in-vim/
 function! TTS()
  " call system('osascript ~/killspot.scpt')
  call system('echo '. shellescape(@x) .' | pandoc --from=markdown --to=plain | say -v daniel -r 200 &') 
  nnoremap <buffer><silent> <esc> :call system('killall say')<CR>
endfunction

  vnoremap <silent><leader>s "xy:call TTS()<cr>

  nnoremap <silent><leader><leader>s vip "xy:call TTS()<cr>

"" this will need to be modified to match the ergonomics of 
"" VimSlime better
function! SendToWezterm()
  call system('echo '. shellescape(@x) .' | wezterm cli send-text --pane-id 0 --no-paste')
endfunction

vnoremap <silent> <CR> "xy:call SendToWezterm()<cr>
" '<,'>system('echo '. shellescape(@x) .' | wezterm cli send-text --pane-id 0 --no-paste')
]])




vim.api.nvim_create_user_command("Render", function(opts)
  -- vim.api.nvim_buf_set_lines(tonumber(vim.g.target), 0, -1, false, {"Rendering..."})

  local project = opts.args == 'project'
  local filename
  if project == false then
    vim.notify("rendering the file")
    local Path = require "plenary.path"
    local thisfile = Path:new { vim.api.nvim_buf_get_name(0) }

    local folder = thisfile:parent()
    filename = folder .. '/index.qmd'
  else
    vim.notify("rendering the project")
    filename = ''
  end
  ---@diagnostic disable-next-line: unused-function
  local append_data = function(_, data)
    if data then
      print("appending to " .. vim.g.target)
      vim.api.nvim_buf_set_lines(tonumber(vim.g.target), -1, -1, false,
        data)
    end
  end

  local sayok = function(_, data)
    if data then
      print(data[1])
    end
  end

  vim.api.nvim_command("silent! write") -- first write the current buffer

  --[[ vim.fn.jobstart({ "success", "quarto", "render", filename }, { ]]
  vim.fn.jobstart({ "success", "rmarkdown", filename }, {
    stdout_buffered = true,
    on_stdout = sayok,
    on_stderr = sayok
  })

  --[[ vim.fn.jobstart({"kitty", "@", "send-text", "--match", "id:51", "'pdf index.pdf\n'"},{ ]]
  --[[   stdout_buffered = false, ]]
  --[[ }) ]]

end, {
  nargs = '?',
  complete = function(ArgLead, CmdLind, CursorPos)
    return { 'file', 'project' }
  end
})


vim.api.nvim_create_user_command("Slides", function(opts)
  -- vim.api.nvim_buf_set_lines(tonumber(vim.g.target), 0, -1, false, {"Rendering..."})

  local project = opts.args == 'project'
  local filename
  if project == false then
    vim.notify("rendering the file")
    local Path = require "plenary.path"
    local thisfile = Path:new { vim.api.nvim_buf_get_name(0) }

    local folder = thisfile:parent()
    filename = folder .. '/index.qmd'
  else
    vim.notify("rendering the project")
    filename = ''
  end
  ---@diagnostic disable-next-line: unused-function
  local append_data = function(_, data)
    if data then
      print("appending to " .. vim.g.target)
---@diagnostic disable-next-line: param-type-mismatch
      vim.api.nvim_buf_set_lines(tonumber(vim.g.target), -1, -1, false,
        data)
    end
  end

  local sayok = function(_, data)
    if data then
      print(data[1])
    end
  end

  vim.api.nvim_command("silent! write") -- first write the current buffer

  vim.fn.jobstart({ "success", "quarto", "render", filename, "--to=sussex-revealjs"}, {
  --[[ vim.fn.jobstart({ "success", "quarto", "render", filename, "--to=revealjs" }, { ]]
    -- vim.fn.jobstart({ "./render.sh" }, {
    stdout_buffered = true,
    on_stdout = sayok,
    on_stderr = sayok
  })

end, {
  nargs = '?',
  complete = function(ArgLead, CmdLind, CursorPos)
    return { 'file', 'project' }
  end
})



vim.api.nvim_create_user_command("Handout", function(opts)
  -- vim.api.nvim_buf_set_lines(tonumber(vim.g.target), 0, -1, false, {"Rendering..."})

  local project = opts.args == 'project'
  local filename
  if project == false then
    vim.notify("rendering the file")
    local Path = require "plenary.path"
    local thisfile = Path:new { vim.api.nvim_buf_get_name(0) }

    local folder = thisfile:parent()
    filename = folder .. '/index.qmd'
  else
    vim.notify("rendering the project")
    filename = ''
  end
  ---@diagnostic disable-next-line: unused-function
  local append_data = function(_, data)
    if data then
      print("appending to " .. vim.g.target)
---@diagnostic disable-next-line: param-type-mismatch
      vim.api.nvim_buf_set_lines(tonumber(vim.g.target), -1, -1, false,
        data)
    end
  end

  local sayok = function(_, data)
    if data then
      print(data[1])
    end
  end

  vim.api.nvim_command("silent! write") -- first write the current buffer

  vim.fn.jobstart({ "success", "quarto", "render", filename, "--to=html" }, {
    --[[ vim.fn.jobstart({ "success", "quarto", "render", filename, "--to=revealjs" }, { ]]
    -- vim.fn.jobstart({ "./render.sh" }, {
    stdout_buffered = true,
    on_stdout = sayok,
    on_stderr = sayok
  })

end, {
  nargs = '?',
  complete = function(ArgLead, CmdLind, CursorPos)
    return { 'file', 'project' }
  end
})
