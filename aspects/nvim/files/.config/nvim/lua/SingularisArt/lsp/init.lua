SingularisArt.lsp = SingularisArt.autoload("SingularisArt.lsp")

SingularisArt.lsp.load = function()
  SingularisArt.lsp.handlers.load()
  SingularisArt.lsp.mason.load()
  SingularisArt.lsp.null_ls.load()
end

return SingularisArt.lsp
