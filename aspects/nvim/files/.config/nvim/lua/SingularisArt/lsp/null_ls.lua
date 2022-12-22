local lsp = {}

local null_ls = require("null-ls")

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting

lsp.load = function()
  -- https://github.com/prettier-solidity/prettier-plugin-solidity
  -- npm install --save-dev prettier prettier-plugin-solidity
  null_ls.setup({
    debug = true,
    sources = {
      -- formatting.prettier.with({
      --   extra_filetypes = { "toml", "solidity" },
      --   extra_args = { "--arrow-parens always", "--trailing-comma all" },
      -- }),
      -- formatting.standardrb.with({
      --   extra_filetypes = { "--fix", "--format", "quiet", "--stderr", "--stdin", "$FILENAME" },
      -- }),
      formatting.black.with({
        extra_args = { "--fast" },
      }),
      formatting.clang_format,
      -- formatting.rustfmt,
      -- formatting.sql_formatter,
      -- formatting.stylua,
      -- formatting.google_java_format,
      formatting.shellharden,

      diagnostics.flake8,
      diagnostics.shellcheck,
      -- diagnostics.cpplint,
      -- diagnostics.chktex,
    },
  })
end

return lsp
