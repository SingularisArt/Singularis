return {
  filtypes = { "go", "gomod", "gowork", "gotmpl" },
  cmd = {'gopls', '--remote=auto'},
  settings = {
    gopls = {
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
      staticcheck = true,
      semanticTokens = true,
    },
  },
  golangci_lint_ls = {},
}
