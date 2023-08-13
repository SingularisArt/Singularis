local which_key = require("which-key")
local options = require("config.global").which_key_vars.options

options = vim.tbl_deep_extend("force", {
  filetype = "cpp",
  buffer = vim.api.nvim_get_current_buf(),
}, options)

which_key.register({
  ["L"] = {
    name = "Language",
    a = { "<CMD>ClangdAST<CR>", "Toggle AST" },
    i = { "<CMD>ClangdToggleInlayHints<CR>", "Toggle Inlay Hints" },
    s = { "<CMD>ClangdSwitchSourceHeader<CR>", "Switch Source Header" },
    K = { "<CMD>ClangdSymbolInfo<CR>", "Symbol Info" },
    h = { "<CMD>ClangdTypeHierarchy<CR>", "Type Hierarchy" },
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

dap.configurations.cpp = {
  {
    name = "Launch",
    type = "codelldb",
    request = "launch",
    repl_lang = "cpp",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    args = {},
  },
}
