SingularisArt.lsp = SingularisArt.autoload("SingularisArt.lsp")

SingularisArt.lsp.diagnostics = {
	signs = {
		active = true,
		values = {
			{ name = "DiagnosticSignError", text = "" },
			{ name = "DiagnosticSignWarn", text = "" },
			{ name = "DiagnosticSignHint", text = "" },
			{ name = "DiagnosticSignInfo", text = "" },
		},
	},
	virtual_text = true,
	update_in_insert = false,
	underline = true,
	severity_sort = true,
	float = {
		focusable = false,
		style = "minimal",
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
		format = function(d)
			local t = vim.deepcopy(d)
			local code = d.code or (d.user_data and d.user_data.lsp.code)
			if code then
				t.message = string.format("%s [%s]", t.message, code):gsub("1. ", "")
			end
			return t.message
		end,
	},
}

SingularisArt.lsp.load = function()
	SingularisArt.lsp.illuminate.load()
	SingularisArt.lsp.mason.load()
	SingularisArt.lsp.null_ls.load()
	SingularisArt.lsp.signature.load()
	SingularisArt.lsp.symbols_outline.load()
	SingularisArt.lsp.inlay_hints.load()
end

return SingularisArt.lsp
