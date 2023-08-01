-- local fn = vim.fn
local C = require("statusline.common")

local M = {}
-- replace empty strings
local function sub_empty(emp, sub)
	sub = sub or "?"
	if emp == "" or emp == nil then
		return sub
	end
	return emp
end

M.mode = function()
	local m = C.get_mode()
	return C.join(" ", { m.highlight .. "", m.mode })
end

M.file_info = function()
	local info = C.file_info()
	return C.join(
		" ",
		{ "%#StLineFileInfo#" .. info.icon, sub_empty(info.name) }
	)
end

M.filetype = function()
	return C.join(" ", { "%#StLineFileType#", sub_empty(C.filetype()) })
end

-- Git stuff
M.git_branch = function()
	local branch = C.get_branch()
	if branch ~= "" then
		return C.join(" ", { "%#StLineGitBranch#", "", branch })
	end
	return ""
end

M.git_changes = function()
	if vim.o.columns < 120 then
		return ""
	end
	local changes = C.get_changes()
	if not changes then
		return ""
	end
	local highlights = {
		added = "%#StLineLSPInfo#",
		changed = "%#StLineLSPWarning#",
		removed = "%#StLineLSPError#",
	}
	local icons = { added = "", changed = "", removed = "" }
	local result = {}
	for k, v in pairs(changes) do
		if v > 0 then
			table.insert(result, highlights[k] .. icons[k])
			table.insert(result, v)
		end
	end
	return C.join(" ", result)
end

-- LSP STUFF
M.LSP_progress = function()
	if vim.o.columns < 120 then
		return ""
	end
	local progress = C.LSP_message()
	if progress == "" then
		return ""
	end
	local spinners =
		{ "", "󰪞", "󰪟", "󰪠", "󰪢", "󰪣", "󰪤", "󰪥" }
	local content = string.format(
		" %%<%s %s %s (%s%%%%) ",
		spinners[C.get_cyclic_counter(#spinners) + 1],
		progress.title,
		progress.message,
		progress.percentage
	)
	-- trim the progress message if parameter is set
	if vim.g.lsprogress_len then
		content = string.sub(content, 1, vim.g.lsprogress_len)
	end

	return "%#StLineLspProgress#" .. content
end

M.LSP_diagnostics = function()
	if vim.o.columns <= 0 then
		return ""
	end
	local counts = C.LSP_severities()
	local icons = { error = "󰅚", warn = "", hint = "󰛩", info = "" }
	local diagnostics = C.join(" ", {
		"%#StLineLspError#" .. icons.error,
		sub_empty(counts.error_count),
	})

	diagnostics = C.join(" ", {
		diagnostics,
		"%#StLineLspWarning#" .. icons.warn,
		sub_empty(counts.warning_count),
	})

	if counts.hint_count ~= nil and counts.hint_count > 0 then
		diagnostics = C.join(
			" ",
			{ diagnostics, "%#StLineLspHints#" .. icons.hint, counts.hint_count }
		)
	end

	if counts.info_count ~= nil and counts.info_count > 0 then
		diagnostics = C.join(
			" ",
			{ diagnostics, "%#StLineLspInfo#" .. icons.info, counts.info_count }
		)
	end

	return diagnostics
end

function M.cursor_position()
	if vim.o.columns > 140 then
		return "%#StLineText#Ln %l/%L, Cl %c"
	end
	return ""
end

function M.LSP_status()
	local client = C.LSP_client()
	if client == "" then
		return ""
	end
	if vim.o.columns > 100 then
		return C.join(" ", { "%#StLineLspStatus#", "󰄭", client })
	end
	return C.join(" ", { "%#StLineLspStatus#", "󰄭", "LSP" })
end

function M.file_encoding()
	local encoding = string.upper(vim.bo.fileencoding)
	if encoding == "" then
		return encoding
	end
	return C.join(" ", { "%#StLineEncode#", encoding })
end

M.cwd = function()
	if vim.o.columns > 85 then
		return C.join(" ", { "%#StLineCwd# 󰉖", C.get_cwd() })
	end
	return ""
end

function M.run()
	-- local modules = require("statusline.vscode_colored")

	-- if opts.overriden_modules then
	-- M = vim.tbl_deep_extend("force", M, opts.overriden_modules())
	-- end
	local left = table.concat({
		C.pad(M.mode()),
		C.pad(M.file_info()),
		C.pad(M.git_branch()),
		C.pad(M.LSP_diagnostics()),
	})
	local center = M.LSP_progress()
	local right = C.join(" ", {
		C.pad(M.git_changes(), "", " |"),
		M.cursor_position(),
		M.file_encoding(),
		M.filetype(),
		M.LSP_status(),
		M.cwd(),
	})
	return left .. "%=" .. center .. "%=" .. right
end

return M
