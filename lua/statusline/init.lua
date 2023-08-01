local M = {}
function M.setup(opts)
	vim.g.lsprogress_len = opts.lsprogress_len
	vim.opt.statusline = "%!v:lua.require('statusline.themes."
		.. opts.theme
		.. "').run()"
end
return M
