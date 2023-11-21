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


