local vim = _G.vim


--[[ local desc = function(desc)
  return { noremap = true, silent = true, desc = desc }
end ]]
--[[ local keymap = vim.api.nvim_set_keymap ]]
local keymap = function(mode, map, action, desc)
  local opts = { noremap = true, silent = true, desc = desc }
  vim.api.nvim_set_keymap(mode, map, action, opts)
end

local keymap_wk = function(mode, map, action, desc)
  map = "<leader>" .. map
  local opts = { noremap = true, silent = true, desc = desc }
  vim.api.nvim_set_keymap(mode, map, action, opts)
end


-- Remap the leader key
keymap("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "





-- Moving text around --

-- Indenting
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

--[[ -- Moving up and down ]]
keymap("x", "K", ":move '<-2<CR>gv-gv")
keymap("x", "J", ":move '>+1<CR>gv-gv")

--[[ vim.keymap.set({'n', 't'}, '<C-p>', '<CMD>NavigatorPrevious<CR>') ]]
-- Navigate buffers
--[[ keymap("n", "<S-l>", ":bnext<CR>")
keymap("n", "<S-h>", ":bprevious<CR>") ]]
keymap("n", "<S-l>", ":BufferNext<CR>")
keymap("n", "<S-h>", ":BufferPrevious<CR>")


keymap("n", "<leader>;", ":Dashboard<CR>", "Dashboard")
keymap("x", '<leader>p', "\"_dP", "Paste")
--[[ keymap("n",'<leader>p',"\"_dP", opts) ]]
--[[ keymap("n","Q",":vip <cmd>Neoformat<cr>", opts) ]]
-- Vim-Slime
-- Set the Send command based on terminal type
if os.getenv("TERM") == "xterm-kitty" then
  keymap("v", "<space><cr>", ":SlimeSend<cr>", "Send selection to REPL")
  keymap("n", "<space><cr>", "i<Esc>vip :SlimeSend<CR>gi<Esc>", "Send paragraph to REPL")
elseif os.getenv("TERM_PROGRAM") == "ALACRITTY" then
  keymap("v", "<space><cr>", ":ToggleTermSendVisualSelection<cr>", "Send selection to REPL")
  keymap("n", "<space><cr>", "i<Esc>vip :ToggleTermSendVisualSelection<CR>gi<Esc>", "Send paragraph to REPL")
else
  keymap("v", "<space><cr>", ":Send<cr>", "Send selection to REPL")
  keymap("n", "<space><cr>", "i<Esc>vip :Send<CR>gi<Esc>", "Send paragraph to REPL")
end
--
-- speak
keymap("n", "<leader><leader>s", 'i<Esc>vip "xy:call TTS()<cr>', "Speak paragraph")
keymap("v", "s", '"xy:call TTS()<cr>', "Speak selection")



-- source
keymap("n", "<leader><leader>x", ":so %<cr>", "Source file")


--[[ keymap("n", "<leader><leader>e", ":Explorehere<cr>", opts) ]]
keymap("n", "<leader>j", "vipgw", "Format paragraph")
keymap("n", "<leader><leader>j", "vipJ", "Unformat paragraph")

keymap("n", "<C-P>", ":Telescope<cr>")

vim.cmd([[
  set laststatus=3
]])


-- keymaps taken from which key

keymap("n", "<leader>b", ":Bufs<CR>", "Buffers")
keymap("n", "<leader>t", "<cmd>ToggleTerm<CR>", "Terminal")

-- [g]oto
keymap_wk("n", "gD", ":lua vim.lsp.buf.declaration()<CR>", "Declaration")
keymap_wk("n", "gr", ":lua vim.lsp.buf.references()<CR>", "References")
keymap_wk("n", "gi", ":lua vim.lsp.buf.implementation()<CR>", "Implementation")
keymap_wk("n", "gs", ":lua vim.lsp.buf.signature_help()<CR>", "Signature Help")
keymap_wk("n", "gt", ":lua vim.lsp.buf.type_definition()<CR>", "Type Definition")
keymap("n", "<leader>gf", ":e <cfile><cr>", "Goto file") -- don't overwrite gf

-- [l]sp
keymap_wk("n", "la", "<cmd>Lspsaga code_action<cr>", "Code Action")
keymap_wk("n", "ld", ":Telescope diagnostics bufnr=0 theme=get_ivy<cr>", "Buffer Diagnostics")
keymap_wk("n", "lw", ":Telescope diagnostics<cr>", "Diagnostics")
keymap_wk("n", "lf", ":lua vim.lsp.buf.format()<cr>", "Format")
keymap_wk("n", "li", ":LspInfo<cr>", "Info")
keymap_wk("n", "lI", ":Mason<cr>", "Mason Info")
keymap_wk("n", "ll", ":lua vim.lsp.codelens.run", "CodeLens Action")
keymap_wk("n", "lq", ":lua vim.diagnostic.setloclist", "Quickfix")
keymap_wk("n", "ls", ":SymbolsOutline<cr>", "Symbol outline")
keymap_wk("n", "lS", ":Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace Symbols")
keymap_wk("n", "le", ":Telescope quickfix<cr>", "Telescope Quickfix")

--[[
===============================================================================
                  LSP RELATED [NOT ORGANISED BY PREFIX]
===============================================================================
]]
keymap_wk("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", "Lsp finder")
keymap_wk("n", "gd", "<cmd>Lspsaga goto_definition<CR>", "Goto definition")
keymap_wk("n", "lr", "<cmd>Lspsaga rename<CR>", "Rename in buffer")
keymap_wk("n", "lR", "<cmd>Lspsaga rename ++project<CR>", "Rename in project")
--[[ keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", "Hover docs") ]]


-- show diagnostics
keymap_wk("n", "sl", "<cmd>Lspsaga show_line_diagnostics<CR>", "Line diagnostics")
keymap_wk("n", "sb", "<cmd>Lspsaga show_buf_diagnostics<CR>", "Buffer diagnostics")
keymap_wk("n", "sw", "<cmd>Lspsaga show_workspace_diagnostics<CR>", "Workspace diagnostics")
keymap_wk("n", "sc", "<cmd>Lspsaga show_cursor_diagnostics<CR>", "Cursor diagnostics")

-- move between diagnostics
keymap_wk("n", "]d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", "Diagnostic previous")
keymap_wk("n", "[d", "<cmd>Lspsaga diagnostic_jump_next<CR>", "Diagnostic next")

--[[ keymap_wk("n", "[D", function()
  require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, "Error next")
keymap_wk("n", "]D", function()
  require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
end, "Error previous") ]]

-- Using trouble
keymap_wk("n", "xb", "<cmd>TroubleToggle document_diagnostics<CR>", "Buffer diagnostics (trouble)")
keymap_wk("n", "xw", "<cmd>TroubleToggle workspace_diagnostics<CR>", "Workspace diagnostics (trouble)")
keymap_wk("n", "gr", "<cmd>TroubleToggle lsp_references<CR>", "References (trouble)")
keymap_wk("n", "tt", "<cmd>TroubleToggle<CR>", "Trouble Toggle)")

keymap("n", "K", ":lua vim.lsp.buf.hover()<cr>", "Hover docs")

--[[ keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", "Hover docs") ]]

keymap("n", "<leader>f", "<cmd>Telescope git_files<cr>", "Files")
--[[
=============================================================================
]]
-- [s]earch
keymap_wk("n", "sf", "<cmd>Telescope find_files<cr>", "Files")
keymap_wk("n", "st", "<cmd>Telescope live_grep<cr>", "Text")
keymap_wk("n", "ss", "<cmd>Telescope spell_suggest<cr>", "Spelling")
keymap_wk("n", "sS", "<cmd>Telescope treesitter<cr>", "Treesitter symbols")
keymap_wk("n", "sw", "<cmd>lua vim.lsp.buf.workspace_symbol()<cr>", "Workspace symbols")


-- diagnostic

keymap("n", "<leader>d", ":lua vim.diagnostic.open_float()<cr>", "Diagnostics")

keymap_wk("n","a","<cmd>AerialToggle float<cr>","Aerial Toggle")

-- vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts) ]]
--
keymap_wk(
"n",
"/",
":lua require('Comment.api').toggle.linewise.current()<cr>",
"Commment toggle linewise (visual)")


keymap_wk(
"v",
"/",
":lua require('Comment.api').toggle.blockwise(vim.fn.visualmode())<cr>",
"Commment toggle linewise (visual)")


-- [m]arks
keymap("n","<leader>m", "<cmd>Telescope marks<cr>", "Marks")
keymap_wk("n", "ma", "<cmd>MarksListAll<cr>","List all marks")

