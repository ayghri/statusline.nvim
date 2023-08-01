local fn = vim.fn
local Mods = require("statusline.modes")
local M = {}

-- numbers on severity or 0
local function count_severity(severity)
	local a = #vim.diagnostic.get(0, { severity = severity })
	return ((a and a > 0) and a) or 0
end

-- same as python elements.join(char) but skips empty elements
M.join = function(char, elements)
	local result = ""
	for i, e in ipairs(elements) do
		if e ~= "" then
			result = result .. e .. (((i < #elements) and char) or "")
		end
	end
	return result
end

-- replace "%#?#A%#B#" -> "%#?#" .. left_p .. "A%#B#"
-- .- for lazy match
M.pad = function(text, left_p, right_p)
	if text == "" then
		return ""
	end
	return string.gsub(text, "(%%#.-#)(.*)", "%1" .. (left_p or " ") .. "%2")
		.. (right_p or " ")
end

-- returns the mode string and its highlight group
M.get_mode = function()
	local m = vim.api.nvim_get_mode().mode
	return { mode = Mods[m][1], highlight = "%#" .. Mods[m][2] .. "#" }
end

M.get_cwd = function()
	return fn.fnamemodify(fn.getcwd(), ":t")
end

-- returns the filename and find a icon for filetype, uses web-devicons
M.file_info = function()
	local icon = "󰈚"
	local filename = (fn.expand("%") == "" and "") or fn.expand("%:t")

	if filename ~= "" then
		local devicons_present, devicons = pcall(require, "nvim-web-devicons")
		if devicons_present then
			local ft_icon = devicons.get_icon(filename)
			if ft_icon ~= nil then
				icon = ft_icon
			end
		end
	end
	return { name = filename, icon = icon }
end

M.filetype = function()
  return vim.bo.ft
end
---------- Git stuff
M.get_branch = function()
	if not vim.b.gitsigns_git_status then
		return ""
	end
	if vim.b.gitsigns_status_dict.head ~= "" then
		return vim.b.gitsigns_status_dict.head
	else
		return "?"
	end
end
-- M.check_git = function(num_changes, color)
-- 	if num_changes and num_changes ~= 0 then
-- 		return M.join(" ", { color, num_changes })
-- 	end
-- 	return ""
-- end

M.get_changes = function()
	if not vim.b.gitsigns_head or vim.b.gitsigns_git_status then
		return nil
	end

	local git_status = vim.b.gitsigns_status_dict
	return {
		added = git_status.added or 0,
		changed = git_status.changed or 0,
		removed = git_status.removed or 0,
	}
end

-- return "" if no client, LSP if null-ls, client otherwise
M.LSP_client = function()
	if rawget(vim, "lsp") then
		for _, client in ipairs(vim.lsp.get_active_clients()) do
			if client.attached_buffers[vim.api.nvim_get_current_buf()] then
				return (client.name == "null-ls" and "LSP") or client.name
			end
		end
	end
	return ""
end

M.LSP_severities = function()
	if not rawget(vim, "lsp") then
		return {}
	end
	return {
		error_count = count_severity(vim.diagnostic.severity.ERROR),
		warning_count = count_severity(vim.diagnostic.severity.WARN),
		hint_count = count_severity(vim.diagnostic.severity.HINT),
		info_count = count_severity(vim.diagnostic.severity.INFO),
	}
end

M.get_cyclic_counter = function(max_counter)
	local ms = vim.loop.hrtime() / 1000000
	return math.floor(ms / 120) % max_counter
end

M.LSP_message = function()
	if not rawget(vim, "lsp") or vim.lsp.status then
		return ""
	end
	local lsp = vim.lsp.util.get_progress_messages()[1]
	if not lsp then
		return ""
	end

	local msg = lsp.message or ""
	local percentage = lsp.percentage or 0
	local title = lsp.title or ""
	return { message = msg, title = title, percentage = percentage }
end
return M
