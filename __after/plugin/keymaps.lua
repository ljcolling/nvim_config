
-- Better window navigation
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
local term = os.getenv("TERM")
if term == "xterm-kitty" then
-- Kitty version
  keymap("n", "<C-h>", ":KittyNavigateLeft<CR>", opts)
  keymap("n", "<C-l>", ":KittyNavigateRight<CR>", opts)
  keymap("n", "<C-k>", ":KittyNavigateUp<CR>", opts)
  keymap("n", "<C-j>", ":KittyNavigateDown<CR>", opts)
else
-- Wezterm version
  require('Navigator').setup()
  keymap('n', '<C-h>', '<CMD>NavigatorLeft<CR>' ,opts)
  keymap('n', '<C-l>', '<CMD>NavigatorRight<CR>',opts)
  keymap('n', '<C-k>', '<CMD>NavigatorUp<CR>'   ,opts)
  keymap('n', '<C-j>', '<CMD>NavigatorDown<CR>' ,opts)
end


