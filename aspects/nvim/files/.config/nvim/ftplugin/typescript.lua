local which_key = require("which-key")
local options = require("config.global").which_key_vars.options

options = vim.tbl_deep_extend("force", {
  filetype = { "typescript", "typescriptreact" },
  buffer = vim.api.nvim_get_current_buf(),
}, options)

which_key.add({
  { "<Leader>L", group = "Language" },
  { "<Leader>Ld", "<cmd>TSToolsGoToSourceDefinition<cr>", desc = "Go to Source Definition" },
  { "<Leader>Lf", "<cmd>TSToolsFixAll<cr>", desc = "Fix all fixable errors" },
  { "<Leader>Lr", "<cmd>TSToolsRemoveUnused<cr>", desc = "Removed Unused Statements" },

  { "<Leader>Li", group = "Imports" },
  { "<Leader>Lia", "<cmd>TSToolsAddMissingImports<cr>", desc = "Add missing imports" },
  { "<Leader>Lio", "<cmd>TSToolsOrganizeImports<cr>", desc = "Organize imports" },
  { "<Leader>Lir", "<cmd>TSToolsRemoveUnusedImports<cr>", desc = "Remove Unused Imports" },
  { "<Leader>Lis", "<cmd>TSToolsSortImports<cr>", desc = "Sort Imports" },
}, options)

-- local dap = require("dap")

-- dap.adapters["pwa-node"] = {
--   type = "server",
--   host = "127.0.0.1",
--   port = 8123,
--   executable = {
--     command = "js-debug-adapter",
--   },
-- }

-- dap.configurations.typescript = {
--   type = "pwa-node",
--   request = "launch",
--   name = "Launch file",
--   program = "${file}",
--   cwd = "${workspaceFolder}",
--   runtimeExecutable = "node",
-- }
