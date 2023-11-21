local keymap_wk = function(mode, map, action, desc)
  map = "<leader>" .. map
  local opts = { noremap = true, silent = true, desc = desc }
  vim.api.nvim_set_keymap(mode, map, action, opts)
end

local keymap = function(mode, map, action, desc)
  local opts = { noremap = true, silent = true, desc = desc }
  vim.api.nvim_set_keymap(mode, map, action, opts)
end

keymap_wk("n", "la", "<cmd>RustCodeAction<CR>", "Code Action<CR>")

keymap("n", "K", "<cmd>RustHoverActions<cr>", "Hover docs")
