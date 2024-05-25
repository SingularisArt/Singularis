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

local function search_config_files()
  local builtin = require("telescope.builtin")
  builtin.find_files({ cwd = vim.fn.stdpath("config") })
end

vars.vmappings["/"] = {
  "<ESC><CMD>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
  "Comment",
}

vars.mappings[" "] = { "<CMD>normal <C-^><CR>", "Jump to previous buffer" }
-- vars.mappings["-"] = { require("lir.float").toggle, "Toggle Lir" }
vars.mappings["/"] = { require("Comment.api").toggle.linewise, "Comment out current line" }
vars.mappings["a"] = { require("harpoon.mark").add_file, "Add file to harpoon" }
-- vars.mappings["e"] = { "<CMD>Neotree toggle<CR>", "Toggle NeoTree" }
vars.mappings["h"] = { vim.cmd.split, "Horizontal Split" }
vars.mappings["t"] = { require("alternate-toggler").toggleAlternate, "Alternate" }
vars.mappings["v"] = { vim.cmd.vsplit, "Vertical Split" }
vars.mappings["z"] = { vim.cmd.ZenMode, "Zen Mode" }

vars.mappings["d"] = {
  name = "Debug",
  t = { require("dap").toggle_breakpoint, "Toggle Breakpoint" },
  b = { require("dap").step_back, "Step Back" },
  c = { require("dap").continue, "Continue" },
  C = { require("dap").run_to_cursor, "Run To Cursor" },
  d = { require("dap").disconnect, "Disconnect" },
  g = { require("dap").session, "Get Session" },
  i = { require("dap").step_into, "Step Into" },
  o = { require("dap").step_over, "Step Over" },
  u = { require("dap").step_out, "Step Out" },
  p = { require("dap").pause, "Pause" },
  r = { require("dap").repl.toggle, "Toggle Repl" },
  s = { require("dap").continue, "Start" },
  q = { require("dap").close, "Quit" },
  U = { require("dapui").toggle, "Enable/Disable UI" },
}

vars.mappings["g"] = {
  name = "Git",
  j = { require("gitsigns").next_hunk, "Next Hunk" },
  k = { require("gitsigns").prev_hunk, "Prev Hunk" },
  l = { require("gitsigns").blame_line, "Blame" },
  p = { require("gitsigns").preview_hunk, "Preview Hunk" },
  m = { vim.cmd.GitMessenger, "View message" },
  r = { require("gitsigns").reset_hunk, "Reset Hunk" },
  R = { require("gitsigns").reset_buffer, "Reset Buffer" },
  s = { require("gitsigns").stage_hunk, "Stage Hunk" },
  u = { require("gitsigns").undo_stage_hunk, "Undo Stage Hunk" },
  o = { "<CMD>Telescope git_status<CR>", "Open changed file" },
  b = { "<CMD>Telescope git_branches<CR>", "Checkout branch" },
  c = { "<CMD>Telescope git_commits<CR>", "Checkout commit" },
  C = { "<CMD>Telescope git_bcommits<CR>", "Checkout commit" },
  d = { "<CMD>Gitsigns diffthis HEAD<CR>", "Git Diff" },
}

vars.mappings["G"] = {
  name = "ChatGPT",
  a = { vim.cmd.ChatGPTActAs, "Have ChatGPT act as" },
  c = { vim.cmd.ChatGPTCompleteCode, "Have ChatGPT complete code" },
  t = { vim.cmd.ChatGPT, "Toggle ChatGPT" },
  i = { vim.cmd.ChatGPTEditWithInstructions, "Have ChatGPT edit with instructions" },
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

vars.mappings["n"] = {
  name = "Neotest",
  a = { require("neotest").run.attach, "Attach to the nearest test" },
  c = {
    function()
      require("neotest").run.run(vim.fn.expand("%"))
    end,
    "Run the current file",
  },
  d = {
    function()
      require("neotest").run.run({ strategy = "dap" })
    end,
    "Debug the nearest test",
  },
  e = {
    function()
      require("neotest").output.open({ enter = true, auto_close = true })
    end,
    "Open the output of a test result",
  },
  j = {
    function()
      require("neotest").jump.prev({ status = "failed" })
    end,
    "Jump to next error",
  },
  k = {
    function()
      require("neotest").jump.next({ status = "failed" })
    end,
    "Jump to previous error",
  },
  n = { require("neotest").run.run, "Run the nearest test" },
  s = { require("neotest").run.stop, "Stop the nearest test" },
  S = { require("neotest").summary.toggle, "Toggle the summary window" },
}

vars.mappings["r"] = {
  name = "Refactor",
  e = { "<CMD>lua require('refactoring').refactor('Extract Function')<CR>", "Extract Function" },
  f = { "<CMD>lua require('refactoring').refactor('Extract Function to File')<CR>", "Extract Function to File" },
  v = { "<CMD>lua require('refactoring').refactor('Extract Variable')<CR>", "Extract Variable" },
  i = { "<CMD>lua require('refactoring').refactor('Inline Variable')<CR>", "Inline Variable" },
  r = { "<CMD>lua require('telescope').extensions.refactoring.refactors()<CR>", "Refactor" },
  V = { "<CMD>lua require('refactoring').debug.print_var({})<CR>", "Debug Print Var" },
}

vars.mappings["s"] = {
  name = "Search",
  f = { "<CMD>Telescope find_files<CR>", "Fuzzy find files" },
  g = { "<CMD>Telescope grep_string<CR>", "Fuzzy find string" },
  b = { "<CMD>Telescope buffers<CR>", "Fuzzy find buffers" },
  l = { "<CMD>Telescope live_grep<CR>", "Fuzzy find words" },
  s = { "<CMD>Telescope symbols<CR>", "Fuzzy find symbols" },
  h = { "<CMD>Telescope harpoon marks<CR>", "View harpoon" },
  d = { "<CMD>Telescope diagnostics<CR>", "Fuzzy find diagnostics" },
  n = { search_config_files, "Fuzzy find config files" },
  c = {
    function()
      require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
        winblend = 10,
        previewer = false,
      }))
    end,
    "Fuzzily search in current buffer",
  },
}

local which_key = require("which-key")

which_key.setup(setup)
which_key.register(vars.mappings, vars.options)
which_key.register(vars.vmappings, vars.voptions)
