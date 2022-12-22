local lsp = {}

lsp.load = function()
  require("SingularisArt.lsp.handlers").load()
  require("SingularisArt.lsp.mason").load()
  require("SingularisArt.lsp.null_ls").load()
end

return lsp
