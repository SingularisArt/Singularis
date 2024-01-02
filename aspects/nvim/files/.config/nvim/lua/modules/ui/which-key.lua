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
vars.mappings["e"] = { "<CMD>Neotree toggle<CR>", "Toggle NeoTree" }
vars.mappings["-"] = { "<CMD>lua require('lir.float').toggle()<CR>", "Toggle Lir" }
vars.mappings["z"] = { "<CMD>ZenMode<CR>", "Zen Mode" }
vars.mappings["t"] = { "<CMD>lua require('alternate-toggler').toggleAlternate()<CR>", "Alternate" }
vars.mappings["p"] = { "<CMD>Pantran<CR>", "Translate" }

vars.mappings["g"] = {
  name = "Git",
  j = { "<CMD>lua require('gitsigns').next_hunk()<CR>", "Next Hunk" },
  k = { "<CMD>lua require('gitsigns').prev_hunk()<CR>", "Prev Hunk" },
  l = { "<CMD>lua require('gitsigns').blame_line()<CR>", "Blame" },
  p = { "<CMD>lua require('gitsigns').preview_hunk()<CR>", "Preview Hunk" },
  m = { "<CMD>GitMessenger<CR>", "View message" },
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
    "Checkout commit (for current file)",
  },
  d = {
    "<CMD>Gitsigns diffthis HEAD<CR>",
    "Git Diff",
  },
}

vars.mappings["G"] = {
  name = "ChatGPT",
  a = { "<CMD>ChatGPTActAs<CR>", "Have ChatGPT act as" },
  c = { "<CMD>ChatGPTCompleteCode<CR>", "Have ChatGPT complete code" },
  t = { "<CMD>ChatGPT<CR>", "Toggle ChatGPT" },
  i = { "<CMD>ChatGPTEditWithInstructions<CR>", "Have ChatGPT edit with instructions" },
  r = {
    name = "Run",
    a = { "<CMD>ChatGPTRun add_test<CR>", "Implement tests for the code" },
    c = { "<CMD>ChatGPTRun code_readability_analysis<CR>", "Identify any readability issues in the code" },
    C = { "<CMD>ChatGPTRun complete_code<CR>", "Complete the code" },
    d = { "<CMD>ChatGPTRun docstring<CR>", "Write docstring for the code" },
    e = { "<CMD>ChatGPTRun explain_code<CR>", "Explain the code" },
    f = { "<CMD>ChatGPTRun fix_bugs<CR>", "Fix bugs in the code" },
    g = { "<CMD>ChatGPTRun grammar_correction<CR>", "Correct grammar" },
    k = { "<CMD>ChatGPTRun keywords<CR>", "Extract the main keywords from the code" },
    o = { "<CMD>ChatGPTRun optimize_code<CR>", "Optimize the code" },
    r = { "<CMD>ChatGPTRun optimize_code<CR>", "Insert a roxygen skeleton to code" },
    s = { "<CMD>ChatGPTRun summarize<CR>", "Summarize the code" },
    t = { "<CMD>ChatGPTRun translate<CR>", "Translate code" },
  },
}

vars.mappings["H"] = {
  a = { "<CMD>lua require('harpoon.mark').add_file()<CR>", "Add file to harpoon" },
  h = { "<CMD>lua require('harpoon.ui').toggle_quick_menu()<CR>", "View harpoon" },
  n = { "<CMD>lua require('harpoon.ui').nav_next()<CR>", "Navigates to next harpoon mark" },
  p = { "<CMD>lua require('harpoon.ui').nav_prev()<CR>", "Navigates to previous harpoon mark" },
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

vars.mappings["m"] = {
  name = "Muren",
  t = { "<CMD>MurenToggle<CR>", "Toggle Muren" },
  o = { "<CMD>MurenOpen<CR>", "Open Muren" },
  c = { "<CMD>MurenClose<CR>", "Close Muren" },
  f = { "<CMD>MurenFresh<CR>", "Open Muren fresh" },
  u = { "<CMD>MurenUnique<CR>", "Toggle with all unique matches of the last search" },
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

vars.mappings["r"] = {
  name = "Refactor",
  e = { [[ <ESC><CMD>lua require('refactoring').refactor('Extract Function')<CR>]], "Extract Function" },
  f = {
    [[ <ESC><CMD>lua require('refactoring').refactor('Extract Function to File')<CR>]],
    "Extract Function to File",
  },
  v = { [[ <ESC><CMD>lua require('refactoring').refactor('Extract Variable')<CR>]], "Extract Variable" },
  i = { [[ <ESC><CMD>lua require('refactoring').refactor('Inline Variable')<CR>]], "Inline Variable" },
  r = { [[ <ESC><CMD>lua require('telescope').extensions.refactoring.refactors()<CR>]], "Refactor" },
  V = { [[ <ESC><CMD>lua require('refactoring').debug.print_var({})<CR>]], "Debug Print Var" },
}

local which_key = require("which-key")

which_key.setup(setup)
which_key.register(vars.mappings, vars.options)
which_key.register(vars.vmappings, vars.voptions)
