local lsp = {}

local null_ls = require("null-ls")

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

lsp.load = function()
  -- https://github.com/prettier-solidity/prettier-plugin-solidity
  -- npm install --save-dev prettier prettier-plugin-solidity
  null_ls.setup({
    debug = true,
    sources = SingularisArt.lsp.config.null_ls_sources,
  })

  local unwrap = {
    method = null_ls.methods.DIAGNOSTICS,
    filetypes = { "rust" },
    generator = {
      fn = function(params)
        -- sources have access to a params object
        -- containing info about the current file and editor state
        for i, line in ipairs(params.content) do
          local col, end_col = line:find("unwrap()")
          if col and end_col then
            -- null-ls fills in undefined positions
            -- and converts source diagnostics into the required format
            table.insert(diagnostics, {
              row = i,
              col = col,
              end_col = end_col,
              source = "unwrap",
              message = "hey " .. os.getenv("USER") .. ", don't forget to handle this",
              severity = 2,
            })
          end
        end
        return diagnostics
      end,
    },
  }

  null_ls.register(unwrap)
end

return lsp
