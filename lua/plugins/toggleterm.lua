local vim = _G.vim

vim.api.nvim_create_user_command("NewTerm", function()
	require("toggleterm.terminal").Terminal
		:new({
			env = { TERM_PROGRAM = "nvim" },
			shading_factor = 1,
			hide_numbers = true,
			shade_filetypes = {},
			shade_terminals = true,
			start_in_insert = true,
			persist_size = true,
			persist_mode = true,
			direction = "float",
			close_on_exit = false,
			shell = vim.o.shell,
		})
		:toggle()
end, {})

return {
	"akinsho/toggleterm.nvim",
  lazy = false,
	keys = {

		{ "<leader>T", "<cmd>NewTerm<CR>", desc = "Toggleterm" },
	},
	config = function()
		require("toggleterm").setup({
			size = 20,
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
}
