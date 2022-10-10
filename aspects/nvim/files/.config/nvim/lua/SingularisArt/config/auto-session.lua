local auto_session = require("auto-session")
local telescope = require("telescope")
local session_lens = require("session-lens")

local opts = {
  log_level = "info",
  auto_session_enable_last_session = false,
  auto_session_root_dir = vim.fn.stdpath("data") .. "/misc/sessions/",
  auto_session_enabled = true,
  auto_save_enabled = nil,
  auto_restore_enabled = nil,
  -- auto_session_suppress_dirs = {
  --   vim.fn.glob(vim.fn.stdpath "config" .. "/*"),
  --   os.getenv("HOME"),
  --   os.getenv "HOME" .. "/Machfiles",
  -- },
  auto_session_use_git_branch = nil,
  -- the configs below are lua only
  bypass_session_save_file_types = { "alpha" },
}

vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"

telescope.load_extension("session-lens")

session_lens.setup({
  path_display = { "shorten" },
  -- theme_conf = { border = false },
  previewer = false,
  prompt_title = "Sessions",
})

auto_session.setup(opts)
