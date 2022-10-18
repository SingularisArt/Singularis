local null_ls = require("null-ls")

local icons = require("SingularisArt.icons")

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

return {
  ensure_installed = {
    -- "bashls",
    -- "clangd",
    -- "cssls",
    -- "cssmodules_ls",
    -- "emmet_ls",
    -- "html",
    -- "golangci_lint_ls",
    -- "jdtls",
    -- "jsonls",
    -- "pyright",
    -- "rust_analyzer",
    -- "solang",
    -- "solc",
    -- "solidity_ls",
    -- "sqls",
    -- "tailwindcss",
    -- -- "ltex-ls",
    -- "texlab",
    -- "tsserver",
    -- "sumneko_lua",
    -- "yamlls",
    -- "prettier",
    -- "standardrb",
    -- "black",
    -- "clang-format",
    -- "sql-formatter",
    -- "stylua",
    -- "shellharden",
    -- "flake8",
    -- "shellcheck",
    -- "cpplint",
  },
  servers = {
    { filetype = "sh", server = "bashls" },
    { filetype = { "cpp", "c" }, server = "clangd" },
    { filetype = "css", server = { "cssls", "cssmodules_ls" } },
    { filetype = "html", server = { "emmet_ls", "html" } },
    { filetype = "go", server = "golangci_lint_ls" },
    { filetype = "java", server = "jdtls" },
    { filetype = "json", server = "jsonls" },
    { filetype = "python", server = "pyright" },
    { filetype = "rust", server = "rust_analyzer" },
    { filetype = "solidity", server = { "solang", "solc", "solidity_ls" } },
    { filetype = "sql", server = "sqls" },
    -- { command = "tailwindcss"},
    { filetype = "tex", server = "texlab" },
    -- { filetype = "tex", server = "ltex" },
    { filetype = { "javascript", "typescript" }, server = "tsserver" },
    { filetype = "lua", server = "sumneko_lua" },
    { filetype = "yaml", server = "yamlls" },
  },

  null_ls_sources = {
    formatting.prettier.with({
      extra_filetypes = { "toml", "solidity" },
      extra_args = { "--arrow-parens always", "--trailing-comma all" },
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
    diagnostics.cpplint,
    -- diagnostics.chktex,
  },

  peek = {
    max_height = 15,
    max_width = 30,
    context = 10,
  },

  diagnostics = {
    signs = {
      active = true,
      values = {
        { name = "DiagnosticSignError", text = icons.diagnostics.Error },
        { name = "DiagnosticSignWarn", text = icons.diagnostics.Warning },
        { name = "DiagnosticSignHint", text = icons.diagnostics.Hint },
        { name = "DiagnosticSignInfo", text = icons.diagnostics.Information },
      },
    },
    virtual_text = false,
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
  },
}
