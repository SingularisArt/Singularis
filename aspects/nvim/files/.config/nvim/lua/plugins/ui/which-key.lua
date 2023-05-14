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

local vars = require("config.global").which_key_vars

vars.vmappings["/"] = {
  "<ESC><CMD>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
  "Comment",
}

vars.mappings["v"] = { "<CMD>vsplit<CR>", "Vertical Split" }
vars.mappings["h"] = { "<CMD>split<CR>", "Horizontal Split" }
vars.mappings[" "] = { "<CMD>normal <C-^><CR>", "Jump to previous buffer" }
vars.mappings["/"] = { "<CMD>lua require('Comment.api').toggle.linewise()<CR>", "Comment out current line" }
vars.mappings["e"] = { "<CMD>Neotree toggle<CR>", "Toggle Neotree" }
vars.mappings["-"] = { "<CMD>lua require('lir.float').toggle()<CR>", "Toggle Lir" }
vars.mappings["z"] = { "<CMD>ZenMode<CR>", "Zen Mode" }
vars.mappings["t"] = { "<CMD>lua require('alternate-toggler').toggleAlternate()<CR>", "Alternate" }

vars.mappings["g"] = {
  name = "Git",
  j = { "<CMD>lua require('gitsigns').next_hunk()<CR>", "Next Hunk" },
  k = { "<CMD>lua require('gitsigns').prev_hunk()<CR>", "Prev Hunk" },
  l = { "<CMD>lua require('gitsigns').blame_line()<CR>", "Blame" },
  p = { "<CMD>lua require('gitsigns').preview_hunk()<CR>", "Preview Hunk" },
  r = { "<CMD>lua require('gitsigns').reset_hunk()<CR>", "Reset Hunk" },
  R = { "<CMD>lua require('gitsigns').reset_buffer()<CR>", "Reset Buffer" },
  s = { "<CMD>lua require('gitsigns').stage_hunk()<CR>", "Stage Hunk" },
  u = {
    "<CMD>lua require('gitsigns').undo_stage_hunk()<CR>",
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

-- vars.mappings["H"] = {
-- }

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

vars.mappings["n"] = {
  name = "Neotest",
  a = { "<CMD>lua require('neotest').run.attach()<CR>", "Attach to the nearest test" },
  c = { "<CMD>lua require('neotest').run.run(vim.fn.expand('%'))<CR>", "Run the current file" },
  d = { "<CMD>lua require('neotest').run.run({strategy = 'dap'})<CR>", "Debug the nearest test" },
  e = { "<CMD>lua require('neotest').output.open({ enter = true, auto_close = true })<CR>", "Open the output of a test result" },
  j = { "<CMD>lua require('neotest').jump.prev({ status = 'failed' })<CR>", "Jump to next error" },
  k = { "<CMD>lua require('neotest').jump.next({ status = 'failed' })<CR>", "Jump to previous error" },
  n = { "<CMD>lua require('neotest').run.run()<CR>", "Run the nearest test" },
  s = { "<CMD>lua require('neotest').run.stop()<CR>", "Stop the nearest test" },
  S = { "<CMD>lua require('neotest').summary.toggle()<CR>", "Toggle the summary window" },
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

vars.mappings["S"] = {
  name = "Sessions",
  l = { "<CMD>Telescope sessions list<CR>", "List sessions" },
  n = { "<CMD>Telescope sessions new<CR>", "New session" },
  u = { "<CMD>Telescope sessions update<CR>", "Update current session" },
}

vars.mappings["p"] = {
  name = "Pommodoro",
  w = { "<CMD>require('pommodoro-clock').start_work()<CR>", "Start Pommodoro" },
  s = { "<CMD>require('start_short_break').start_work()<CR>", "Short Break" },
  l = { "<CMD>require('start_long_break').start_work()<CR>", "Long Break" },
  c = { "<CMD>require('toggle_pause').start_work()<CR>", "Toggle Pause" },
  C = { "<CMD>require('close').start_work()<CR>", "Close" },
}

vars.mappings["H"] = {
  a = { "<CMD>lua require('harpoon.mark').add_file()<CR>", "Add file to harpoon" },
  h = { "<CMD>lua require('harpoon.ui').toggle_quick_menu()<CR>", "View harpoon" },
  n = { "<CMD>lua require('harpoon.ui').nav_next()<CR>", "Navigates to next harpoon mark" },
  p = { "<CMD>lua require('harpoon.ui').nav_prev()<CR>", "Navigates to previous harpoon mark" },
}

vars.mappings["b"] = {
  name = "Buffers",
  ["1"] = { "<CMD>BufferLineGoToBuffer 1<CR>", "Go to the first buffer" },
  ["2"] = { "<CMD>BufferLineGoToBuffer 2<CR>", "Go to the second buffer" },
  ["3"] = { "<CMD>BufferLineGoToBuffer 3<CR>", "Go to the third buffer" },
  ["4"] = { "<CMD>BufferLineGoToBuffer 4<CR>", "Go to the fourth buffer" },
  ["5"] = { "<CMD>BufferLineGoToBuffer 5<CR>", "Go to the fifth buffer" },
  ["6"] = { "<CMD>BufferLineGoToBuffer 6<CR>", "Go to the sixth buffer" },
  ["7"] = { "<CMD>BufferLineGoToBuffer 7<CR>", "Go to the seventh buffer" },
  ["8"] = { "<CMD>BufferLineGoToBuffer 8<CR>", "Go to the eighth buffer" },
  ["9"] = { "<CMD>BufferLineGoToBuffer 9<CR>", "Go to the ninth buffer" },
  ["0"] = { "<CMD>BufferLineGoToBuffer 10<CR>", "Go to the tenth buffer" },
  n = { "<CMD>BufferLineCycleNext<CR>", "Go to the next buffer" },
  p = { "<CMD>BufferLineCyclePrev<CR>", "Go to the previous buffer" },
  k = { "<CMD>BufferKill<CR>", "Kill current buffer" },
  c = {
    name = "Close",
    l = { "<CMD>BufferLineCloseLeft<CR>", "Close all buffers to the left" },
    r = { "<CMD>BufferLineCloseRight<CR>", "Close all buffers to the right" },
  },
  m = {
    name = "Move",
    n = { "<CMD>BufferLineMoveNext<CR>", "Move buffer next" },
    p = { "<CMD>BufferLineMovePrev<CR>", "Move buffer prev" },
  },
  P = {
    name = "Pick",
    p = { "<CMD>BufferLinePick<CR>", "Pick buffer" },
    P = { "<CMD>BufferLinePickClose<CR>", "Pick buffer to close" },
  },
  s = {
    name = "Sort",
    d = { "<CMD>BufferLineSortByDirectory<CR>", "Sort by directory" },
    e = { "<CMD>BufferLineSortByExtension<CR>", "Sort by extension" },
    r = { "<CMD>BufferLineSortByRelativeDirectory<CR>", "Sort by relative directory" },
    t = { "<CMD>BufferLineSortByTabs<CR>", "Sort by tabs" },
  },
}

vars.mappings["N"] = {}

vars.mappings["N"] = {
  name = "NeoAI",
  t = { "<CMD>NeoAIToggle<CR>", "Toggle NeoAI" },
  c = { "<CMD>NeoAIContext<CR>", "NeoAI Context" },
  i = {
    name = "Inject",
    c = { "<CMD>NeoAIInjectCode<CR>", "Inject Code" },
    t = { "<CMD>NeoAIInjectContext<CR>", "Inject Context" },
    C = { "<CMD>NeoAIInjectContextCode<CR>", "Inject Code and Context" },
  },
}

local which_key = require("which-key")

which_key.setup(setup)
which_key.register(vars.mappings, vars.options)
which_key.register(vars.vmappings, vars.voptions)
which_key.setup(setup)
which_key.register(vars.mappings, vars.options)
which_key.register(vars.vmappings, vars.voptions)
which_key.setup(setup)
which_key.register(vars.mappings, vars.options)
which_key.register(vars.vmappings, vars.voptions)
