--[[ local keymap_wk = function(mode, map, action, desc)
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
]]
local bufnr = vim.api.nvim_get_current_buf()
vim.keymap.set(
  "n",
  "<leader>a",
  function()
    vim.cmd.RustLsp('codeAction') -- supports rust-analyzer's grouping
    -- or vim.lsp.buf.codeAction() if you don't want grouping.
  end,
  { silent = true, buffer = bufnr }
)
