local which_key = require("which-key")
local options = require("config.global").which_key_vars.options

local bufnr = vim.api.nvim_get_current_buf()

options = vim.tbl_deep_extend("force", {
  filetype = "rust",
  buffer = bufnr,
}, options)

which_key.add({
  { "<Leader>L", group = "Language" },
  { "<Leader>Ld", "<cmd>RustOpenExternalDocs<CR>", desc = "Open Docs" },
  { "<Leader>Ls", "<cmd>RustSSR<CR>", desc = "Structural Search Replace" },
  { "<Leader>Lr", "<cmd>RustRunnables<CR>", desc = "Run Runnables" },
  { "<Leader>LR", "<cmd>RustHoverRange<CR>", desc = "Show Type in hover" },
  { "<Leader>Lh", "<cmd>RustHoverActions<CR>", desc = "Hover Actions" },
  { "<Leader>Lo", "<cmd>RustOpenCargo<CR>", desc = "Open Cargo" },
  { "<Leader>Lp", "<cmd>RustParentModule<CR>", desc = "Parent Module" },
  { "<Leader>Lj", "<cmd>RustJoinLines<CR>", desc = "Join Lines" },
  { "<Leader>Le", "<cmd>RustExpandMacro<CR>", desc = "Expand Macro" },
  { "<Leader>LU", "<cmd>RustMoveItemUp<CR>", desc = "Move Item Up" },
  { "<Leader>LD", "<cmd>RustMoveItemDown<CR>", desc = "Move Item Down" },
  { "<Leader>Lv", "<cmd>RustViewCrateGraph<CR>", desc = "View Crate Graph" },

  { "<Leader>LH", group = "Hints" },
  { "<Leader>LHe", "<cmd>RustEnableInlayHints<CR>", desc = "Enable Inlay Hints" },
  { "<Leader>LHd", "<cmd>RustDisableInlayHints<CR>", desc = "Disable Inlay Hints" },
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

-- dap.configurations.rust = {
--   {
--     name = "Launch",
--     type = "codelldb",
--     request = "launch",
--     repl_lang = "rust",
--     program = function()
--       return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
--     end,
--     cwd = "${workspaceFolder}",
--     stopOnEntry = false,
--     args = {},
--   },
-- }
