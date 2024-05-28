return {
  "VonHeikemen/lsp-zero.nvim",
  event = { "BufReadPre", "BufNewFile" },
  lazy = false,
  dependencies = {
    -- LSP Support
    { "neovim/nvim-lspconfig" },
    { "nvimtools/none-ls.nvim" },
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    { "jay-babu/mason-null-ls.nvim" },
    -- Autocompletion
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "saadparwaiz1/cmp_luasnip" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-nvim-lua" },
    --[[ { 'hrsh7th/cmp-calc' }, ]]
    --[[ { 'hrsh7th/cmp-emoji' }, ]]
    --[[ { 'hrsh7th/cmp-vsnip' }, ]]
    --[[ { 'hrsh7th/vim-vsnip' }, ]]
    --[[ { 'hrsh7th/vim-vsnip-integ' }, ]]
    { "kdheepak/cmp-latex-symbols" },
    { 'saecki/crates.nvim' },
    -- Snippets
    { "L3MON4D3/LuaSnip" },
    { "rafamadriz/friendly-snippets" },
    -- { "simrat39/rust-tools.nvim" },
    { "mrcjkb/rustaceanvim", ft={'rust'}},
    { "SmiteshP/nvim-navbuddy" },
    { "SmiteshP/nvim-navic" },
    { "MunifTanjim/nui.nvim" },
    --[[ {"zbirenbaum/copilot.lua"},
    {"zbirenbaum/copilot-cmp"} ]]

  },
  config = function()


    vim.g.rustaceanvim = {
      inlay_hints = {
        highlight = "NonText",
      },
      tools = {
        hover_actions = {
          auto_focus = true,
        },
      },
      server = {
        on_attach = function(client, bufnr)
          require("lsp-inlayhints").on_attach(client, bufnr)
        end
      }
    }






    local lsp = require("lsp-zero")
    lsp.preset("recommended")

    lsp.set_preferences({
      set_lsp_keymaps = false,
    })

    lsp.ensure_installed({
      --[[ "tsserver", ]]
      --[[ "eslint", ]]
      --[[ 'sumneko_lua', ]]
      --[[ "rust_analyzer", ]]
      "r_language_server",
      "pyright",
      --[[ "pylyzer", ]]
      "bashls",
      "gopls",
      "jsonls",
      "cssls",
      "html",
      "vimls",
      "yamlls",
      "dockerls",
      "cmake",
      "clangd",
      "texlab",
    })


    -- Skip rust-analyzer because it's managed by rust-tools.nvim
    lsp.skip_server_setup({ "rust_analyzer" })
    lsp.skip_server_setup({ "tsserver" })

    local cmp = require("cmp")
    local cmp_select = { behavior = cmp.SelectBehavior.Select }
    local cmp_mappings = lsp.defaults.cmp_mappings({
      ["<C-k>"] = cmp.mapping.select_prev_item(cmp_select),
      ["<C-j>"] = cmp.mapping.select_next_item(cmp_select),
      ["<CR>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = false
      }),
      ["<C-e>"] = cmp.mapping.abort(),
      ["<C-Space>"] = cmp.mapping.complete(),
    })

  --[[ local navbuddy = require("nvim-navbuddy") ]]
    -- disable completion with tab
    -- this helps with copilot setup
    cmp_mappings["<Tab>"] = nil
    cmp_mappings["<S-Tab>"] = nil
    --[[ cmp_mappings['<CR>'] = nil ]]
    -- set up additional sources
    -- https://github.com/VonHeikemen/lsp-zero.nvim/blob/main/advance-usage.md#setting-up-sources

    --- change this code here to use vim.api.nvim_set_keymap
    -- with my description of the keymap function
    lsp.on_attach(function(client, bufnr)
      --[[ local navbuddy = require("nvim-navbuddy") ]]
      --[[ local opts = {buffer = bufnr, remap = true} ]]
      -- local noremap = { buffer = bufnr, remap = false }
      -- local opts = { buffer = bufnr, remap = true }
      -- local bind = vim.keymap.set
      --[[ bind('n', '<C-k>', '<C-w>k', noremap) ]]
      -- default keybindings
      -- https://github.com/VonHeikemen/lsp-zero.nvim#default-keybindings-1
      --[[ vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
			vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
			vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
			vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
			vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
			vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
			vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, opts)
			vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, opts)
			vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, opts)
			vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts) ]]
    end)



    -- FIXME: Probably still need to sort out some co-pilot stuff

    -- copilot
    --[[ require('copilot').setup({
      suggestion = {enabled = false},
      panel = {enabled = false},
    })
    require('copilot_cmp').setup() ]]

    -- add latex symbols to completion
    local cmp_sources = lsp.defaults.cmp_sources()

    local cmp_action = lsp.cmp_action()

    require('luasnip.loaders.from_vscode').lazy_load()

    table.insert(cmp_sources,
      { name = 'latex_symbols' }
    )

    --[[ table.insert(cmp_sources,
      { name = 'nvim_lsp' }
    ) ]]

    table.insert(cmp_sources,
      { name = 'luasnip' }
    )

    table.insert(cmp_sources,
      { name = "crates" }
    )

    --- NOTE: temporarily removed
    --[[ table.insert(cmp_sources, {name = "copilot"}) ]]







    --[[ cmp_mappings["<Tab>"] = cmp_action.luasnip_jump_forward()
    cmp_mappings["<S-Tab>"] = cmp_action.luasnip_jump_backward() ]]
    -- Fix Undefined global 'vim'

    --[[ lsp.configure("lua_ls", {
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
				},
			},
		}) ]]
    --[[ lsp.configure("lua_ls", {
        settings = {
        Lua = {
                diagnostics = {
                    globals = { 'vim' }
                }

        }
        }
    }) ]]
    lsp.setup_nvim_cmp({
      sources = cmp_sources,
      mapping = cmp_mappings,
      preselect = "none",
      completion = {
        completeopt = "menu,menuone,noinsert,noselect",
      },
    })
    require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

    -- setup up inlay hints for typescript
    require('lspconfig').tsserver.setup({
      settings = {
        typescript = {
          inlayHints = {
            includeInlayParameterNameHints = 'all',
            includeInlayParameterNameHintsWhenArgumentMatchesName = true,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          }
        },
        javascript = {
          inlayHints = {
            includeInlayParameterNameHints = 'all',
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          }
        }
      }
    })

    require("lspconfig").ltex.setup {
      -- capabilities = your_capabilities,
      on_attach = function(client, bufnr)
        -- rest of your on_attach process.
        require("ltex_extra").setup {
          load_langs = { "en-GB" },
          init_check = true,
          path = "~/.config/dictionaries/",
          log_level = "none",
        }
      end,
      settings = {
        ltex = {
          languageToolHttpServerUri = "https://api.languagetoolplus.com",
          languageToolOrg = {
            apiKey = 'pit-gtQy20xbano5',
            username = 'lincoln@colling.net.nz'
          },
          enabled = { "latex", "tex", "bib", "markdown", "pandoc", "quarto" },
          language = "en-GB",
          markdown = {
            nodes = { CodeBlock = "ignore", FencedCodeBlock = "ignore", AutoLink = "dummy", Code = "dummy" }
          },
          diagnosticSeverity = "information",
          setenceCacheSize = 2000,
          additionalRules = {
            enablePickyRules = true,
            motherTongue = "en-GB",
          },
          trace = { server = "verbose" },
          dictionary = {},
          disabledRules = {},
          hiddenFalsePositives = {},
        }
      }
    }

    --     require("grammar-guard").init()
    --     local nvim_lsp = require("lspconfig")
    --     nvim_lsp["grammar_guard"].setup({
    --       cmd = { "/Applications/ltex-ls-16.0.0/bin/ltex-ls" },
    --       --[[ on_attach = function(client, bufnr)
    --         -- your other on_attach functions.
    --         require("ltex_extra").setup {
    --           load_langs = { "en-GB" },   -- table <string> : languages for witch dictionaries will be loaded
    --           init_check = true,          -- boolean : whether to load dictionaries on startup
    --           path = "./",                 -- string : path to store dictionaries. Relative path uses current working directory
    --           log_level = "none",         -- string : "none", "trace", "debug", "info", "warn", "error", "fatal"
    --         }
    --       end, ]]
    --       settings = {
    --         ltex = {
    --           languageToolHttpServerUri = "https://api.languagetoolplus.com",
    --           languageToolOrg = {
    --             apiKey = 'pit-gtQy20xbano5',
    --             username = 'lincoln@colling.net.nz'
    --           },
    --           enabled = { "latex", "tex", "bib", "markdown", "pandoc" },
    --           language = "en-GB",
    --           diagnosticSeverity = "information",
    --           setenceCacheSize = 2000,
    --           additionalRules = {
    --             enablePickyRules = true,
    --             -- motherTongue = "en-UK",
    --             languageModel = "~/ngrams/"
    --           },
    --           trace = { server = "verbose" },
    --           dictionary = {},
    --           disabledRules = {},
    --           hiddenFalsePositives = {},
    --         },
    --       },
    --     })








    lsp.setup()

    local null_ls = require("null-ls")

    require('crates').setup({
      null_ls = {
        enabled = true,
        name = "crates.nvim"
      }
    })
    local hover = null_ls.builtins.hover
    local code_actions = null_ls.builtins.code_actions
    local formatting = null_ls.builtins.formatting
    local completion = null_ls.builtins.completion
    local diagnostics = null_ls.builtins.diagnostics

    local null_opts = lsp.build_options("null-ls", {})
    null_ls.setup({
      on_attach = function(client, bufnr)
        null_opts.on_attach(client, bufnr)

      end,
      sources = {
        require("typescript.extensions.null-ls.code-actions"),
        hover.dictionary,
        completion.spell,
        formatting.black,
        --[[ code_actions.proselint, ]]
        diagnostics.write_good,
        -- code_actions.shellcheck,
        diagnostics.shellcheck,
        formatting.shfmt,
        --[[ diagnostics.ruff, ]]
        --[[ formatting.deno_fmt, ]]
        --[[ formatting.deno_fmt.with({
          filetypes = { "markdown" },
        }), ]]
      },
    })

    require("mason-null-ls").setup({
      ensure_installed = nil,
      automatic_installation = true,
      automatic_setup = true,
    })

    -- require("mason-null-ls").setup()#_handlers()

    -- Initialise rust_analyzer with rust-tools.nvim
    local rust_lsp = lsp.build_options("rust_analyzer", {})
    -- require("rust-tools").setup({ server = rust_lsp })

    vim.diagnostic.config({
      virtual_text = true,
    })
    --[[
  local lspconfig = require('lspconfig')
  lspconfig.sumneko_lua.setup({
    settings = {
      Lua = {
        completion = {
          callSnippet = "Replace"
        }
      }
    }
  })
  ]]
    --[[ local rt = require("rust-tools")
    rt.setup() ]]
  end,
}
