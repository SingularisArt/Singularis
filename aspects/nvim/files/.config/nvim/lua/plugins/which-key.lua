local setup = {
  plugins = {
    marks = true,
    registers = true,
    spelling = {
      enabled = true,
      suggestions = 20,
    },
    presets = {
      operators = false,
      motions = false,
      text_objects = false,
      windows = true,
      nav = true,
      z = true,
      g = true,
    },
  },
  key_labels = {
    ["<leader>"] = "SPC",
  },
  icons = {
    breadcrumb = "»",
    separator = "➜",
    group = "+",
  },
  popup_mappings = {
    scroll_down = "<c-d>",
    scroll_up = "<c-u>",
  },
  window = {
    border = "rounded",
    position = "bottom",
    margin = { 1, 0, 1, 0 },
    padding = { 2, 2, 2, 2 },
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 25 },
    width = { min = 20, max = 50 },
    spacing = 3,
    align = "center",
  },
  ignore_missing = true,
  hidden = { "<silent>", "<CMD>", "<CMD>", "<CR>", "call", "lua", "^:", "^ " },
  show_help = false,
  triggers_blacklist = {
    i = { "j", "k" },
    v = { "j", "k" },
  },
}

local vars = require("SingularisArt.core.global").which_key_vars

vars.vmappings["/"] = {
  "<ESC><CMD>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
  "Comment",
}

vars.mappings["v"] = { "<CMD>vsplit<CR>", "Vertical Split" }
vars.mappings["h"] = { "<CMD>split<CR>", "Horizontal Split" }
vars.mappings[" "] = { "<CMD>normal <C-^><CR>", "Jump to previous buffer" }
vars.mappings["/"] = { "<CMD>lua require('Comment.api').toggle.linewise()<CR>", "Comment out current line" }
vars.mappings["e"] = { "<CMD>NvimTreeToggle<CR>", "Toggle NvimTree" }
vars.mappings["-"] = { "<CMD>lua require('lir.float').toggle()<CR>", "Toggle Lir" }
vars.mappings["c"] = { "<Plug>(Corpus)", "Corpus" }
vars.mappings["C"] = { "<CMD>lua codewindow.toggle_minimap()<CR>", "Toggle codewindow" }
vars.mappings["z"] = { "<CMD>ZenMode<CR>", "Zen Mode" }

vars.mappings["g"] = {
  name = "Git",
  j = { "<CMD>lua require 'gitsigns'.next_hunk()<CR>", "Next Hunk" },
  k = { "<CMD>lua require 'gitsigns'.prev_hunk()<CR>", "Prev Hunk" },
  l = { "<CMD>lua require 'gitsigns'.blame_line()<CR>", "Blame" },
  p = { "<CMD>lua require 'gitsigns'.preview_hunk()<CR>", "Preview Hunk" },
  r = { "<CMD>lua require 'gitsigns'.reset_hunk()<CR>", "Reset Hunk" },
  R = { "<CMD>lua require 'gitsigns'.reset_buffer()<CR>", "Reset Buffer" },
  s = { "<CMD>lua require 'gitsigns'.stage_hunk()<CR>", "Stage Hunk" },
  u = {
    "<CMD>lua require 'gitsigns'.undo_stage_hunk()<CR>",
    "Undo Stage Hunk",
  },
  o = { "<CMD>Telescope git_status<CR>", "Open changed file" },
  b = { "<CMD>Telescope git_branches<CR>", "Checkout branch" },
  c = { "<CMD>Telescope git_commits<CR>", "Checkout commit" },
  C = {
    "<CMD>Telescope git_bcommits<CR>",
    "Checkout commit(for current file)",
  },
  d = {
    "<CMD>Gitsigns diffthis HEAD<CR>",
    "Git Diff",
  },
}

vars.mappings["s"] = {
  name = "Search",
  f = { "<CMD>Telescope find_files<CR>", "Fuzzy find files" },
  g = { "<CMD>Telescope grep_string<CR>", "Fuzzy find string" },
  b = { "<CMD>Telescope buffers<CR>", "Fuzzy find buffers" },
  l = { "<CMD>Telescope live_grep<CR>", "Fuzzy find words" },
  s = { "<CMD>Telescope symbols<CR>", "Fuzzy find symbols" },
  d = { "<CMD>Telescope diagnostics<CR>", "Fuzzy find diagnostics" },
  c = { function()
    require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
      winblend = 10,
      previewer = false,
    })
  end, "Fuzzily search in current buffer" }
}

vars.mappings["o"] = {
  name = "Only",
  o = {
    name = "Close",
    o = {
      "<CMD>wincmd _ | wincmd |<CR>",
      "Minimize all tabs (you can always bring them back with <Leader>oO)",
    },
    O = {
      "<CMD>only<CR>",
      "Close all tabs",
    },
  },
  O = { "<CMD>wincmd =<CR>", "Bring back the tabs" },
}

vars.mappings["T"] = {
  name = "Translator",
  t = { "<CMD>Translate --engines=google<CR>", "Translate" },
  h = { "<CMD>TranslateH --engines=google<CR>", "Translate History" },
  l = { "<CMD>TranslateL --engines=google<CR>", "Translate Log" },
  r = { "<CMD>TranslateR --engines=google<CR>", "Translate" },
  w = {
    "<CMD>TranslateW --engines=google<CR>",
    "Translate and display in a Popup Window",
  },
  x = {
    "<CMD>TranslateX --engines=google<CR>",
    "Translate and Display in the cmdline",
  },
}

vars.mappings["d"] = {
  name = "Debug",
  t = { "<CMD>lua require('dap').toggle_breakpoint()<CR>", "Toggle Breakpoint" },
  b = { "<CMD>lua require('dap').step_back()<CR>", "Step Back" },
  c = { "<CMD>lua require('dap').continue()<CR>", "Continue" },
  C = { "<CMD>lua require('dap').run_to_cursor()<CR>", "Run To Cursor" },
  d = { "<CMD>lua require('dap').disconnect()<CR>", "Disconnect" },
  g = { "<CMD>lua require('dap').session()<CR>", "Get Session" },
  i = { "<CMD>lua require('dap').step_into()<CR>", "Step Into" },
  o = { "<CMD>lua require('dap').step_over()<CR>", "Step Over" },
  u = { "<CMD>lua require('dap').step_out()<CR>", "Step Out" },
  p = { "<CMD>lua require('dap').pause()<CR>", "Pause" },
  r = { "<CMD>lua require('dap').repl.toggle()<CR>", "Toggle Repl" },
  s = { "<CMD>lua require('dap').continue()<CR>", "Start" },
  q = { "<CMD>lua require('dap').close()<CR>", "Quit" },
  U = { "<CMD>lua require('dapui').toggle()<CR>", "Enable/Disable UI" },
}

local which_key = require("which-key")

which_key.setup(setup)
which_key.register(vars.mappings, vars.options)
which_key.register(vars.vmappings, vars.voptions)
