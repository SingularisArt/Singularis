local setup = {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = false, -- adds help for motions
      text_objects = false, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  -- operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    -- ["<space>"] = "SPC",
    ["<leader>"] = "SPC",
    -- ["<cr>"] = "RET",
    -- ["<tab>"] = "TAB",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = "<c-d>", -- binding to scroll down inside the popup
    scroll_up = "<c-u>", -- binding to scroll up inside the popup
  },
  window = {
    border = "rounded", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = "center", -- align columns left, center or right
  },
  ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<cmd>", "<cr>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = false, -- show help message on the command line when the popup is visible
  -- triggers = "auto", -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },
}

SingularisArt.which_key.opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}
SingularisArt.which_key.vopts = {
  mode = "v", -- VISUAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

SingularisArt.which_key.vmappings["/"] = {
  "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
  "Comment",
}

SingularisArt.which_key.mappings["v"] = { "<cmd>vsplit<cr>", "Vertical Split" }
SingularisArt.which_key.mappings["h"] = { "<cmd>split<cr>", "Horizontal Split" }
SingularisArt.which_key.mappings[" "] = { "<cmd>normal <C-^><cr>", "Jump to previous buffer" }
SingularisArt.which_key.mappings["/"] = { "<Plug>(comment_toggle_linewise)", "Comment out current line" }
SingularisArt.which_key.mappings["e"] = { "<cmd>NvimTreeToggle<cr>", "Toggle NvimTree" }
SingularisArt.which_key.mappings["-"] = { "<cmd>lua require('lir.float').toggle()<cr>", "Toggle Lir" }
SingularisArt.which_key.mappings["c"] = { "<Plug>(Corpus)", "Corpus" }
SingularisArt.which_key.mappings["z"] = { "<cmd>ZenMode<cr>", "Zen Mode" }

SingularisArt.which_key.mappings["l"] = {
  name = "LSP",
  c = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Show code actions" },
  e = {
    function()
      local config = SingularisArt.lsp.config.diagnostics.float
      config.scope = "line"
      vim.diagnostic.open_float(0, config)
    end,
    "Show line diagnostics",
  },
  q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Show QuickFix" },
  f = { "<cmd>lua vim.lsp.buf.format { async = true }<cr>", "Format" },
  r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
  i = { "<cmd>lua require('goto-preview').goto_preview_implementation()<cr>", "Go to implementation" },
  j = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "Go to next diagnostic" },
  k = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Go to previous diagnostic" },
  C = { "<cmd>lua require('goto-preview').close_all_win()<cr>", "Close all windows" },
  l = { "<cmd>lua require('lsp_lines').toggle()<cr>", "Toggle LSP Lines" },
  d = {
    name = "Definition",
    d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Definition" },
    p = { "<cmd>lua require('SingularisArt.lsp.peek').Peek('definition')<cr>", "Peek" },
    t = { "<cmd>lua require('SingularisArt.lsp.peek').Peek('typeDefinition')<cr>", "Type Definition" },
    i = { "<cmd>lua require('SingularisArt.lsp.peek').Peek('implementation')<cr>", "Implementation" },
  },
  w = {
    name = "Workspace",
    a = { "<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>", "Add workspace" },
    r = { "<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>", "Remove workspace" },
  },
}

SingularisArt.which_key.mappings["g"] = {
  name = "Git",
  j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
  k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
  l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
  p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
  r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
  R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
  s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
  u = {
    "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
    "Undo Stage Hunk",
  },
  o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
  b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
  c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
  C = {
    "<cmd>Telescope git_bcommits<cr>",
    "Checkout commit(for current file)",
  },
  d = {
    "<cmd>Gitsigns diffthis HEAD<cr>",
    "Git Diff",
  },
}

SingularisArt.which_key.mappings["f"] = {
  name = "Telescope",
  f = { "<cmd>Telescope find_files<cr>", "Fuzzy find files" },
  g = { "<cmd>Telescope grep_string<cr>", "Fuzzy find string" },
  o = { "<cmd>Telescope oldfiles<cr>", "Fuzzy find old files" },
  c = { "<cmd>Telescope colorscheme<cr>", "Fuzzy find colorschemes" },
  b = { "<cmd>Telescope buffers<cr>", "Fuzzy find buffers" },
  a = { "<cmd>Telescope autocommands<cr>", "Fuzzy find auto commands" },
  l = { "<cmd>Telescope live_grep<cr>", "Fuzzy find words" },
  m = { "<cmd>Telescope marks<cr>", "Fuzzy find marks" },
  p = { "<cmd>Telescope projects<cr>", "Fuzzy find projects" },
  s = { "<cmd>Telescope symbols<cr>", "Fuzzy find symbols" },
  d = { "<cmd>Telescope diagnostics<cr>", "Fuzzy find diagnostics" },
  v = { "<cmd>Telescope vim_options<cr>", "Fuzzy find vim options" },
  M = { "<cmd>Telescope man_pages<cr>", "Fuzzy find man pages" },
  k = { "<cmd>Telescope keymaps<cr>", "Fuzzy find keymaps" },
  t = { "<cmd>Telescope treesitter<cr>", "Fuzzy find treesitter" },
  r = { "<cmd>Telescope registers<cr>", "Fuzzy find registers" },
  h = { "<cmd>Telescope help_tags<cr>", "Fuzzy find help tags" },
  u = {
    "<cmd>require'telescope'.extensions.ultisnips.ultisnips{}<cr>",
    "Fuzzy find snippets",
  },
  S = { "<cmd>Telescope search_history<cr>", "Fuzzy find search history" },
  C = {
    name = "Commands",
    c = { "<cmd>Telescope commands<cr>", "Fuzzy find commands" },
    h = {
      "<cmd>Telescope command_history<cr>",
      "Fuzzy find commands history",
    },
  },
  q = {
    name = "QuickFix",
    q = { "<cmd>Telescope quickfix<cr>", "Fuzzy find quickfix" },
    h = {
      "<cmd>Telescope quickfixhistory<cr>",
      "Fuzzy find quickfix history",
    },
  },
}

SingularisArt.which_key.mappings["o"] = {
  name = "Only",
  o = {
    name = "Close",
    o = {
      "<cmd>wincmd _ | wincmd |<cr>",
      "Minimize all tabs (you can always bring them back with <Leader>oO)",
    },
    O = {
      "<cmd>only<cr>",
      "Close all tabs",
    },
  },
  O = { "<cmd>wincmd =<cr>", "Bring back the tabs" },
}

SingularisArt.which_key.mappings["T"] = {
  name = "Translator",
  t = { "<cmd>Translate --engines=google<cr>", "Translate" },
  h = { "<cmd>TranslateH --engines=google<cr>", "Translate History" },
  l = { "<cmd>TranslateL --engines=google<cr>", "Translate Log" },
  r = { "<cmd>TranslateR --engines=google<cr>", "Translate" },
  w = {
    "<cmd>TranslateW --engines=google<cr>",
    "Translate and display in a Popup Window",
  },
  x = {
    "<cmd>TranslateX --engines=google<cr>",
    "Translate and Display in the cmdline",
  },
}

SingularisArt.which_key.mappings["d"] = {
  name = "Debug",
  t = { "<cmd>lua require('dap').toggle_breakpoint()<cr>", "Toggle Breakpoint" },
  b = { "<cmd>lua require('dap').step_back()<cr>", "Step Back" },
  c = { "<cmd>lua require('dap').continue()<cr>", "Continue" },
  C = { "<cmd>lua require('dap').run_to_cursor()<cr>", "Run To Cursor" },
  d = { "<cmd>lua require('dap').disconnect()<cr>", "Disconnect" },
  g = { "<cmd>lua require('dap').session()<cr>", "Get Session" },
  i = { "<cmd>lua require('dap').step_into()<cr>", "Step Into" },
  o = { "<cmd>lua require('dap').step_over()<cr>", "Step Over" },
  u = { "<cmd>lua require('dap').step_out()<cr>", "Step Out" },
  p = { "<cmd>lua require('dap').pause()<cr>", "Pause" },
  r = { "<cmd>lua require('dap').repl.toggle()<cr>", "Toggle Repl" },
  s = { "<cmd>lua require('dap').continue()<cr>", "Start" },
  q = { "<cmd>lua require('dap').close()<cr>", "Quit" },
  U = { "<cmd>lua require('dapui').toggle()<cr>", "Enable/Disable UI" },
}

local which_key = require("which-key")

which_key.setup(setup)
which_key.register(SingularisArt.which_key.mappings, SingularisArt.which_key.opts)
which_key.register(SingularisArt.which_key.vmappings, SingularisArt.which_key.vopts)
