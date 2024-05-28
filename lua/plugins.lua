-- install lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
print(lazypath)
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "

require("lazy").setup({
  {
  'stevearc/overseer.nvim',
  opts = {},
    config = function()
      require('overseer').setup()
    end
},
  {"SeniorMars/typst.nvim"},
  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup()
    end,
    event = { "CmdlineEnter" },
    ft = { "go", 'gomod' },
    build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
  },

  {
    "nvim-pack/nvim-spectre",
    setup = true
  },

  -- Lua
  {
    "folke/zen-mode.nvim",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },
  --[[
  'ray-x/guihua.lua',

  {
    "ray-x/navigator.lua",

    config = function()
      require("navigator").setup()
    end,

  },
  ]]


  --[[ https://github.com/ray-x/lsp_signature.nvim ]]
  "ziontee113/neo-minimap",
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {
      modes = {
        search = {
          enabled = false
        }
      }
    },
    keys = {
      { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,     desc = "Toggle Flash Search" },
      { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end, },
      { "S",     mode = { "n", "o", "x" }, function() require("flash").treesitter() end, },
    },
  },
  "https://git.sr.ht/~soywod/himalaya-vim",

  -- wiki stuff
  --
  --[[ { 'jakewvincent/mkdnflow.nvim',  setup = true }, ]]

  -- org mode
  --
  --[[
  {
    'nvim-orgmode/orgmode',
    config = function()
      require('orgmode').setup {}
    end
  },
  ]]

  {
    "chentoast/marks.nvim",
    command = "MarksToggleSigns",
    config = function()
      require("marks").setup()
    end
  },
  -- Debugging
  { "mfussenegger/nvim-dap" },
  { "mfussenegger/nvim-dap-python" },
  { "jay-babu/mason-nvim-dap.nvim" },

  --[[ {
  "nathom/filetype.nvim",
  -- Do not source the default filetype.vim
  config = function()
    vim.g.did_load_filetypes = 1
  end,
}, ]]


  --[[ { 'JASONews/glow-hover' }, ]]

  { "barreiroleo/ltex-extra.nvim" },
  {
    "brymer-meneses/grammar-guard.nvim",
    requires = { "neovim/nvim-lspconfig" }
  },



  {
    "glepnir/lspsaga.nvim",
    event = "LspAttach",
    config = function()
      require("lspsaga").setup({
        lightbulb = {
          enable = true,
          enable_in_insert = false,
          sign = true,
          virtual_text = false
        }
      })
    end,
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      --Please make sure you install markdown and markdown_inline parser
      { "nvim-treesitter/nvim-treesitter" }
    }
  },
  --- lsp saga stuff

  {
    "s1n7ax/nvim-window-picker",
    config = function()
      require('window-picker').setup()
    end
  },

  { "sbdchd/neoformat",             setup = true },


  --- fzf

  {
    'ibhagwan/fzf-lua',
    command = "FzfLua"
  },
  { "debugloop/telescope-undo.nvim" },
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    config = function()
      require("telescope").setup({
        extensions = {
          undo = {
            side_by_side = true,
            layout_strategy = "vertical",
            layout_config = {
              preview_height = 0.8,
            },
          },
        },
      })
      require("telescope").load_extension("fzf")
      require("telescope").load_extension("undo")
      -- require("plugins.telescope").setup()
    end,
    dependencies = { "telescope-fzf-native.nvim" },
    lazy = true,
    cmd = "Telescope",
  },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = true },
  -- Install nvim-cmp, and buffer source as a dependency

  { "nixprime/cpsm" },
  {
    "romgrk/fzy-lua-native",
    build = "make",
  },
  -- { 'gelguy/wilder.nvim' },
  {
    "romgrk/barbar.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    init = function()
      vim.g.barbar_auto_setup = false
    end,
    opts = {
      -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
      -- animation = true,
      -- insert_at_start = true,
      -- …etc.
      highlight_visible = true,
    },
    version = "^1.0.0", -- optional: only update when a new 1.x version is released
  },

  { "LinArcX/telescope-command-palette.nvim" },
  {
    "stevearc/aerial.nvim",
    config = function()
      require('aerial').setup({
        attach_mode = "global",
        --[[ attach_mode = "window", ]]
        autojump = true,
      })
    end,
    cmd = "AerialToggle",
    keys = {
      { "<leader>a", "<cmd>AerialToggle!<cr>", desc = "Aerial Toggle" },
    },
  },

  "iamcco/markdown-preview.nvim",

  {
    "folke/tokyonight.nvim",
    -- lazy = false,    -- make sure we load this during startup if it is your main colorscheme
    -- priority = 1000, -- make sure to load this before all the other start plugins
  },
  {
    "Shatur/neovim-ayu",
    name = "ayu-mirage",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[
      set background=dark
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
      colorscheme ayu-mirage
      ]])
    end
  },
  {
    "catppuccin/nvim",
    --[[ name = "catppuccin", ]]
    --[[ lazy = false, ]]
    --[[ priority = 1000 ]]
  },
  "rose-pine/neovim",
  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup({
        override = {
          zsh = {
            icon = "",
            name = "Zsh",
          },
          qmd = {
            icon = "",
            name = "Quarto",
          },
        },
        default = true,
      })
    end,
  },

  "numToStr/Navigator.nvim",

  --- Telescope stuff
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  },
  ----
  --[[ "numToStr/Comment.nvim", ]]

  --  {"JoosepAlviste/nvim-ts-context-commentstring",
  --   dependencies = { "nvim-treesitter/nvim-treesitter" }
  --  },

  --  {"glepnir/dashboard-nvim",
  --    commit = "e517188dab55493fb9034b4d4f1a508ccacfcd45",
  --    lazy = false
  --  },


  { import = "plugins.neotree" },

  -- { import = "plugins.bufferline" },

  { import = "plugins.dashboard" },
  { import = "plugins.comment" },
  { import = "plugins.indent_blankline" },

  { import = "plugins.virt_column" },
  --[[
	{
		"Wansmer/treesj",
		keys = { "<space>m", "<space>j", "<space>s" },
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("treesj").setup({})
		end,
	},
]]
  {
    "folke/which-key.nvim",
    config = function()
      require("plugins.which_key")
    end,
  },
  {import = "plugins.obsidian"},
  { import = "plugins.lsp" },
  { import = "plugins.dap" },
  { "jose-elias-alvarez/typescript.nvim", setup = true, lazy = false },
  { "lvimuser/lsp-inlayhints.nvim",       setup = true, lazy = false },

  {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    config = function()
      require("plugins.lualine")
    end,
  },

  "folke/neodev.nvim",
  {
    "yorik1984/telescope-cheat.nvim",
    dependencies = {
      "kkharji/sqlite.lua",
      "nvim-telescope/telescope.nvim",
    },
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = true,
    cmd = "ToggleTerm",
  },

  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "markdown", "lua", "rust", "r", "go", "javascript", "bash" },
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        custom_captures = {

          ["foo"] = "string",
        },
        rainbow = { enable = true, extended_mode = true, max_file_lines = nil },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
        },
        indent = {
          enable = true,
        },
      })
    end,
  },
  "nvim-treesitter/playground",
  "nvim-treesitter/nvim-treesitter-context",
  "nvim-telescope/telescope-symbols.nvim",
  { "nvim-telescope/telescope-ui-select.nvim" },
  "theprimeagen/harpoon",
  --[[ "mbbill/undotree", ]]

  "Pocco81/auto-save.nvim",
  -- "stevearc/aerial.nvim",
  --[[ {
    dir = "/Users/lc663/Github/aerial.nvim",
    cmd = "AerialToggle",
    config = true,
  }, ]]

  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
  },

  {
    dir = "~/Github/command-t/",
    init = function()
      vim.g.CommandTPreferredImplementation = "lua"
    end,
    config = function()
      require("wincent.commandt").setup({})
    end,
    build = "cd lua/wincent/commandt/lib && make",
  },
  "folke/trouble.nvim",
  {
    "lewis6991/gitsigns.nvim",
    config = true,
    command = "GitSigns"
  },
  {
    "folke/todo-comments.nvim",
    lazy = false,
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup()
    end,
  },
  "bfredl/nvim-luadev",
  "rafcamlet/nvim-luapad",
  { "nvim-telescope/telescope-github.nvim" },

  {
    "github/copilot.vim",
    lazy = true,
    cmd = "Copilot",
  },

  {
    "folke/noice.nvim",
    enabled = false,
    config = function()
      require("noice").setup({
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = true,         -- use a classic bottom cmdline for search
          command_palette = true,       -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false,           -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false,       -- add a border to hover docs and signature help
        },
      })
    end,
  },
})

-- Treesitter things I'd like to setup
-- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
-- https://github.com/nvim-treesitter/nvim-treesitter-refactor
-- require("telescope").setup({
--   extensions = {
--     ["ui-select"] = {
--       require("telescope.themes").get_dropdown({
--         -- even more opts
--       }),
--     },
--     fzy_native = {
--       override_generic_sorter = false,
--       override_file_sorter = true,
--     },
--     fzf = {
--       fuzzy = true,                       -- false will only do exact matching
--       override_generic_sorter = true,     -- override the generic sorter
--       override_file_sorter = true,        -- override the file sorter
--       case_mode = "smart_case",           -- or "ignore_case" or "respect_case"
--       -- the default case_mode is "smart_case"
--     },
--     command_palette = {
--       {
--         "File",
--         { "entire selection (C-a)",  ':call feedkeys("GVgg")' },
--         { "save current file (C-s)", ":w" },
--         { "save all files (C-A-s)",  ":wa" },
--         { "quit (C-q)",              ":qa" },
--         { "file browser (C-i)",      ":lua require'telescope'.extensions.file_browser.file_browser()", 1 },
--         { "search word (A-w)",       ":lua require('telescope.builtin').live_grep()",                  1 },
--         { "git files (A-f)",         ":lua require('telescope.builtin').git_files()",                  1 },
--         { "files (C-f)",             ":lua require('telescope.builtin').find_files()",                 1 },
--       },
--       {
--         "Help",
--         { "tips",            ":help tips" },
--         { "cheatsheet",      ":help index" },
--         { "tutorial",        ":help tutor" },
--         { "summary",         ":help summary" },
--         { "quick reference", ":help quickref" },
--         { "search help(F1)", ":lua require('telescope.builtin').help_tags()", 1 },
--       },
--       {
--         "Vim",
--         { "reload vimrc",              ":source $MYVIMRC" },
--         { "check health",              ":checkhealth" },
--         { "jumps (Alt-j)",             ":lua require('telescope.builtin').jumplist()" },
--         { "commands",                  ":lua require('telescope.builtin').commands()" },
--         { "command history",           ":lua require('telescope.builtin').command_history()" },
--         { "registers (A-e)",           ":lua require('telescope.builtin').registers()" },
--         { "colorshceme",               ":lua require('telescope.builtin').colorscheme()",    1 },
--         { "vim options",               ":lua require('telescope.builtin').vim_options()" },
--         { "keymaps",                   ":lua require('telescope.builtin').keymaps()" },
--         { "buffers",                   ":Telescope buffers" },
--         { "search history (C-h)",      ":lua require('telescope.builtin').search_history()" },
--         { "paste mode",                ":set paste!" },
--         { "cursor line",               ":set cursorline!" },
--         { "cursor column",             ":set cursorcolumn!" },
--         { "spell checker",             ":set spell!" },
--         { "relative number",           ":set relativenumber!" },
--         { "search highlighting (F12)", ":set hlsearch!" },
--       },
--     },
--   },
-- })
--
-- -- require("telescope").load_extension("fzy_native")
-- require("telescope").load_extension("file_browser")
-- require("telescope").load_extension("fzf")
-- require("telescope").load_extension("command_palette")
-- require("telescope").load_extension("aerial")
--
-- require("telescope").load_extension("gh")
-- require("telescope").load_extension("cheat")
-- require("telescope").load_extension("ui-select")
--
-- init.lua

-- Load custom treesitter grammar for org filetype
-- require('orgmode').setup_ts_grammar()
--
-- -- Treesitter configuration
-- require('nvim-treesitter.configs').setup {
--   -- If TS highlights are not enabled at all, or disabled via `disable` prop,
--   -- highlighting will fallback to default Vim syntax highlighting
--   highlight = {
--     enable = true,
--     -- Required for spellcheck, some LaTex highlights and
--     -- code block highlights that do not have ts grammar
--     additional_vim_regex_highlighting = {'org'},
--   },
--   ensure_installed = {'org'}, -- Or run :TSUpdate org
-- }
--
-- require('orgmode').setup({
--   org_agenda_files = {'~/Github/org/*'},
--   org_default_notes_file = '~/Github/org/refile.org',
-- })
