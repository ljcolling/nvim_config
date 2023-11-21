
require("grammar-guard").init()
local nvim_lsp = require("lspconfig")
nvim_lsp["grammar_guard"].setup({
  cmd = { "/Applications/ltex-ls-15.2.0/bin/ltex-ls" },
  on_attach = function(client, bufnr)
      -- your other on_attach functions.
      require("ltex_extra").setup{
          load_langs = { "en-GB" }, -- table <string> : languages for witch dictionaries will be loaded
          init_check = true, -- boolean : whether to load dictionaries on startup
          path = nil, -- string : path to store dictionaries. Relative path uses current working directory
          log_level = "none", -- string : "none", "trace", "debug", "info", "warn", "error", "fatal"
      }
    end,
  settings = {
    ltex = {
     languageToolHttpServerUri = "https://api.languagetoolplus.com",
      languageToolOrg = {
        apiKey = 'pit-gtQy20xbano5',
        username = 'lincoln@colling.net.nz'
      },
      enabled = { "latex", "tex", "bib", "markdown", "pandoc" },
      language = "en",
      diagnosticSeverity = "information",
      setenceCacheSize = 2000,
      additionalRules = {
        enablePickyRules = true,
        motherTongue = "en",
--[[         languageModel = "~/ngrams/" ]]
      },
      trace = { server = "verbose" },
      dictionary = {},
      disabledRules = {},
      hiddenFalsePositives = {},
    },
  },
})


--[[ https://github.com/barreiroleo/ltex_extra.nvim ]]
