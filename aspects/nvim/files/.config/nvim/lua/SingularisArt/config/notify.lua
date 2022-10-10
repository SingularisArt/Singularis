local notify = require("notify")
local icons = require("SingularisArt.icons")

local setup = {
  stages = "slide",
  on_open = nil,
  on_close = nil,
  timeout = 5000,
  render = "default",
  background_colour = "Normal",
  minimum_width = 50,
  icons = {
    ERROR = icons.diagnostics.Error,
    WARN = icons.diagnostics.Warning,
    INFO = icons.diagnostics.Information,
    DEBUG = icons.diagnostics.Debug,
    TRACE = icons.diagnostics.Trace,
  },
}

notify.setup(setup)
vim.notify = notify
