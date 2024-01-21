-- vim: set foldmethod=marker:
-- vim: set foldmarker=--{{,--}}:
---@diagnostic disable: unused-local, undefined-global

local vim = _G.vim

vim.api.nvim_create_user_command("Bufs", function()
	vim.cmd([[Telescope buffers theme=dropdown]])
end, {})

-- ZenOn user command
--{{
--  vim.api.nvim_create_user_command("ZenOn", function()
--    require("zen-mode").toggle({
--      window = {
--        width = .85 -- width will be 85% of the editor width
--      }
--    })
--
--    vim.cmd("!kitty @ set-font-size +4")
--    vim.cmd("setlocal winblend=10")
--    vim.cmd("setlocal winhighlight=Normal:NormalFloat")
--    vim.cmd("setlocal winhighlight=FoldColumn:NormalFloat")
--    vim.cmd("set cmdheight=0")
--
--
--  end, {})
--}}

vim.api.nvim_create_user_command("Set", function()
	local target = vim.api.nvim_get_current_buf()
	vim.g.target = target
	print("appending to  " .. target)
end, {
	nargs = 1,
	complete = function(ArgLead, CmdLind, CursorPos)
		return { "file", "project" }
	end,
})

vim.api.nvim_create_user_command("FF", function(input)
	local folder = input.args
	if folder == "." then
		folder = vim.fn.expand("%:p:h")
		vim.cmd("cd " .. folder)
	elseif folder == ".." then
		folder = vim.fn.expand("%:p:h")
		vim.cmd("cd " .. folder)
		vim.cmd("cd ..")
	elseif folder == "..." then
		folder = vim.fn.expand("%:p:h")
		vim.cmd("cd " .. folder)
		vim.cmd("cd ..")
		vim.cmd("cd ..")
	elseif folder ~= "" then
		folder = "/Users/lc663/" .. folder
		vim.cmd("cd " .. folder)
	else
	end
	vim.cmd("CommandT")
end, {
	nargs = "*",
})

--vim.api.nvim_create_user_command("Writing", function()
--  vim.cmd [[
--    setlocal spell spelllang=en_gb
--    call pencil#init({'wrap': 'soft'})
--    let g:pencil_terminal_italics = 1
--    let g:pencil_spell_undercurl = 1       " 0=underline, 1=undercurl (def)
--    let g:pencil_higher_contrast_ui = 1   " 0=low (def), 1=high
--
--    set background=light
--    colorscheme pencil
--    highlight DiagnosticInfo guifg=red gui=bold
--    highlight DiagnosticUnderlineInfo guisp=red
--]]
--end, {})

vim.api.nvim_create_user_command("Count", function()
	local s = vim.api.nvim_buf_get_mark(0, "<")
	local e = vim.api.nvim_buf_get_mark(0, ">")
	local current = vim.api.nvim_buf_get_lines(0, s[1] - 1, e[1], false)
	local str = table.concat(current, "")
  local cmd = "echo '" .. str .. "' | word-count"
	local words = os.execute(cmd)
  print(words)
end, { range = "%", nargs = "*", addr = "lines" })

--[[
vim.api.nvim_create_user_command("Word", function()
  local s = vim.api.nvim_buf_get_mark(0, "<")
  local e = vim.api.nvim_buf_get_mark(0, ">")
  local current_txt = vim.api.nvim_buf_get_lines(0, s[1] - 1, e[1], false)

  local str = table.concat(current_txt, " ")
  local string = vim.split(str, " ")
  print(vim.inspect(string))


  vim.fn.system({ "talk" }, str)
end, { range = '%', nargs = "*", addr = "lines" })

]]
vim.api.nvim_create_user_command("Cmp", function(opts)
	local turn_on = opts.args == "on"
	if turn_on then
		require("cmp").setup.buffer({ enabled = true })
	else
		require("cmp").setup.buffer({ enabled = false })
	end
end, {
	nargs = 1,
	complete = function(ArgLead, CmdLind, CursorPos)
		return { "on", "off" }
	end,
})



-- I'll deal with this later
vim.api.nvim_create_user_command("Words", function()
	local filename = vim.api.nvim_buf_get_name(0)
	local words = vim.fn.system({
		"pandoc",
		"--lua-filter",
		"/Users/lc663/.config/nvim/wordcount.lua",
		filename,
		"--from=markdown",
	})
	local minutes = tostring(words)
	print(minutes .. " words")
end, {})

-- I'll deal with this later
vim.api.nvim_create_user_command("Minutes", function()
	local filename = vim.api.nvim_buf_get_name(0)
	local words = vim.fn.system({
		"pandoc",
		"--lua-filter",
		"/Users/lc663/.config/nvim/wordcount.lua",
		filename,
		"--from=markdown",
	})
	local minutes = tostring(math.ceil(words / 180))
	print(minutes .. " minutes")
end, {})

vim.api.nvim_create_user_command("VirtualText", function(opts)
	if opts.args == "lines" then
		vim.diagnostic.config({ virtual_lines = true })
	end

	if opts.args == "lineonly" then
		vim.diagnostic.config({ virtual_lines = { only_current_line = true } })
	end

	if opts.args == "text" then
		vim.diagnostic.config({ virtual_text = true })
	end

	if opts.args == "off" then
		vim.diagnostic.config({ virtual_text = false })
		vim.diagnostic.config({ virtual_lines = false })
    -- FIXME: This errors when hover is not already on
		vim.cmd([[
          autocmd! Hover CursorHold *
        ]])
	end

	if opts.args == "hover" then
		vim.cmd([[
      set updatetime=300
      " Show diagnostic popup on cursor hover
      augroup Hover
        autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
      augroup END
     ]])
	end
end, {
	nargs = 1,
	complete = function(ArgLead, CmdLind, CursorPos)
		return { "lines", "lineonly", "text", "hover", "off" }
	end,
})

vim.api.nvim_create_user_command("TodoTroubleBuffer", function()
	vim.cmd([[
    let file=expand("%:p:h")
    let foo='cwd='..expand(file)
    execute "TodoTrouble ".foo
  ]])
end, {})

vim.api.nvim_create_user_command("Explorehere", function()
	vim.cmd([[
    let file=expand("%:p:h")
    execute "Neotree" . file
  ]])
end, {})

vim.api.nvim_create_user_command("BK", function()
	vim.cmd([[
  execute "BufferCloseAllButCurrent"
  
  ]])
end, {})

vim.cmd([[
  cnorea <silent> bk BK
]])

vim.api.nvim_create_user_command("Autoformat", function()
	local filename = vim.fn.expand("%:p")
	vim.fn.system({ "R", "-e", "styler::style_file('" .. filename .. "')" })
end, {})

--[[
vim.api.nvim_create_user_command("Make", function()


  local sayok = function(_, data)
    if data then
      print(data[1])
    end
  end

  vim.fn.jobstart({"success", "make"}, {
      stdout_buffered = true,
    on_stdout = sayok,
    on_stderr = sayok
  })
end, {})

]]
--

vim.api.nvim_create_user_command("Lint", function()
	local filename = vim.fn.expand("%:p")
	local output = vim.fn.system({
		"R",
		"-s",
		"-e",
		"parse <- function(results) { lapply(results, function(x) { data.frame( file = x$file, line = x$line_number, column = x$column_number, type = x$type, message = x$message) }) |> Reduce(f = rbind) }; results <- lintr::lint('"
			.. filename
			.. "'); parse(results) |> jsonlite::toJSON()",
	})
	local output_table = vim.fn.json_decode(output)

	local api = vim.api
	local bnr = api.nvim_get_current_buf()
	local ns_id = api.nvim_create_namespace("my_namespace")
	local marks = api.nvim_buf_get_extmarks(bnr, ns_id, 0, -1, {})
	for k, v in pairs(marks) do
		local id = v[1]
		api.nvim_buf_del_extmark(bnr, ns_id, id)
	end

	local id = 1
	for k, v in pairs(output_table) do
		local line_num = v.line - 1
		local col_num = 0
		local message = v.message
		local opts = {
			id = id,
			virt_text = { { message, "DiagnosticHint" } },
			virt_text_pos = "eol",
		}

		local mark_id = vim.api.nvim_buf_set_extmark(bnr, ns_id, line_num, col_num, opts)
		id = id + 1
	end

	--[[ local line_num = 15 ]]
	--[[ local col_num = 0 ]]
end, {})

vim.api.nvim_create_user_command("Source", function()
	local str = ("source('" .. vim.fn.expand("%:p") .. "')\n")
	local pane_id = vim.b.wezterm_win_id
	if pane_id == nil then
		pane_id = vim.fn.input("Enter the window id: ")
		vim.b.wezterm_win_id = pane_id
	end
	--[[ vim.fn.system({"wezterm", "cli", "send-text", "--pane-id", pane_id, "--no-paste", str}) ]]
	vim.fn.system({ "wezterm", "cli", "send-text", "--pane-id", pane_id, str })
	vim.fn.system({ "wezterm", "cli", "send-text", "--pane-id", pane_id, "--no-paste", "\n" })
	--[[ vim.cmd([[ ]]
	--[[   let filename = expand("%:p") ]]
	--[[   let output =  "source('" .. filename .. "')\n" ]]
	--[[   :call slime#send(output) ]]
	--[[ ]]
	-- first I need to get the window to run the command in
	-- local filename = vim.fn.expand("%:p")
	-- local output = "source('" .. filename .. "')\n"
	-- vim.cmd([[
	--   :call slime#send(output)<cr>
	-- ]])
end, {})

vim.api.nvim_create_user_command("TestActiveFile", function()
	local str = ("devtools::test_active_file('" .. vim.fn.expand("%:p") .. "')\n")
	local pane_id = vim.b.wezterm_win_id
	if pane_id == nil then
		pane_id = vim.fn.input("Enter the window id: ")
		vim.b.wezterm_win_id = pane_id
	end
	--[[ vim.fn.system({"wezterm", "cli", "send-text", "--pane-id", pane_id, "--no-paste", str}) ]]
	vim.fn.system({ "wezterm", "cli", "send-text", "--pane-id", pane_id, str })
	vim.fn.system({ "wezterm", "cli", "send-text", "--pane-id", pane_id, "--no-paste", "\n" })
	--[[ vim.cmd([[ ]]
	--[[   let filename = expand("%:p") ]]
	--[[   let output =  "source('" .. filename .. "')\n" ]]
	--[[   :call slime#send(output) ]]
	--[[ ]]
	-- first I need to get the window to run the command in
	-- local filename = vim.fn.expand("%:p")
	-- local output = "source('" .. filename .. "')\n"
	-- vim.cmd([[
	--   :call slime#send(output)<cr>
	-- ]])
end, {})

vim.api.nvim_create_user_command("Test", function()
	local filename = vim.fn.expand("%:p")
	local output = vim.fn.system({
		"R",
		"-q",
		"-s",
		"-e",
		"suppressMessages({source('~/.config/nvim/nvim_reporter.r');  results <- devtools::test_active_file('"
			.. filename
			.. "', reporter = 'silent'); parse(results) |> jsonlite::toJSON()})",
	})
	--[[ print(output) ]]
	local output_table = vim.fn.json_decode(output)

	local api = vim.api
	local bnr = api.nvim_get_current_buf()
	local ns_id = api.nvim_create_namespace("my_namespace")
	local marks = api.nvim_buf_get_extmarks(bnr, ns_id, 0, -1, {})
	for _, v in pairs(marks) do
		local id = v[1]
		api.nvim_buf_del_extmark(bnr, ns_id, id)
	end

	local diagnostics = {}
	local id = 1
	for _, v in pairs(output_table) do
		local line_num = v.line - 1
		local col_num = 0
		local message = v.message
		local opts = {
			id = id,
			virt_text = { { message, "DiagnosticHint" } },
			virt_text_pos = "eol",
		}

		if v.type == "❌" then
			table.insert(
				diagnostics,
				{
					bufnr = bnr,
					lnum = line_num,
					end_lnum = line_num,
					col = 0,
					message = "Test failed",
					severity = vim.diagnostic.severity.ERROR,
				}
			)
		end
		--[[ local bnr = api.nvim_get_current_buf() ]]
		local mark_id = vim.api.nvim_buf_set_extmark(bnr, ns_id, line_num, col_num, opts)
		id = id + 1
	end

	vim.diagnostic.set(ns_id, 0, diagnostics)
	--[[ local line_num = 15 ]]
	--[[ local col_num = 0 ]]
end, {})

vim.api.nvim_create_user_command("Build", function(opts)
  local new = opts.args == "new"
	if new then
		vim.b.build_command = nil
	end

	if vim.b.build_command == nil then
		vim.b.build_command = vim.fn.input("Build command: ")
	end

	local sayok = function(_, data)
		if data then
			print(data[1])
		end
	end

	local build_command = vim.b.build_command
	vim.fn.jobstart(vim.split(build_command, " "), {
		stdout_buffered = true,
		on_stdout = sayok,
		on_stderr = sayok,
	})
end, {
	nargs = "?",
	complete = function(ArgLead, CmdLind, CursorPos)
	  return { 'new' }
	end
})

vim.api.nvim_create_user_command("ClearMarks", function()
	vim.cmd([[
    :delm! | delm A-Z0-9
    :wshada!
  ]])
end, {})

vim.api.nvim_create_user_command("SendWezTerm", function()
	local win_id = vim.fn.input("Enter the window id: ")
	vim.b.wezterm_win_id = win_id
end, {})

vim.api.nvim_create_user_command("SendWezTermGobal", function()
	local win_id = vim.fn.input("Enter the window id: ")
	vim.g.wezterm_win_id = win_id
end, {})

vim.api.nvim_create_user_command("Send", function(opts)
	local s = vim.api.nvim_buf_get_mark(0, "<")
	local e = vim.api.nvim_buf_get_mark(0, ">")
	local current = vim.api.nvim_buf_get_lines(0, s[1] - 1, e[1], false)
	local str = table.concat(current, "\r")
	--[[
  for k, v in pairs(current) do
  end
  ]]
	str = str .. "\r\n"
	-- get the target pane id
	local local_pane_id = vim.b.wezterm_win_id
	local global_pane_id = vim.g.wezterm_win_id
	local pane_id = nil
	if local_pane_id ~= nil then
		pane_id = local_pane_id
	else
		pane_id = global_pane_id
	end

	if pane_id == nil then
		pane_id = vim.fn.input("Enter the window id: ")
		vim.b.wezterm_win_id = pane_id
	end
	--[[ vim.fn.system({"wezterm", "cli", "send-text", "--pane-id", pane_id, "--no-paste", str}) ]]
	vim.fn.system({ "wezterm", "cli", "send-text", "--pane-id", pane_id, str })
	vim.fn.system({ "wezterm", "cli", "send-text", "--pane-id", pane_id, "--no-paste", "\n" })
end, { range = "%", nargs = "*", addr = "lines" })

vim.api.nvim_create_user_command("Split", function(opts)
	print("splitting...")
	vim.cmd([[
    split
    set laststatus=3
  ]])
end, {})

vim.api.nvim_create_user_command("VSplit", function(opts)
	print("vsplitting...")
	vim.cmd([[
    vsplit
    set laststatus=3
  ]])
end, {})

vim.cmd([[
  cnoreabbrev <silent> vsplit <cmd>VSplit<cr>
  cnoreabbrev <silent> split <cmd>Split<cr>
]])

vim.api.nvim_create_user_command("WhichKey", function()
	require("plugins.which_key")
end, {})

vim.api.nvim_create_user_command("ColourUpdate", function()
  vim.cmd([[
    :so ~/.config/nvim/lua/colorscheme.lua
  ]])
end,{})
