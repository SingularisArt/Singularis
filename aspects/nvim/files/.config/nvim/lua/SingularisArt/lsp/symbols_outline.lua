local lsp = {}

lsp.load = function()
  require("symbols-outline").setup()
end

return lsp
