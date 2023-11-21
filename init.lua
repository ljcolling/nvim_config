--[[
  TODO:
  Move DAP stuff to it's own file
  Move LSP stuff to LSP
  General neovim options
  https://github.com/b0o/schemastore.nvim
  Fix autocomplete

  ./lua/colorscheme.lua
  ./lui/plugins_old.lua
  ./lua/plugins.lua
  ./lua/plugins/lsp.lua
  ./lua/keymaps.lua
  ./after/plugin/which_key.lua
  ./lua/plugins/which_key.lua
  ./after/plugin/indent_blankline.lua
  ./lua/autocommands.lua
  ./lua/usercommands.lua
  ./lua/test.lua
  ./lua/plugins/lsp.lua
  ./after/plugin/telescope.lua
  ./lua/plugins/dashboard.lua
]]

require("plugins")
require("colorscheme")
require("usercommands")
require("autocommands")
require("edit_code")
require("keymaps")
require("options")
--[[ require("lsp") ]]




local opts = { noremap = true, silent = true }


local vim = _G.vim
local keymap = vim.api.nvim_set_keymap
local diagnostic = vim.diagnostic
local cmd = vim.cmd





-- Turn off all virtual text
diagnostic.config({ virtual_lines = false })
diagnostic.config({ virtual_text = false })
diagnostic.config({ hover = true })
-- Tidy up all this DAP and rust stuff
--
cmd.source("$HOME/.config/nvim/settings.vim")


-- Better window navigation

-- Somewhere here I need to check whether I'm in TMUX
-- TODO: But I'll also need to install the better TMUX navigation
-- And I'll need to install vim-slime to send to tmux

local term = os.getenv("TERM")
if term == "xterm-kitty" then
  -- Kitty version
  keymap("n", "<C-h>", ":KittyNavigateLeft<CR>", opts)
  keymap("n", "<C-l>", ":KittyNavigateRight<CR>", opts)
  keymap("n", "<C-k>", ":KittyNavigateUp<CR>", opts)
  keymap("n", "<C-j>", ":KittyNavigateDown<CR>", opts)
elseif os.getenv("TERM_PROGRAM") == "WezTerm" then
  -- Wezterm version
  require('Navigator').setup()
  keymap('n', '<C-h>', '<CMD>NavigatorLeft<CR>', opts)
  keymap('n', '<C-l>', '<CMD>NavigatorRight<CR>', opts)
  keymap('n', '<C-k>', '<CMD>NavigatorUp<CR>', opts)
  keymap('n', '<C-j>', '<CMD>NavigatorDown<CR>', opts)
elseif os.getenv("TERM_PROGRAM") == "ALACRITTY" then
  keymap('n', '<C-h>', '<C-w>h', opts)
  keymap('n', '<C-l>', '<C-w>l', opts)
  keymap('n', '<C-k>', '<C-w>k', opts)
  keymap('n', '<C-j>', '<C-w>j', opts)
end



-- set last status
vim.o.laststatus = 3

cmd([[
  set rtp+=/usr/local/opt/fzf
  let g:go_fmt_autosave = 0

]])

function _G.set_terminal_keymaps()
  local term_opts = { buffer = 0 }
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], term_opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], term_opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], term_opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], term_opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], term_opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], term_opts)
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], term_opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

cmd([[
  ""autocommand to disable co-pilot
  ""autocmd BufEnter * let g:copilot#enabled = 0
  ""autocmd! WinEnter * set relativenumber
  ""autocmd! WinLeave * set norelativenumber

  ""autocmd! WinEnter term://* set norelativenumber
]])


require("lsp-inlayhints").setup()
vim.api.nvim_set_hl(0, "foo", { link = "Identifier" })
vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
vim.api.nvim_create_autocmd("LspAttach", {
  group = "LspAttach_inlayhints",
  callback = function(args)
    if not (args.data and args.data.client_id) then
      return
    end

    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    require("lsp-inlayhints").on_attach(client, bufnr)
  end,
})

--[[
  require'glow-hover'.setup {
      -- The followings are the default values
      max_width = 50,
      padding = 10,
      border = 'shadow',
      glow_path = '/usr/local/bin/glow'
  }
]]

local navbuddy = require("nvim-navbuddy")
local actions = require("nvim-navbuddy.actions")

navbuddy.setup {
  window = {
    border = "single",     -- "rounded", "double", "solid", "none"
    -- or an array with eight chars building up the border in a clockwise fashion
    -- starting with the top-left corner. eg: { "╔", "═" ,"╗", "║", "╝", "═", "╚", "║" }.
    size = "80%",         -- Or table format example: { height = "40%", width = "100%"}
    position = "70%",     -- Or table format example: { row = "100%", col = "0%"}
    scrolloff = nil,      -- scrolloff value within navbuddy window
    sections = {
      left = {
        size = "40%",
        border = nil,         -- You can set border style for each section individually as well.
      },
      mid = {
        size = "40%",
        border = nil,
      },
      right = {
        -- No size option for right most section. It fills to
        -- remaining area.
        border = nil,
        preview = "leaf",         -- Right section can show previews too.
        -- Options: "leaf", "always" or "never"
      }
    },
  },
  node_markers = {
    enabled = true,
    icons = {
      leaf = "  ",
      leaf_selected = " → ",
      branch = " ",
    },
  },
  icons = {
    File          = "󰈙 ",
    Module        = " ",
    Namespace     = "󰌗 ",
    Package       = " ",
    Class         = "󰌗 ",
    Method        = "󰆧 ",
    Property      = " ",
    Field         = " ",
    Constructor   = " ",
    Enum          = "󰕘",
    Interface     = "󰕘",
    Function      = "󰊕 ",
    Variable      = "󰆧 ",
    Constant      = "󰏿 ",
    String        = " ",
    Number        = "󰎠 ",
    Boolean       = "◩ ",
    Array         = "󰅪 ",
    Object        = "󰅩 ",
    Key           = "󰌋 ",
    Null          = "󰟢 ",
    EnumMember    = " ",
    Struct        = "󰌗 ",
    Event         = " ",
    Operator      = "󰆕 ",
    TypeParameter = "󰊄 ",
  },
  use_default_mappings = true,   -- If set to false, only mappings set
  -- by user are set. Else default
  -- mappings are used for keys
  -- that are not set by user
  mappings = {
    ["<esc>"] = actions.close(),     -- Close and cursor to original location
    ["q"] = actions.close(),

    ["j"] = actions.next_sibling(),         -- down
    ["k"] = actions.previous_sibling(),     -- up

    ["h"] = actions.parent(),               -- Move to left panel
    ["l"] = actions.children(),             -- Move to right panel
    ["0"] = actions.root(),                 -- Move to first panel

    ["v"] = actions.visual_name(),          -- Visual selection of name
    ["V"] = actions.visual_scope(),         -- Visual selection of scope

    ["y"] = actions.yank_name(),            -- Yank the name to system clipboard "+
    ["Y"] = actions.yank_scope(),           -- Yank the scope to system clipboard "+

    ["i"] = actions.insert_name(),          -- Insert at start of name
    ["I"] = actions.insert_scope(),         -- Insert at start of scope

    ["a"] = actions.append_name(),          -- Insert at end of name
    ["A"] = actions.append_scope(),         -- Insert at end of scope

    ["r"] = actions.rename(),               -- Rename currently focused symbol

    ["d"] = actions.delete(),               -- Delete scope

    ["f"] = actions.fold_create(),          -- Create fold of current scope
    ["F"] = actions.fold_delete(),          -- Delete fold of current scope

    ["c"] = actions.comment(),              -- Comment out current scope

    ["<enter>"] = actions.select(),         -- Goto selected symbol
    ["o"] = actions.select(),

    ["J"] = actions.move_down(),     -- Move focused node down
    ["K"] = actions.move_up(),       -- Move focused node up

    ["t"] = actions.telescope({      -- Fuzzy finder at current level.
      layout_config = {              -- All options that can be
        height = 0.60,               -- passed to telescope.nvim's
        width = 0.60,                -- default can be passed here.
        prompt_position = "top",
        preview_width = 0.50
      },
      layout_strategy = "horizontal"
    }),

    ["g?"] = actions.help(),     -- Open mappings help window
  },
  lsp = {
    auto_attach = true,     -- If set to true, you don't need to manually use attach function
    preference = nil,       -- list of lsp server names in order of preference
  },
  source_buffer = {
    follow_node = true,     -- Keep the current node in focus on the source buffer
    highlight = true,       -- Highlight the currently focused node
    reorient = "smart",     -- "smart", "top", "mid" or "none"
    scrolloff = nil         -- scrolloff value when navbuddy is open
  }
}



require("mason").setup()
require("mason-nvim-dap").setup()

--[[ -- In init.lua or filetype.nvim's config file
require("filetype").setup({
    overrides = {
        extensions = {
            -- Set the filetype of *.pn files to potion
            qmd = "markdown",
            tex = "tex",
            r = "r"
        },
    },
})
]]
vim.cmd([[
" set background=dark
" colorscheme ayu-mirage
" colorscheme ayu-light
" colorscheme tokyonight-night
" colorscheme catppuccin-mocha
" --- set additional color options
" highlight CursorLineNR gui=bold guifg=grey90
highlight LineNr guifg=grey60
highlight VirtColumn guifg=white
highlight comment gui=italic guifg=grey60
" colorscheme rose-pine-moon
" colorscheme oxocarbon
" colorscheme spaceduck
]])

--[[ https://github.com/roobert/tailwindcss-colorizer-cmp.nvim ]]
--[[ https://github.com/windwp/nvim-ts-autotag ]]
--[[ https://github.com/windwp/nvim-autopairs ]]
--
local nm = require("neo-minimap")
local nm = require("neo-minimap")

nm.setup_defaults({
  -- height_toggle = { 12, 25 },
  height_toggle = { 20, 25 },
  hl_group = "DiagnosticWarn",
})

-- Rust

nm.set({ "zi", "zo" }, "*.rs", {
  events = { "BufEnter" },
  query = {
    [[
        ;; query
(enum_item (type_identifier) @cap)
(trait_item (type_identifier) @cap)
(struct_item (type_identifier) @cap)
;; (impl_item (type_identifier) @cap)
((impl_item) @cap)
(function_item (identifier) @cap)
(mod_item (identifier) @cap)
(macro_definition (identifier) @cap)
        ]],
    1,
  },
  regex = {},
  search_patterns = {
    { "impl", "<C-j>", true },
    { "impl", "<C-k>", false },
    { "mod",  "<C-l>", false },
  },
  height_toggle = { 20, 25 },
})

-- Latex

nm.set({ "zo", "zu" }, "*.tex", {
  events = { "BufEnter" },
  query = {},
  regex = {
    { [[\\section]],  [[\\subsection]], [[\\subsubsection]] },
    { [[\\begin{.*}]] },
  },
})

-- Lua
nm.set({ "zi", "zo", "zu" }, "*.lua", {
  events = { "BufEnter" },

  query = {
    [[
    ;; query
    ;; ((function_declaration name: ((identifier) @name (#eq? @name "{cursorword}"))) @cap)
    ;; ((function_call name: ((identifier) @name (#eq? @name "{cursorword}"))) @cap)
    ;; ((dot_index_expression field: ((identifier) @name (#eq? @name "{cursorword}"))) @cap)
    ((function_declaration) @cap)
    ((assignment_statement(expression_list((function_definition) @cap))))
    ]],
    1,
    [[
    ;; query
    ((function_declaration) @cap)
    ((assignment_statement(expression_list((function_definition) @cap))))
    ((field (identifier) @cap) (#eq? @cap "keymaps"))
    ]],
    [[
    ;; query
    ((for_statement) @cap)
    ((function_declaration) @cap)
    ((assignment_statement(expression_list((function_definition) @cap))))

    ((function_call (identifier)) @cap (#vim-match? @cap "^__*" ))
    ((function_call (dot_index_expression) @field (#eq? @field "vim.keymap.set")) @cap)
    ]],
    [[
    ;; query
    ((for_statement) @cap)
    ((function_declaration) @cap)
    ((assignment_statement(expression_list((function_definition) @cap))))
    ]],
  },

  regex = {
    {},
    { [[^\s*---*\s\+\w\+]], [[--\s*=]] },
    { [[^\s*---*\s\+\w\+]], [[--\s*=]] },
    {},
  },

  search_patterns = {
    { "function", "<C-j>", true },
    { "function", "<C-k>", false },
    { "keymap",   "<A-j>", true },
    { "keymap",   "<A-k>", false },
  },

  -- auto_jump = false,
  -- open_win_opts = { border = "double" },
  win_opts = { scrolloff = 1 },

  disable_indentaion = true,
})

-- Typescript React
nm.set("zi", { "typescriptreact", "javascriptreact" }, {
  query = [[
;; query
((function_declaration) @cap)
((arrow_function) @cap)
((identifier) @cap (#vim-match? @cap "^use.*"))
  ]],
})
