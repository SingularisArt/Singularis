local which_key = require("which-key")
local options = require("config.global").which_key_vars.options

options = vim.tbl_deep_extend("force", {
  filetype = "python",
  buffer = vim.api.nvim_get_current_buf(),
}, options)

which_key.register({
  ["L"] = {
    name = "Language",
  },
}, options)

local dap = require("dap")
dap.adapters.delve = {
  type = "server",
  port = "${port}",
  executable = {
    command = vim.fn.glob(os.getenv("HOME") .. "/.local/share/nvim/mason/packages/delve/dlv");
    args = { "dap", "-l", "127.0.0.1:${port}" },
  }
}

dap.configurations.go = {
  {
    type = "delve",
    name = "Debug",
    request = "launch",
    program = "${file}"
  },
  {
    type = "delve",
    name = "Debug test",
    request = "launch",
    mode = "test",
    program = "${file}"
  },
  {
    type = "delve",
    name = "Debug test (go.mod)",
    request = "launch",
    mode = "test",
    program = "./${relativeFileDirname}"
  }
}
