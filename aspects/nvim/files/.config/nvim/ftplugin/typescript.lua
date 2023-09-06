local which_key = require("which-key")
local options = require("config.global").which_key_vars.options

options = vim.tbl_deep_extend("force", {
  filetype = { "typescript", "typescriptreact" },
  buffer = vim.api.nvim_get_current_buf(),
}, options)

which_key.register({
  ["L"] = {
    name = "Language",
    d = { "<cmd>TSToolsGoToSourceDefinition<cr>", "Go to Source Definition" },
    f = { "<cmd>TSToolsFixAll<cr>", "Fix all fixable errors" },
    i = {
      name = "Imports",
      a = { "<cmd>TSToolsAddMissingImports<cr>", "Add missing imports" },
      o = { "<cmd>TSToolsOrganizeImports<cr>", "Organize imports" },
      r = { "<cmd>TSToolsRemoveUnusedImports<cr>", "Remove Unused Imports" },
      s = { "<cmd>TSToolsSortImports<cr>", "Sort Imports" },
    },
    r = { "<cmd>TSToolsRemoveUnused<cr>", "Removed Unused Statements" },
  },
}, options)

local dap = require("dap")

dap.adapters["pwa-node"] = {
  type = "server",
  host = "127.0.0.1",
  port = 8123,
  executable = {
    command = "js-debug-adapter",
  },
}

dap.configurations.typescript = {
  type = "pwa-node",
  request = "launch",
  name = "Launch file",
  program = "${file}",
  cwd = "${workspaceFolder}",
  runtimeExecutable = "node",
}
