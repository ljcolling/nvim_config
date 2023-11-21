local which_key = require('which-key')

-- which_key.setup {}



local opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}


local mappings = {
  g = {
    name = "Goto"
  },
   l = {
    name = "LSP",
  },
  s = { name = "Search",
  }
}
which_key.register(mappings, opts)
