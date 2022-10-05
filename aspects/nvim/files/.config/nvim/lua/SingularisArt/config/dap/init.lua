local dap = require("dap")
local dapui = require("dapui")
local icons = require("SingularisArt.icons")

local setup = {
  breakpoint = {
    text = icons.ui.Bug,
    texthl = "DiagnosticSignError",
    linehl = "",
    numhl = "",
  },
  breakpoint_rejected = {
    text = icons.ui.Bug,
    texthl = "LspDiagnosticsSignHint",
    linehl = "",
    numhl = "",
  },
  stopped = {
    text = icons.ui.BoldRightArrow,
    texthl = "DiagnosticSignWarn",
    linehl = "Visual",
    numhl = "DiagnosticSignWarn",
  },
  ui = {
    auto_open = true,
  },
}

vim.fn.sign_define("DapBreakpoint", setup.breakpoint)
vim.fn.sign_define("DapBreakpointRejected", setup.breakpoint_rejected)
vim.fn.sign_define("DapStopped", setup.stopped)

dapui.setup({
  expand_lines = true,
  icons = {
    expanded = "",
    collapsed = "",
    circular = "",
  },
  layouts = {
    {
      elements = {
        { id = "scopes", size = 0.33 },
        { id = "breakpoints", size = 0.17 },
        { id = "stacks", size = 0.25 },
        { id = "watches", size = 0.25 },
      },
      size = 0.33,
      position = "right",
    },
    {
      elements = { { id = "repl", size = 0.45 }, { id = "console", size = 0.55 } },
      size = 0.27,
      position = "bottom",
    },
  },
  floating = {
    max_width = 0.9,
    max_height = 0.5,
    border = vim.g.border_chars,
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
})

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end

require("SingularisArt.config.dap.c")
require("SingularisArt.config.dap.python")
