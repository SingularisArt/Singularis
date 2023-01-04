require("notify").setup({
  stages = "fade_in_slide_out",
  on_open = nil,
  on_close = nil,
  render = "default",
  timeout = 5000,
  minimum_width = 50,
  icons = {
    ERROR = "",
    WARN = "",
    INFO = "",
    DEBUG = "",
    TRACE = "✎",
  },
  background_colour = function()
    local group_bg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Normal")), "bg#")
    if group_bg == "" or group_bg == "none" then
      group_bg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Float")), "bg#")
      if group_bg == "" or group_bg == "none" then
        return "#000000"
      end
    end
    return group_bg
  end,
})

require("telescope").load_extension("notify")
