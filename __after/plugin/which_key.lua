local which_key = require('which-key')

local setup = {



}

local opts = {
  mode = "v", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  --[[ noremap = true, -- use `noremap` when creating keymaps ]]
  nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
  ["/"] = { "<Plug>(comment_toggle_linewise_visual)", "Comment toggle linewise (visual)" },
}
which_key.setup {}

which_key.register(mappings, opts)

local opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

function _toggle_term()
  require('toggleterm.terminal').Terminal:new(
    {
      env = { TERM_PROGRAM = 'nvim' },
      shading_factor = 1,
      hide_numbers = true,
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 1,
      start_in_insert = true,
      persist_size = true,
      persist_mode = true,
      direction = "float",
      close_on_exit = false,
      shell = vim.o.shell,
    }):toggle()
end

local mappings = {
  ["a"] = { '<cmd>AerialToggle!<CR>', "Aerial" },
  ["/"] = { "<Plug>(comment_toggle_linewise_current)", "Comment toggle current line" },
  ["b"] = { ":Bufs<CR>", "Buffers" },
  ["T"] = { "<cmd>lua _toggle_term()<CR>", "Terminal" },
  ["t"] = { "<cmd>ToggleTerm<CR>", "Terminal" },
  g = {
    name = "Goto",
    d = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Definition" },
    D = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Declaration" },
    i = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Implementation" },
    r = { "<cmd>lua vim.lsp.buf.references()<CR>", "References" },
    s = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature Help" },
    t = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Type Definition" },
  },
  l = {
    name = "LSP",
    a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
    d = { "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>", "Buffer Diagnostics" },
    w = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
    f = { "<cmd>lua vim.lsp.buf.format()<cr>", "Format" },
    i = { "<cmd>LspInfo<cr>", "Info" },
    I = { "<cmd>Mason<cr>", "Mason Info" },
    j = {
      vim.diagnostic.goto_next,
      "Next Diagnostic",
    },
    k = {
      vim.diagnostic.goto_prev,
      "Prev Diagnostic",
    },
    l = { vim.lsp.codelens.run, "CodeLens Action" },
    -- p = {
    --   name = "Peek",
    --   d = { "<cmd>lua require('lvim.lsp.peek').Peek('definition')<cr>", "Definition" },
    --   t = { "<cmd>lua require('lvim.lsp.peek').Peek('typeDefinition')<cr>", "Type Definition" },
    --   i = { "<cmd>lua require('lvim.lsp.peek').Peek('implementation')<cr>", "Implementation" },
    -- },
    q = { vim.diagnostic.setloclist, "Quickfix" },
    r = { vim.lsp.buf.rename, "Rename" },
    s = { "<cmd>SymbolsOutline<cr>", "Symbol outline" },
    S = {
      "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
      "Workspace Symbols",
    },
    e = { "<cmd>Telescope quickfix<cr>", "Telescope Quickfix" },
  },
  s = { name = "Search",
    f = { "<cmd>Telescope find_files<cr>", "File" },
    s = { "<cmd>Telescope spell_suggest<cr>", "Spelling" },
    t = { "<cmd>Telescope live_grep<cr>", "Text" },
    c = {
      "<cmd>lua require('telescope.builtin').colorscheme({enable_preview = true})<cr>",
      "Colorscheme with Preview",
    },
    S = { "<cmd>Telescope treesitter<cr>", "Treesitter symbols" }
  }
}
which_key.register(mappings, opts)
