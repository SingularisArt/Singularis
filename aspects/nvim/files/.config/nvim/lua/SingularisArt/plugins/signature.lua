local icons = require("SingularisArt.icons")

local signature_help_setup = {
  bind = true,
  doc_lines = 0,
  max_height = 10,
  max_width = 80,
  wrap = true,
  floating_window = true,
  floating_window_above_cur_line = true,
  floating_window_off_x = 1,
  floating_window_off_y = 0,
  fix_pos = false,
  hint_enable = true,
  hi_parameter = "LspSignatureActiveParameter",
  toggle_key = "<C-x>",
  hint_prefix = icons.misc.Squirrel .. " ",
  hint_scheme = "Comment",
  handler_opts = {
    border = "rounded",
  },
}

require("lsp_signature").setup(signature_help_setup)
