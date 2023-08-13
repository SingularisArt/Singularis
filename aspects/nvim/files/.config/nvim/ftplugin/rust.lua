local which_key = require("which-key")
local options = require("config.global").which_key_vars.options

local keymap = require("config.global").keymap
local opts = require("config.global").opts
local bufnr = vim.api.nvim_get_current_buf()

options = vim.tbl_deep_extend("force", {
  filetype = "rust",
  buffer = bufnr,
}, options)

which_key.register({
  ["L"] = {
    name = "Language",
    H = {
      name = "Hints",
      e = { "<cmd>RustEnableInlayHints<CR>", "Enable Inlay Hints" },
      d = { "<cmd>RustDisableInlayHints<CR>", "Disable Inlay Hints" },
    },
    d = { "<cmd>RustOpenExternalDocs<CR>", "Open Docs" },
    s = { "<cmd>RustSSR<CR>", "Structural Search Replace" },
    r = { "<cmd>RustRunnables<CR>", "Run Runnables" },
    R = { "<cmd>RustHoverRange<CR>", "Show Type in hover" },
    h = { "<cmd>RustHoverActions<CR>", "Hover Actions" },
    o = { "<cmd>RustOpenCargo<CR>", "Open Cargo" },
    p = { "<cmd>RustParentModule<CR>", "Parent Module" },
    j = { "<cmd>RustJoinLines<CR>", "Join Lines" },
    e = { "<cmd>RustExpandMacro<CR>", "Expand Macro" },
    U = { "<cmd>RustMoveItemUp<CR>", "Move Item Up" },
    D = { "<cmd>RustMoveItemDown<CR>", "Move Item Down" },
    v = { "<cmd>RustViewCrateGraph<CR>", "View Crate Graph" },
  },
}, options)

local dap = require("dap")
local mason_path = vim.fn.glob(vim.fn.stdpath("data")) .. "/mason/"
local codelldb_exec_path = mason_path .. "packages/codelldb/codelldb"

dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = {
    command = codelldb_exec_path,
    args = { "--port", "${port}" },
  },
}

dap.configurations.rust = {
  {
    name = "Launch",
    type = "codelldb",
    request = "launch",
    repl_lang = "rust",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    args = {},
  },
}
