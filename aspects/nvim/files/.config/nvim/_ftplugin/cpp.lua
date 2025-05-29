local which_key = require("which-key")
local options = require("config.global").which_key_vars.options

options = vim.tbl_deep_extend("force", {
  filetype = "cpp",
  buffer = vim.api.nvim_get_current_buf(),
}, options)

which_key.add({
  { "<Leader>L", group = "Language" },
  { "<Leader>La", "<CMD>ClangdAST<CR>", desc = "Toggle AST" },
  { "<Leader>Li", "<CMD>ClangdToggleInlayHints<CR>", desc = "Toggle Inlay Hints" },
  { "<Leader>Ls", "<CMD>ClangdSwitchSourceHeader<CR>", desc = "Switch Source Header" },
  { "<Leader>LK", "<CMD>ClangdSymbolInfo<CR>", desc = "Symbol Info" },
  { "<Leader>Lh", "<CMD>ClangdTypeHierarchy<CR>", desc = "Type Hierarchy" },
}, options)

-- local dap = require("dap")
-- local mason_path = vim.fn.glob(vim.fn.stdpath("data")) .. "/mason/"
-- local codelldb_exec_path = mason_path .. "packages/codelldb/codelldb"

-- dap.adapters.codelldb = {
--   type = "server",
--   port = "${port}",
--   executable = {
--     command = codelldb_exec_path,
--     args = { "--port", "${port}" },
--   },
-- }

-- dap.configurations.cpp = {
--   {
--     name = "Launch",
--     type = "codelldb",
--     request = "launch",
--     repl_lang = "cpp",
--     program = function()
--       return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
--     end,
--     cwd = "${workspaceFolder}",
--     stopOnEntry = false,
--     args = {},
--   },
-- }
