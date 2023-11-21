--[[
  require("indent_blankline").setup({
    -- for example, context is off by default, use this to turn it on
    show_current_context = true,
    show_current_context_start = true,
    show_end_of_line = true,
  })
]]

vim.opt.termguicolors = true
vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]

vim.opt.list = true
vim.opt.listchars:append "space:·"
vim.opt.listchars:append "eol: "
vim.opt.listchars:append "tab:▸ "
vim.opt.listchars:append "trail:·"
vim.opt.listchars:append "extends:❯"
vim.opt.listchars:append "precedes:❮"
vim.opt.listchars:append "nbsp:␣"
vim.opt.listchars:append "conceal:▤"
--[[ vim.opt.listchars:append "space: " ]]
--[[ vim.opt.listchars:append "eol: " ]]

require("indent_blankline").setup {
  show_current_context = true,
  show_current_context_start = true,
  show_end_of_line = false,
  show_first_indent_level = true,
  show_trailing_blankline_indent = true,
  char_highlight_list = {
    "IndentBlanklineIndent1",
    "IndentBlanklineIndent2",
    "IndentBlanklineIndent3",
    "IndentBlanklineIndent4",
    "IndentBlanklineIndent5",
    "IndentBlanklineIndent6",
  },
}
