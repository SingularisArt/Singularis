-- local util = require("lspconfig.util")

return {
  -- root_dir = util.root_pattern("go.mod", "go.work", ".git"),
  filtypes = { "go", "gomod", "gowork", "gotmpl" },
  settings = {
    gopls = {
      staticcheck = true,
      semanticTokens = true,
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
      },
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
    },
  },
}
