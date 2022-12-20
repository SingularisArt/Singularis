SingularisArt.lsp = SingularisArt.autoload("SingularisArt.lsp")

SingularisArt.lsp.load = function()
  require("neodev").setup()
  require("neoconf").setup()

  SingularisArt.lsp.handlers.load()
  SingularisArt.lsp.mason.load()
  SingularisArt.lsp.null_ls.load()
end

return SingularisArt.lsp
