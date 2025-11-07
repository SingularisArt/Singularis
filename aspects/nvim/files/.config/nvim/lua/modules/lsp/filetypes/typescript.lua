local M = {}

P = function(v)
  print(vim.print(v))
  return v
end

M.typescript_tools = function(settings, on_attach)
  local baseDefinitionHandler = vim.lsp.handlers["textDocument/definition"]

  local filter = require("util").filter
  local filterReactDTS = require("util").filter_react_dts

  local handlers = {
    ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
      silent = true,
      border = "rounded",
    }),
    ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
    ["textDocument/publishDiagnostics"] = vim.lsp.with(
      vim.lsp.diagnostic.on_publish_diagnostics,
      { virtual_text = false }
    ),
    ["textDocument/definition"] = function(err, result, method, ...)
      P(result)
      if vim.tbl_islist(result) and #result > 1 then
        local filtered_result = filter(result, filterReactDTS)
        return baseDefinitionHandler(err, filtered_result, method, ...)
      end

      baseDefinitionHandler(err, result, method, ...)
    end,
  }

  require("typescript-tools").setup({
    on_attach = on_attach,
    handlers = handlers,
    settings = settings,
  })
end

return M
