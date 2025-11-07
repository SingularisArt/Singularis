local config = {}

function config.gitsigns()
  local gitsigns = require("gitsigns")
  local setup = {
    signs = {
      add = { text = "▎" },
      change = { text = "▎" },
      delete = { text = "▎" },
      topdelete = { text = "▎" },
      changedelete = { text = "▎" },
    },
    numhl = false,
    linehl = false,
    signcolumn = true,
    word_diff = false,
    attach_to_untracked = true,
    current_line_blame = false,
    max_file_length = 40000,
    preview_config = {
      border = "rounded",
      style = "minimal",
      relative = "cursor",
      row = 0,
      col = 1,
    },
    watch_gitdir = {
      interval = 1000,
      follow_files = true,
    },
    sign_priority = 6,
    update_debounce = 200,
    status_formatter = nil,
  }

  gitsigns.setup(setup)
end

return config
