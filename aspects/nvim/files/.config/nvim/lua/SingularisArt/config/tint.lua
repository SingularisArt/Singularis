local tint = require("tint")
tint.setup({
  bg = false,
  amt = -70,
  ignore = { "WinSeparator", "Status.*" },
  ignorefunc = function(winid)
    local buf = vim.api.nvim_win_get_buf(winid)
    local buftype
    vim.api.nvim_buf_get_option(buf, "buftype")

    if buftype == "terminal" then
      return true
    end

    return false
  end,
})
