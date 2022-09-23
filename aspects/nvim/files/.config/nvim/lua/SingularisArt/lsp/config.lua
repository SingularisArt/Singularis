local null_ls = require("null-ls")

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

return {
  servers = {
    "bashls",
    "clangd",
    "cssls",
    "cssmodules_ls",
    "emmet_ls",
    "golangci_lint_ls",
    "html",
    "jdtls",
    "jsonls",
    "pyright",
    "rust_analyzer",
    "solang",
    "solc",
    "solidity_ls",
    "sumneko_lua",
    "sqls",
    "tailwindcss",
    "texlab",
    "tsserver",
    "yamlls",
  },

  null_ls_sources = {
    formatting.prettier.with({
      extra_filetypes = { "toml", "solidity" },
      extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
    }),
    formatting.standardrb.with({
      extra_filetypes = { "--fix", "--format", "quiet", "--stderr", "--stdin", "$FILENAME" },
    }),
    formatting.black.with({
      extra_args = { "--fast" },
    }),
    formatting.clang_format,
    formatting.rustfmt,
    formatting.sql_formatter,
    formatting.stylua,
    formatting.google_java_format,
    formatting.shellharden,

    diagnostics.flake8,
    diagnostics.shellcheck,
    diagnostics.cppcheck,
  },
}
