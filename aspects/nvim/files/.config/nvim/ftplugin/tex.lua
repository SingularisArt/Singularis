if vim.g.isInkscape then
  return function(_use) end
end

require("config.options").tex()

local which_key = require("which-key")
local options = require("config.global").which_key_vars.options

local opts = require("config.global").opts
local keymap = require("config.global").keymap

options = vim.tbl_deep_extend("force", {
  filetype = "tex",
  buffer = vim.api.nvim_get_current_buf(),
}, options)

which_key.add({
  { "<Leader>L", group = "Language" },
  { "<Leader>Lm", "<CMD>VimtexContextMenu<CR>", desc = "Open Context Menu" },
  { "<Leader>Lu", "<CMD>VimtexCountLetters<CR>", desc = "Count Letters" },
  { "<Leader>Lw", "<CMD>VimtexCountWords<CR>", desc = "Count Words" },
  { "<Leader>Ld", "<CMD>VimtexDocPackage<CR>", desc = "Open Doc for package" },
  { "<Leader>Le", "<CMD>VimtexErrors<CR>", desc = "Look at the errors" },
  { "<Leader>Ls", "<CMD>VimtexStatus<CR>", desc = "Look at the status" },
  { "<Leader>La", "<CMD>VimtexToggleMain<CR>", desc = "Toggle Main" },
  { "<Leader>Lv", "<CMD>VimtexView<CR>", desc = "View pdf" },
  { "<Leader>Li", "<CMD>VimtexInfo<CR>", desc = "Vimtex Info" },
  { "<Leader>Lt", "<CMD>VimtexTocToggle<CR>", desc = "Toggle TOC" },

  { "<Leader>Ll", group = "Clean" },
  { "<Leader>Lll", "<CMD>VimtexClean<CR>", desc = "Clean Project" },
  { "<Leader>Llc", "<CMD>VimtexClean<CR>", desc = "Clean Cache" },

  { "<Leader>Lc", group = "Compile" },
  { "<Leader>Lcc", "<CMD>VimtexCompile<CR>", desc = "Compile Project" },
  { "<Leader>Lco", "<CMD>VimtexCompileOutput<CR>", desc = "Compile Project and Show Output", },
  { "<Leader>Lcs", "<CMD>VimtexCompileSS<CR>", desc = "Compile project super fast" },
  { "<Leader>Lce", "<CMD>VimtexCompileSelected<CR>", desc = "Compile Selected" },

  { "<Leader>Lr", group = "Reload" },
  { "<Leader>Lrr", "<CMD>VimtexReload<CR>", desc = "Reload" },
  { "<Leader>Lrs", "<CMD>VimtexReloadState<CR>", desc = "Reload State" },

  { "<Leader>Lo", group = "Stop" },
  { "<Leader>Lop", "<CMD>VimtexStop<CR>", desc = "Stop" },
  { "<Leader>Loa", "<CMD>VimtexStopAll<CR>", desc = "Stop All" },
}, options)

keymap(
  "n",
  "<C-f>",
  ":silent exec '!inkscape-figures edit \"'.b:vimtex.root.'/figures/\" > /dev/null 2>&1 &'<CR><CR>:redraw!<CR>",
  opts,
  "Create new figure."
)
