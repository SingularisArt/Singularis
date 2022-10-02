SingularisArt.lsp = SingularisArt.autoload("SingularisArt.lsp")

SingularisArt.lsp.load = function()
  SingularisArt.lsp.handlers.load()
  SingularisArt.lsp.mason.load()
  SingularisArt.lsp.null_ls.load()
  SingularisArt.lsp.illuminate.load()
  SingularisArt.lsp.signature.load()
  -- SingularisArt.lsp.symbols_outline.load()
  SingularisArt.lsp.inlay_hints.load()
end

return SingularisArt.lsp
