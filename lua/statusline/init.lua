local config = require("statusline.config")
local M = {}
function M.setup(opts)
	Statusline.opts =
		vim.tbl_deep_extend("force", config.defaults, opts or Statusline.opts)
	vim.g.lsprogress_len = opts.lsprogress_len
	vim.opt.statusline = "%!v:lua.require('statusline.themes."
		.. opts.theme
		.. "').run()"
end
return M
