local status_ok, lualine = pcall(require, "lualine")
if not status_ok then return end

local hide_in_width = function() return vim.fn.winwidth(0) > 80 end

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "error", "warn", "info" },
  symbols = { error = "  ", warn = "|   ", info = " |  " },
  colored = true,
  update_in_insert = false,
  always_visible = true
}

local diff = { "diff",
  colored = false,
  symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
  cond = hide_in_width
}

local mode = {
  "mode",
  fmt = function(str)
    return " " .. str .. " "
  end
}

local filetype = {
  'filetype',
  colored = true,            -- Displays filetype icon in color if set to true
  icon_only = false,         -- Display only an icon for filetype
  icon = { align = 'right' } -- Display filetype icon on the right hand side
}

local branch = { "branch", icons_enabled = true, icon = "" }

local location = { "location", padding = 0 }

local loc = function()
  if vim.bo.filetype == "markdown" then
    local words = vim.fn.wordcount().words
    local minutes = tostring(math.ceil(words / 180))
    return minutes .. " minutes"
  end

  local current_line = vim.fn.line(".")
  local current_col = vim.fn.col(".")
  return current_line .. ":" .. current_col
end

local env_cleanup = function(venv)
  if string.find(venv, "/") then
    local final_venv = venv
    for w in venv:gmatch "([^/]+)" do final_venv = w end
    venv = final_venv
  end
  return venv
end

local python_env = {
  function()
    -- local utils = require "lvim.core.lualine.utils"
    if vim.bo.filetype == "python" then
      local venv = os.getenv "CONDA_DEFAULT_ENV"
      if venv then
        return string.format("  (%s)", env_cleanup(venv))
      end
      venv = os.getenv "VIRTUAL_ENV"
      if venv then
        return string.format("  (%s)", env_cleanup(venv))
      end
      return ""
    end
    return ""
  end
  -- color = { fg = colors.green },
  -- cond = conditions.hide_in_width,
}

-- cool function for progress
local progress = {
  function()
    local current_line = vim.fn.line(".")
    local total_lines = vim.fn.line("$")
    local chars = {
      "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆",
      "▇▇", "██"
    }
    local line_ratio = current_line / total_lines
    local index = math.ceil(line_ratio * #chars)
    return chars[index]
  end,
  color = { fg = "blue", bg = "none" }
}

local spaces = function()
  return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

local treesitter = {
  function()
    local b = vim.api.nvim_get_current_buf()
    if next(vim.treesitter.highlighter.active[b]) then return " 🌳" end
    return ""
  end,
  color = { fg = "green" },
  cond = hide_in_width
}

local lsp = {
  function(msg)
    msg = msg or "LS Inactive"
    local buf_clients = vim.lsp.buf_get_clients()
    if next(buf_clients) == nil then
      -- TODO: clean up this if statement
      if type(msg) == "boolean" or #msg == 0 then
        return "LS Inactive"
      end
      return msg
    end
    local buf_ft = vim.bo.filetype
    local buf_client_names = {}

    -- add client
    for _, client in pairs(buf_clients) do
      if client.name ~= "null-ls" then
        table.insert(buf_client_names, client.name)
      end
    end


    local null_ls = require("null-ls.sources").get_available(buf_ft)
    for _, source in ipairs(null_ls) do
      vim.list_extend(buf_client_names, { source.name })
    end

    local unique_client_names = vim.fn.uniq(buf_client_names)
    return "" .. table.concat(unique_client_names, ", ") .. ""
  end,
  color = { gui = "bold" },
  cond = hide_in_width
}

local function getWords()
  local words = vim.fn.wordcount().words
  local minutes = tostring(math.ceil(words / 180))
  return minutes .. " minutes"
end

lualine.setup({
  options = {
    icons_enabled = true,
    theme = "auto",
    component_separators = { right = "", left = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = { "alpha", "dashboard", "neo-tree", "Outline" },
    always_divide_middle = true
  },
  sections = {
    lualine_a = { mode },
    lualine_b = { python_env, diagnostics },
    lualine_c = { treesitter, lsp },
    -- lualine_x = { "encoding", "fileformat", "filetype" },
    lualine_x = { branch, diff },
    lualine_y = { "filetype" },
    lualine_z = { "location" },
    --[[ lualine_z = {location, progress }, ]]
    -- lualine_z = {loc}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {}
  },
--[[ tabline = {
  lualine_a = {'buffers'},
  lualine_b = {},
  lualine_c = {'branch'},
  lualine_x = {},
  lualine_y = {},
  lualine_z = {'tabs'}
},

  winbar = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {"filename"},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  inactive_winbar = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {"filename"},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  ]]
  extensions = {}
})
