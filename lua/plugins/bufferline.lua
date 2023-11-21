vim.opt.termguicolors = true

--[[ return {
  'akinsho/bufferline.nvim',
  version = "v3.*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    require("bufferline").setup {
      options = {
        tab_size = 24,
        show_close_icon = false,
        diagnostics = "nvim_lsp",
        separator_style = {"",""},
        indicator = {
          icon = "❚",
          style = "icon"
        },
        highlights = {
          separator = {
            fg = "blue",
            bg = "black",
          },
        }
      }
    }
  end
} ]]
