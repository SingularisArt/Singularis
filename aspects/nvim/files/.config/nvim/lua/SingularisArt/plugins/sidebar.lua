require("sidebar-nvim").setup({
  open = false,
  side = "left",
  initial_width = 32,
  hide_statusline = false,
  update_interval = 1000,
  section_separator = { "────────────────" },
  sections = { "files", "git", "symbols", "containers" },

  git = {
    icon = "",
  },
  symbols = {
    icon = "ƒ",
  },
  containers = {
    icon = "",
    attach_shell = "/bin/sh",
    show_all = true,
    interval = 5000,
  },
  datetime = { format = "%a%b%d|%H:%M", clocks = { { name = "local" } } },
  todos = { ignored_paths = { "~" } },
})
