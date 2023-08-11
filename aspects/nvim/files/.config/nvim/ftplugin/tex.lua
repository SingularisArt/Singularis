vim.cmd([[
  setlocal fillchars=fold:\
  setlocal foldlevel=0
  setlocal foldmethod=expr
  setlocal foldexpr=vimtex#fold#level(v:lnum)
  setlocal foldtext=vimtex#fold#text()
]])

local which_key = require("which-key")
local options = require("config.global").which_key_vars.options

local opts = require("config.global").opts
local keymap = require("config.global").keymap

options = vim.tbl_deep_extend("force", {
  filetype = "tex",
  buffer = vim.api.nvim_get_current_buf(),
}, options)

which_key.register({
  ["L"] = {
    name = "Language",
    m = { "<cmd>VimtexContextMenu<CR>", "Open Context Menu" },
    u = { "<cmd>VimtexCountLetters<CR>", "Count Letters" },
    w = { "<cmd>VimtexCountWords<CR>", "Count Words" },
    d = { "<cmd>VimtexDocPackage<CR>", "Open Doc for package" },
    e = { "<cmd>VimtexErrors<CR>", "Look at the errors" },
    s = { "<cmd>VimtexStatus<CR>", "Look at the status" },
    a = { "<cmd>VimtexToggleMain<CR>", "Toggle Main" },
    v = { "<cmd>VimtexView<CR>", "View pdf" },
    i = { "<cmd>VimtexInfo<CR>", "Vimtex Info" },
    l = {
      name = "Clean",
      l = { "<cmd>VimtexClean<CR>", "Clean Project" },
      c = { "<cmd>VimtexClean<CR>", "Clean Cache" },
    },
    c = {
      name = "Compile",
      c = { "<cmd>VimtexCompile<CR>", "Compile Project" },
      o = {
        "<cmd>VimtexCompileOutput<CR>",
        "Compile Project and Show Output",
      },
      s = { "<cmd>VimtexCompileSS<CR>", "Compile project super fast" },
      e = { "<cmd>VimtexCompileSelected<CR>", "Compile Selected" },
    },
    r = {
      name = "Reload",
      r = { "<cmd>VimtexReload<CR>", "Reload" },
      s = { "<cmd>VimtexReloadState<CR>", "Reload State" },
    },
    o = {
      name = "Stop",
      p = { "<cmd>VimtexStop<CR>", "Stop" },
      a = { "<cmd>VimtexStopAll<CR>", "Stop All" },
    },
    t = {
      name = "TOC",
      o = { "<cmd>VimtexTocOpen<CR>", "Open TOC" },
      t = { "<cmd>VimtexTocToggle<CR>", "Toggle TOC" },
    },
  },
}, options)

keymap(
  "n",
  "<C-f>",
  ":silent exec '!inkscape-figures edit \"'.b:vimtex.root.'/figures/\" > /dev/null 2>&1 &'<CR><CR>:redraw!<CR>",
  opts,
  "Create new figure."
)
