local function read_file()
  local path = "/Users/lc663/.config/colourmode"
  local file = io.open(path, 'r')
  if not file then
    print("missing")
    return nil
  end
  local content = file:read("a")
  file:close()
  return content
end

local colorscheme = tostring(read_file())

if string.find(colorscheme, "light") == nil then
  --[[ require("rose-pine").setup({dark_variant = "moon" }) ]]

  vim.cmd([[
   set background=dark
   colorscheme ayu-mirage
   " colorscheme tokyonight-night
  " colorscheme catppuccin-mocha
   " --- set additional color options
   highlight CursorLineNR gui=bold guifg=grey90
   highlight LineNr guifg=grey
   highlight VirtColumn guifg=white
   highlight comment gui=italic guifg=grey80
   " colorscheme rose-pine-moon
   " colorscheme oxocarbon
   " colorscheme spaceduck
   " colorscheme tokyonight-moon
  ]])
  --[[ require('vn-night').setup() ]]
  --[[ require('lualine').setup {options = {theme = 'vn-night'}} ]]
  --[[ require('onedark').setup({style = 'Deep'}) ]]
else
  vim.cmd([[
    set background=light
    colorscheme ayu
    " colorscheme tokyonight
    " colorscheme catppuccin-latte

    " --- set additional color options
    highlight CursorLineNR gui=bold guifg=black
    highlight LineNr guifg=grey40
    highlight VirtColumn guifg=black
    highlight comment gui=italic guifg=grey20

    ]])
end
