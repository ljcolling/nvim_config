return {
  "numToStr/Comment.nvim",
  command = "Comment",
  dependencies = { "nvim-treesitter/nvim-treesitter", "JoosepAlviste/nvim-ts-context-commentstring" },
  config = function()
    require("nvim-treesitter.configs").setup({})

    require('Comment').setup {}
  end
}
