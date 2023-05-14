local icons = require("config.global").icons

local signature_help_setup = {
  bind = true,
  noice = true,
  doc_lines = 10,

  max_height = 10,
  max_width = 80,

  wrap = true,
  fix_pos = false,

  floating_window = true,
  floating_window_above_cur_line = true,
  floating_window_off_x = 1,
  floating_window_off_y = 0,

  hint_enable = true,
  hi_parameter = "LspSignatureActiveParameter",

  toggle_key = "<C-s>",
  -- select_signature_key = "<C-s>",

  hint_prefix = icons.misc.Squirrel .. " ",
  hint_scheme = "Comment",

  handler_opts = {
    border = "rounded",
  },
}

require("lsp_signature").setup(signature_help_setup)
