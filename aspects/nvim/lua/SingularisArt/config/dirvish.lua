local M = {}

function M.setup()
	-- Seeing as SingularisArt.colorcolumn_filetype_blacklist doesn't work for this:
	SingularisArt.vim.setlocal("colorcolumn", "")
end

return M
