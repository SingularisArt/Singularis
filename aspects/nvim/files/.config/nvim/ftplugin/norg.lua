local which_key = require("which-key")
local options = require("lazyvim.config.global").which_key_vars.options

options = vim.tbl_deep_extend("force", {
  filetype = "norg",
  buffer = vim.api.nvim_get_current_buf(),
}, options)

which_key.register({
  ["L"] = {
    name = "Language",
    i = { "<CMD>Telescope neorg insert_link<CR>", "Insert link" },
    f = { "<CMD>Telescope neorg find_linkable<CR>", "Find linkables" },
    F = { "<CMD>Telescope neorg find_aof_tasks<CR>", "Find AOF tasks" },
    s = { "<CMD>Telescope neorg search_headings<CR>", "Search headings" },
    S = { "<CMD>Telescope neorg switch_workspace<CR>", "Switch workspaces" },
    I = { "<CMD>Telescope neorg insert_file_link<CR>", "Insert file link" },
    p = { "<CMD>Telescope neorg find_project_tasks<CR>", "Find project tasks" },
    c = { "<CMD>Telescope neorg find_context_tasks<CR>", "Find context tasks" },
    a = { "<CMD>Telescope neorg find_aof_project_tasks<CR>", "Find AOF project tasks" },
    t = {
      name = "Todos",
      u = { "", "" },
      p = { "", "" },
      d = { "", "" },
      h = { "", "" },
      c = { "", "" },
      r = { "", "" },
      i = { "", "" },
      C = { "", "" },
    },
    g = {
      name = "GTD",
      c = { "", "" },
      v = { "", "" },
      e = { "", "" },
    },
  },
}, options)
