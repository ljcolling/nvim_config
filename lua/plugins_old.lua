-- vim: set foldmethod=marker:
-- vim: set foldmarker=--[[,]]:

-- TODO:
-- Switch from packer to lazy.nvim

local fn = vim.fn
local cmd = vim.cmd
-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file

-- Automaticaly update plugins on update
cmd([[
 ""  augroup packer_user_config
 ""  autocmd!
 ""  autocmd BufWritePost plugins.lua source <afile> | PackerSync
 ""  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	--[[ use {"Pocco81/HighStr.nvim"} ]]
	--[[ use {"tpope/vim-fugitive"} ]]
	-- neoorg
	--[[
use {
    "nvim-neorg/neorg",
    -- tag = "*",
    ft = "norg",
    after = "nvim-treesitter", -- You may want to specify Telescope here as well
    config = function()
        require('neorg').setup {
            load = {
                ["core.defaults"] = {}, -- Loads default behaviour
                ["core.norg.concealer"] = {}, -- Adds pretty icons to your documents
                ["core.norg.dirman"] = { -- Manages Neorg workspaces
                    config = {
                        workspaces = {
                            notes = "~/notes",
                        },
                    },
                },
            },
        }
    end
} ]]
	-- jupytext
	use({ "goerz/jupytext.vim" })

	-- Competitive programming
	use({
		"xeluxee/competitest.nvim",
		requires = "MunifTanjim/nui.nvim",
		config = function()
			require("competitest").setup({
				test_cases_use_single_file = true,
			})
		end,
	})




	-- Command T
	use({
		"wincent/command-t",
		run = "cd lua/wincent/commandt/lib && make",
		setup = function()
			vim.g.CommandTPreferredImplementation = "lua"
		end,
		config = function()
			require("wincent.commandt").setup({
				-- Customizations go here.
			})
		end,
	})

	--[[
use({'tjdevries/sg.nvim', build = "cargo build --workspace --release",
  config = function()
    require("sg").setup()
end})
]]
	-- Copilot cmp stuff
	--[[
   use {
     "zbirenbaum/copilot.lua",
     cmd = "Copilot",
     event = "InsertEnter",
     config = function()
       require("copilot").setup({
         suggestion = { enabled = false },
         panel = { enabled = false },
       })
     end,
   }


   use {
     "zbirenbaum/copilot-cmp",
     after = { "copilot.lua" },
     config = function()
       require("copilot_cmp").setup()
     end
   }

  use({ 'tamago324/lir.nvim' })
]]
	-- Templating
	--[[
  use({ "xvzc/skeleton.nvim",
    config = function()
      require("skeleton").setup({})
    end })

  use({ "glepnir/template.nvim",
    config = function()
      require("template").setup({})
    end })
]]
	--- plugins for wezterm
	use({
		"numToStr/Navigator.nvim",
		config = function()
			require("Navigator").setup()
		end,
	})

	use({
		"nvim-telescope/telescope-fzf-native.nvim",
		run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && \
    cmake --build build --config Release && \
    cmake --install build --prefix build",
	})

	use({ "norcalli/nvim-colorizer.lua" })

	use({ "spaceduck-theme/nvim" })

	use({ "nyoom-engineering/oxocarbon.nvim" })

	use({
		"chentoast/marks.nvim",
		config = function()
			require("marks").setup()
		end,
	})

	use({ "sindrets/diffview.nvim" })
	use({ "weilbith/nvim-code-action-menu" })
	use({ "nvim-telescope/telescope-file-browser.nvim" })
	use({ "sbdchd/neoformat" })

	--[[ use({ ]]
	--[[   'kosayoda/nvim-lightbulb', ]]
	--[[   config = function() ]]
	--[[     require('nvim-lightbulb').setup({ autocmd = { enabled = true } }) ]]
	--[[   end ]]
	--[[ }) ]]
	use({
		"folke/twilight.nvim",
		config = function()
			require("twilight").setup({})
		end,
	})

	use({ "folke/zen-mode.nvim" })

	use({
		"folke/neodev.nvim",
		config = function()
			require("neodev").setup()
		end,
	})

	use({ "barreiroleo/ltex-extra.nvim" })

	use({
		"brymer-meneses/grammar-guard.nvim",
		requires = { "neovim/nvim-lspconfig" },
	})

	use({ "folke/tokyonight.nvim" })

	use({ "wbthomason/packer.nvim" })

	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.0",
		requires = { "nvim-lua/plenary.nvim" },
	})

	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use({ "nvim-treesitter/playground" })
	use({ "theprimeagen/harpoon" })
	use({ "mbbill/undotree" })
	use({ "tpope/vim-fugitive" })

	use({
		"VonHeikemen/lsp-zero.nvim",
		requires = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" },
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
			-- Snippets
			{ "L3MON4D3/LuaSnip" },
			{ "rafamadriz/friendly-snippets" },
		},
	})

	use("github/copilot.vim")

	use({
		"glepnir/dashboard-nvim",
		commit = "e517188dab55493fb9034b4d4f1a508ccacfcd45",
	})

	-- colorschemes
	use({ "rose-pine/neovim" })
	use({ "Shatur/neovim-ayu" })

	use({ "nxvu699134/vn-night.nvim" })

	-- visual enhancements
	use({ "kyazdani42/nvim-web-devicons" })

	-- general dependencies
	use({ "nvim-lua/plenary.nvim" })
	use({ "MunifTanjim/nui.nvim" })
	use({
		"s1n7ax/nvim-window-picker",
		config = function()
			require("window-picker").setup()
		end,
	})

	use({ "nvim-neo-tree/neo-tree.nvim" })

	use({ "knubie/vim-kitty-navigator" })

	use({ "akinsho/bufferline.nvim" })

	use({ "nvim-lualine/lualine.nvim" })

	use({ "folke/which-key.nvim" })

	use({ "numToStr/Comment.nvim" })

	use({ "JoosepAlviste/nvim-ts-context-commentstring" })

	use({
		"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		config = function()
			require("lsp_lines").setup()
		end,
	})

	use({ "nvim-treesitter/nvim-treesitter-context" })

	use({
		"Pocco81/auto-save.nvim",
		config = function()
			require("auto-save").setup({})
		end,
	})
	use({
		"simrat39/rust-tools.nvim",
		config = function()
			require("rust-tools").setup()
		end,
	})

	use({ "mfussenegger/nvim-dap" })

	use({
		"iamcco/markdown-preview.nvim",
		run = function()
			fn["mkdp#util#install"]()
		end,
	})

	use({ "lukas-reineke/virt-column.nvim" })

	--[[ https://github.com/utilyre/barbecue.nvim ]]
	--[[ https://github.com/nxvu699134/vn-night.nvim ]]
	use({
		"unblevable/quick-scope",
		config = function()
			vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" }
		end,
	})

	use({ "navarasu/onedark.nvim" })

	-- Golang stuff
	--[[ use({ "fatih/vim-go" }) ]]
	use({
		"ray-x/go.nvim",
		requires = { -- optional packages
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("go").setup()
		end,
		event = { "CmdlineEnter" },
		ft = { "go", "gomod" },
		build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
	})

	--[[
  use({
    "utilyre/barbecue.nvim",
    tag = "*",
    requires = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    config = function()
      require("barbecue").setup()
    end,
  })
]]
	use({
		"stevearc/aerial.nvim",
		config = function()
			require("aerial").setup()
		end,
	})

	use({ "folke/trouble.nvim" })

	use({ "jpalardy/vim-slime" })

	use({
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	})

	use({ "nvimtools/none-ls.nvim"})

	use({
		"folke/todo-comments.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("todo-comments").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	})

	use({ "lukas-reineke/indent-blankline.nvim" })

	use({
		"amrbashir/nvim-docs-view",
		opt = true,
		cmd = { "DocsViewToggle" },
		config = function()
			require("docs-view").setup({ position = "right", width = 60 })
		end,
	})

	use({ "nvim-telescope/telescope-fzy-native.nvim" })

	use({
		"ggandor/leap.nvim",
		config = function()
			require("leap").add_default_mappings()
		end,
	})

	-- LSP related
	--[[ use({ "hrsh7th/cmp-nvim-lsp-signature-help" }) ]]
	use({ "f3fora/cmp-spell" })
	use({
		"simrat39/symbols-outline.nvim",
		config = function()
			require("symbols-outline").setup()
		end,
	})

	use({
		"glepnir/lspsaga.nvim",
		branch = "main",
		config = function()
			require("lspsaga").setup({})
		end,
	})

	use({
		"akinsho/toggleterm.nvim",
		config = function()
			require("toggleterm").setup({
				size = 20,
				-- open_mapping = [[<leader-t>]],
				hide_numbers = true,
				shade_filetypes = {},
				shade_terminals = true,
				shading_factor = 1,
				start_in_insert = true,
				persist_size = true,
				direction = "float",
				close_on_exit = true,
				shell = vim.o.shell,
				--[[ env = { TERM_PROGRAM = 'nvim' }, ]]
			})
		end,
	})

	use({
		"https://git.sr.ht/~havi/telescope-toggleterm.nvim",
		event = "TermOpen",
		requires = {
			"akinsho/nvim-toggleterm.lua",
			"nvim-telescope/telescope.nvim",
			"nvim-lua/popup.nvim",
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("telescope").load_extension("toggleterm")
		end,
	})

	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)

-- Old plugins
--[[
  use({ "Pocco81/true-zen.nvim" })

  use({ "folke/zen-mode.nvim" })

  use({ "catppuccin/nvim" })
use({ "epwalsh/obsidian.nvim" })

 use { 'quarto-dev/quarto-nvim' }
  use({ "RRethy/nvim-base16" })
  use({
    'notjedi/nvim-rooter.lua',
    config = function() require 'nvim-rooter'.setup() end
  })
  use({ "williamboman/mason.nvim" })



  use({ "p00f/nvim-ts-rainbow" })

  use({ "mcchrish/zenbones.nvim", requires = "rktjmp/lush.nvim" })

  use("pineapplegiant/spaceduck")

  })


  use({ "nvim-treesitter/playground" })

  -- rust stuff


  use("segeljakt/vim-silicon")
  use("vim-pandoc/vim-pandoc-syntax")
  use("jc-doyle/cmp-pandoc-references")






   use ({'michaelb/sniprun'})


use ('tpope/vim-fugitive')

  use({
    "AckslD/nvim-FeMaco.lua",
    -- "~/GitHub/nvim-FeMaco.lua",
    config = 'require("femaco").setup()'
  })

use({
    "~/GitHub/aerial.nvim",
    config = function() require("aerial").setup({}) end
  })

  -- My plugins here
  -- File tree
  use({
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    requires = {
      "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim", {
        -- only needed if you want to use the commands with "_with_window_picker" suffix
        "s1n7ax/nvim-window-picker",
        tag = "v1.*",
        config = function()
          require("window-picker").setup({
            autoselect_one = true,
            include_current = false,
            filter_rules = {
              -- filter using buffer options
              bo = {
                -- if the file type is one of following, the window will be ignored
                filetype = {
                  "neo-tree", "neo-tree-popup", "notify",
                  "quickfix"
                },

                -- if the buffer type is one of following, the window will be ignored
                buftype = { "terminal" }
              }
            },
            other_win_hl_color = "#e35e4f"
          })
        end
      }
    }
  })

   use("preservim/vim-markdown")
   use('SidOfc/mkdx')
   use("vim-pandoc/vim-pandoc-syntax")
  use("vim-pandoc/vim-pandoc")


   use("preservim/vim-colors-pencil")

   use("preservim/vim-pencil")
 use({ "wbthomason/packer.nvim" }) -- Have packer manage itself
  use({ "nvim-lua/plenary.nvim" }) -- Useful lua functions used by lots of plugins
 use({ "windwp/nvim-autopairs", commit = "fa6876f832ea1b71801c4e481d8feca9a36215ec" }) -- Autopairs, integrates with both cmp and treesitter

   use({ "kyazdani42/nvim-tree.lua", commit = "bdb6d4a25410da35bbf7ce0dbdaa8d60432bc243" })
   use({ "akinsho/bufferline.nvim", commit = "c78b3ecf9539a719828bca82fc7ddb9b3ba0c353" })
   use({ "moll/vim-bbye", commit = "25ef93ac5a87526111f43e5110675032dbcacf56" })
   use({ "ahmedkhalf/project.nvim", commit = "541115e762764bc44d7d3bf501b6e367842d3d4f" })
  use({ "lewis6991/impatient.nvim", commit = "969f2c5c90457612c09cf2a13fee1adaa986d350" })
  use({ "lukas-reineke/indent-blankline.nvim" })
  use({ "goolord/alpha-nvim", commit = "ef27a59e5b4d7b1c2fe1950da3fe5b1c5f3b4c94" })

  -- Colorschemes

  use("lunarvim/darkplus.nvim")

  -- cmp plugins
  use({ "hrsh7th/cmp-nvim-lua" })

  -- snippets
  use({ "rafamadriz/friendly-snippets" }) -- a bunch of snippets to use

  use({ "hrsh7th/cmp-nvim-lsp" })
  use({ "hrsh7th/cmp-buffer" })
  use({ "hrsh7th/cmp-path" })
  use({ "hrsh7th/cmp-cmdline" })
  use({ "hrsh7th/nvim-cmp" })
  use({ "saadparwaiz1/cmp_luasnip" })
  use({ "L3MON4D3/LuaSnip" })


  -- Telescope
  use({ "nvim-telescope/telescope.nvim" })

  -- Treesitter
  use("nvim-treesitter/nvim-treesitter")

  -- Git


  -- filetypes
  use("nathom/filetype.nvim")
  -- use("plasticboy/vim-markdown")

  -- keymap helper
  use({ "folke/which-key.nvim" })


   ]]
--[[
 use {'akinsho/git-conflict.nvim', tag = "*", config = function()
   require('git-conflict').setup()
 end}

  use {'https://gitlab.com/yorickpeterse/nvim-pqf.git', config = function()
      require('pqf').setup()
  end}


  use 'Mofiqul/dracula.nvim'
  use { "LinArcX/telescope-command-palette.nvim" }

  use 'metakirby5/codi.vim'

  use 'github/copilot.vim'
  use 'kdheepak/lazygit.nvim'
  use 'neovim/nvim-lspconfig' -- Configurations for Nvim LSP
  use({"uga-rosa/ccc.nvim"})


use {
  "Dax89/ide.nvim",
  requires = {
       {"nvim-lua/plenary.nvim"},
       {"rcarriga/nvim-notify"},   -- Notifications Popup (Optional)
       {"stevearc/dressing.nvim"}, -- Improved UI (Optional)
       {"mfussenegger/nvim-dap"} , -- DAP Support (Optional)
       {"rcarriga/nvim-dap-ui"},   -- DAP-UI Support (Optional)
    }
}
]]
--[[

  use({"chrisbra/Colorizer"})



  use("jose-elias-alvarez/typescript.nvim")

  -- DAP
  use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }
]]
--[[
  use {
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup {}
    end
  }
]]
--[[
  use({ "rmehri01/onenord.nvim" })
]]
--[[
  use({"/stevearc/dressing.nvim"})
  use({"mrjones2014/legendary.nvim"})
]]
--[[
  use {
    "SmiteshP/nvim-navic", config = function()
      require("navic").setup({
        default_keymaps = true,
        default_config = {
          -- Your default config goes here
        },
        treesitter_analysis = true,
        treesitter_hlgroups = true,
        treesitter_indent = true,
      })
    end
  }

  use { 'fgheng/winbar.nvim', config = function() require('winbar').setup() end }
]]
--[[
]]
--[[
  use({'petertriho/nvim-scrollbar', config = function() require('scrollbar').setup() end})
  ]]
--[[
  use { 'jmbuhr/otter.nvim' }
  use { 'quarto-dev/quarto-nvim',
    requires = {
      'jmbuhr/otter.nvim',
      'neovim/nvim-lspconfig'
    },
    config = function()
      require 'quarto'.setup {
        lspFeatures = {
          enabled = true,
          languages = { 'r', 'python', 'julia' },
          diagnostics = {
            enabled = true,
            triggers = { "BufWrite" }
          },
          completion = {
            enabled = true
          }
        }
      }
    end
  }
]]
