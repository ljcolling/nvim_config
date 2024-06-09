require("nvim-treesitter.configs").setup({
	-- ensure_installed = { "markdown", "lua", "rust", "r", "go", "javascript", "bash" },
	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
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
	context_commentstring = {
		enable = true,
	},
	indent = {
		enable = true,
	},
})


