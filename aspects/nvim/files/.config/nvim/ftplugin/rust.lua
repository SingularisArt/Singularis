local which_key = require("which-key")
local options = require("config.global").which_key_vars.options
local dap = require("dap")
local mason_path = vim.fn.glob(vim.fn.stdpath("data")) .. "/mason/"
local codelldb_exec_path = mason_path .. "packages/codelldb/codelldb"

options = vim.tbl_deep_extend("force", {
  filetype = "rust",
  buffer = vim.api.nvim_get_current_buf(),
}, options)

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
    -- repl_lang = "rust",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    args = {},
  },
}

which_key.register({
  ["L"] = {
    name = "Language",
    r = { "<cmd>RustRunnables<CR>", "Runnables" },
    t = { "<cmd>lua _CARGO_TEST()<CR>", "Cargo Test" },
    m = { "<cmd>RustExpandMacro<CR>", "Expand Macro" },
    c = { "<cmd>RustOpenCargo<CR>", "Open Cargo" },
    p = { "<cmd>RustParentModule<CR>", "Parent Module" },
    d = { "<cmd>RustDebuggables<CR>", "Debuggables" },
    v = { "<cmd>RustViewCrateGraph<CR>", "View Crate Graph" },
    R = {
      "<cmd>lua require('rust-tools/workspace_refresh')._reload_workspace_from_cargo_toml()<CR>",
      "Reload Workspace",
    },
    o = { "<cmd>RustOpenExternalDocs<CR>", "Open External Docs" },
  },
}, options)

-- require("SingularisArt.config.dap.c")
