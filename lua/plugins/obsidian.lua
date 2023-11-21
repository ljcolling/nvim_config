return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  --[[ cmd = {"ObsidianOpen"}, ]]
  event = {
    -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
    "BufEnter /Users/lc663/icloud/iCloud~md~obsidian/Documents/second-brain/**/*.md",
    "BufReadPre /Users/lc663/icloud/iCloud~md~obsidian/Documents/second-brain/**/*.md",
    "BufNewFile /Users/lc663/icloud/iCloud~md~obsidian/Documents/second-brain/**/*.md",
  },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",

    -- see below for full list of optional dependencies 👇
  },
  -- see below for full list of options 👇
  config = function()
    print("loading obsidian")
    require("obsidian").setup({})
  end

}
