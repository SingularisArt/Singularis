local null_ls = require("null-ls")

local diagnostics = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting
local actions = null_ls.builtins.code_actions
local code_actions = null_ls.builtins.code_actions

local sources = {
  formatting.rustfmt,
  formatting.google_java_format,
  formatting.sql_formatter,
  formatting.stylua,
  formatting.shellharden,
  formatting.clang_format,
  formatting.trim_newlines,
  formatting.trim_whitespace,
  formatting.prettier.with({
    extra_filetypes = { "toml", "solidity" },
    extra_args = { "--arrow-parens always", "--trailing-comma all" },
  }),
  formatting.golines.with({
    extra_args = {
      "--max-len=180",
      "--base-formatter=gofumpt",
    },
  }),
  formatting.standardrb.with({
    extra_filetypes = { "--fix", "--format", "quiet", "--stderr", "--stdin", "$FILENAME" },
  }),
  formatting.black.with({
    extra_args = { "--fast" },
  }),

  diagnostics.yamllint,
  diagnostics.shellcheck,
  diagnostics.golangci_lint,

  code_actions.gitsigns,
  code_actions.proselint,
  -- code_actions.refactoring,

  diagnostics.misspell.with({
    filetypes = { "markdown", "text", "txt" },
    args = { "$FILENAME" },
  }),
  diagnostics.write_good.with({
    filetypes = { "markdown" },
    extra_filetypes = { "txt", "text" },
    args = { "--text=$TEXT", "--parse" },
    command = "write-good",
  }),
  diagnostics.proselint.with({
    filetypes = { "markdown", },
    extra_filetypes = { "txt", "text" },
    command = "proselint",
    args = { "--json" },
  }),

  actions.proselint.with({ filetypes = { "markdown" }, command = "proselint", args = { "--json" } }),
}

table.insert(
  sources,
  require("null-ls.helpers").make_builtin({
    method = require("null-ls.methods").internal.DIAGNOSTICS,
    filetypes = { "java" },
    generator_opts = {
      command = "java",
      args = { "$FILENAME" },
      to_stdin = false,
      format = "raw",
      from_stderr = true,
      on_output = require("null-ls.helpers").diagnostics.from_errorformat([[%f:%l: %trror: %m]], "java"),
    },
    factory = require("null-ls.helpers").generator_factory,
  })
)

local setup = {
  sources = sources,
  debounce = 1000,
  default_timeout = 3000,
  fallback_severity = vim.diagnostic.severity.WARN,
  root_dir = require("lspconfig").util.root_pattern(
    ".null-ls-root",
    "Makefile",
    ".git",
    "go.mod",
    "main.go",
    "package.json",
    "tsconfig.json"
  ),
  on_init = function(new_client, _)
    if vim.tbl_contains({ "h", "cpp", "c" }, vim.o.ft) then
      new_client.offset_encoding = "utf-16"
    end
  end,
  on_attach = function(client)
    -- if client.server_capabilities.documentFormatting then
    --   vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
    -- end
  end,
}

null_ls.setup(setup)
