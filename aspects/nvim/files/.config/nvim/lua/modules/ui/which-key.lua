local which_key = require("which-key")

local setup = {
  plugins = {
    marks = false,
    registers = false,
    spelling = {
      enabled = false,
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
  icons = {
    breadcrumb = "»",
    separator = "➜",
    group = "+",
    mappings = false,
  },
  win = {
    border = "rounded",
  },
  layout = {
    height = { min = 4, max = 25 },
    width = { min = 20, max = 50 },
    spacing = 3,
    align = "center",
  },
  show_help = false,
}

which_key.setup(setup)

local vars = require("config.global").which_key_vars

local function search_config_files()
  local builtin = require("telescope.builtin")
  builtin.find_files({ cwd = vim.fn.stdpath("config") })
end

-- vars.mappings[1] = {
--   { "<Leader>d", group = "Debugging" },

--   { "<Leader>dt", require("dap").toggle_breakpoint, desc = "Toggle Breakpoint" },
--   { "<Leader>db", require("dap").step_back, desc = "Step Back" },
--   { "<Leader>dc", require("dap").continue, desc = "Continue" },
--   { "<Leader>dC", require("dap").run_to_cursor, desc = "Run To Cursor" },
--   { "<Leader>dd", require("dap").disconnect, desc = "Disconnect" },
--   { "<Leader>dg", require("dap").session, desc = "Get Session" },
--   { "<Leader>di", require("dap").step_into, desc = "Step Into" },
--   { "<Leader>do", require("dap").step_over, desc = "Step Over" },
--   { "<Leader>du", require("dap").step_out, desc = "Step Out" },
--   { "<Leader>dp", require("dap").pause, desc = "Pause" },
--   { "<Leader>dr", require("dap").repl.toggle, desc = "Toggle Repl" },
--   { "<Leader>ds", require("dap").continue, desc = "Start" },
--   { "<Leader>dq", require("dap").close, desc = "Quit" },
--   { "<Leader>dU", require("dapui").toggle, desc = "Enable/Disable UI" },
-- }

vars.mappings[2] = {
  { "<Leader>g", group = "Git" },

  { "<Leader>gj", require("gitsigns").next_hunk, desc = "Next Hunk" },
  { "<Leader>gk", require("gitsigns").prev_hunk, desc = "Prev Hunk" },
  { "<Leader>gl", require("gitsigns").blame_line, desc = "Blame" },
  { "<Leader>gp", require("gitsigns").preview_hunk, desc = "Preview Hunk" },
  { "<Leader>gm", vim.cmd.GitMessenger, desc = "View message" },
  { "<Leader>gr", require("gitsigns").reset_hunk, desc = "Reset Hunk" },
  { "<Leader>gR", require("gitsigns").reset_buffer, desc = "Reset Buffer" },
  { "<Leader>gs", require("gitsigns").stage_hunk, desc = "Stage Hunk" },
  { "<Leader>gu", require("gitsigns").undo_stage_hunk, desc = "Undo Stage Hunk" },
  { "<Leader>go", "<CMD>Telescope git_status<CR>", desc = "Open changed file" },
  { "<Leader>gb", "<CMD>Telescope git_branches<CR>", desc = "Checkout branch" },
  { "<Leader>gc", "<CMD>Telescope git_commits<CR>", desc = "Checkout commit" },
  { "<Leader>gC", "<CMD>Telescope git_bcommits<CR>", desc = "Checkout commit" },
  { "<Leader>gd", "<CMD>Gitsigns diffthis HEAD<CR>", desc = "Git Diff" },
}

vars.mappings[3] = {
  { "<Leader>G", group = "ChatGPT" },

  { "<Leader>Ga", vim.cmd.ChatGPTActAs, desc = "Have ChatGPT act as" },
  { "<Leader>Gc", vim.cmd.ChatGPTCompleteCode, desc = "Have ChatGPT complete code" },
  { "<Leader>Gt", vim.cmd.ChatGPT, desc = "Toggle ChatGPT" },
  { "<Leader>Gi", vim.cmd.ChatGPTEditWithInstructions, desc = "Have ChatGPT edit with instructions" },
  { "<Leader>Gr", group = "Run" },
  { "<Leader>Gra", "<CMD>ChatGPTRun add_test<CR>", desc = "Implement tests for the code" },
  {
    "<Leader>Grc",
    "<CMD>ChatGPTRun code_readability_analysis<CR>",
    desc = "Identify any readability issues in the code",
  },
  { "<Leader>GrC", "<CMD>ChatGPTRun complete_code<CR>", desc = "Complete the code" },
  { "<Leader>Grd", "<CMD>ChatGPTRun docstring<CR>", desc = "Write docstring for the code" },
  { "<Leader>Gre", "<CMD>ChatGPTRun explain_code<CR>", desc = "Explain the code" },
  { "<Leader>Grf", "<CMD>ChatGPTRun fix_bugs<CR>", desc = "Fix bugs in the code" },
  { "<Leader>Grg", "<CMD>ChatGPTRun grammar_correction<CR>", desc = "Correct grammar" },
  { "<Leader>Grk", "<CMD>ChatGPTRun keywords<CR>", desc = "Extract the main keywords from the code" },
  { "<Leader>Gro", "<CMD>ChatGPTRun optimize_code<CR>", desc = "Optimize the code" },
  { "<Leader>Grr", "<CMD>ChatGPTRun optimize_code<CR>", desc = "Insert a roxygen skeleton to code" },
  { "<Leader>Grs", "<CMD>ChatGPTRun summarize<CR>", desc = "Summarize the code" },
  { "<Leader>Grt", "<CMD>ChatGPTRun translate<CR>", desc = "Translate code" },
}

-- vars.mappings[4] = {
--   { "<Leader>n", group = "NeoTest" },

--   { "<Leader>na", require("neotest").run.attach, desc = "Attach to the nearest test" },
--   {
--     "<Leader>nc",
--     function()
--       require("neotest").run.run(vim.fn.expand("%"))
--     end,
--     desc = "Run the current file",
--   },
--   {
--     "<Leader>nd",
--     function()
--       require("neotest").run.run({ strategy = "dap" })
--     end,
--     desc = "Debug the nearest test",
--   },
--   {
--     "<Leader>ne",
--     function()
--       require("neotest").output.open({ enter = true, auto_close = true })
--     end,
--     desc = "Open the output of a test result",
--   },
--   {
--     "<Leader>nj",
--     function()
--       require("neotest").jump.prev({ status = "failed" })
--     end,
--     desc = "Jump to next error",
--   },
--   {
--     "<Leader>nk",
--     function()
--       require("neotest").jump.next({ status = "failed" })
--     end,
--     desc = "Jump to previous error",
--   },
--   { "<Leader>nn", require("neotest").run.run, desc = "Run the nearest test" },
--   { "<Leader>ns", require("neotest").run.stop, desc = "Stop the nearest test" },
--   { "<Leader>nS", require("neotest").summary.toggle, desc = "Toggle the summary window" },
-- }

vars.mappings[5] = {
  { "<Leader>r", group = "Refactor" },

  { "<Leader>re", "<CMD>lua require('refactoring').refactor('Extract Function')<CR>", desc = "Extract Function" },
  {
    "<Leader>rf",
    "<CMD>lua require('refactoring').refactor('Extract Function to File')<CR>",
    desc = "Extract Function to File",
  },
  { "<Leader>rv", "<CMD>lua require('refactoring').refactor('Extract Variable')<CR>", desc = "Extract Variable" },
  { "<Leader>ri", "<CMD>lua require('refactoring').refactor('Inline Variable')<CR>", desc = "Inline Variable" },
  { "<Leader>rr", "<CMD>lua require('telescope').extensions.refactoring.refactors()<CR>", desc = "Refactor" },
  { "<Leader>rV", "<CMD>lua require('refactoring').debug.print_var({})<CR>", desc = "Debug Print Var" },
}

vars.mappings[6] = {
  { "<Leader>s", group = "Search" },

  { "<Leader>sf", "<CMD>Telescope find_files<CR>", desc = "Fuzzy find files" },
  { "<Leader>sg", "<CMD>Telescope grep_string<CR>", desc = "Fuzzy find string" },
  { "<Leader>sb", "<CMD>Telescope buffers<CR>", desc = "Fuzzy find buffers" },
  { "<Leader>sl", "<CMD>Telescope live_grep<CR>", desc = "Fuzzy find words" },
  { "<Leader>ss", "<CMD>Telescope symbols<CR>", desc = "Fuzzy find symbols" },
  -- { "<Leader>sh", "<CMD>Telescope harpoon marks<CR>", desc = "View harpoon" },
  { "<Leader>sd", "<CMD>Telescope diagnostics<CR>", desc = "Fuzzy find diagnostics" },
  { "<Leader>sn", search_config_files, desc = "Fuzzy find config files" },
  {
    "<Leader>sc",
    function()
      require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
        winblend = 10,
        previewer = false,
      }))
    end,
    desc = "Fuzzily search in current buffer",
  },
}

which_key.add(vars.mappings)
which_key.add({
  { "<Leader> ", "<CMD>normal <C-^><CR>", desc = "Jump to previous buffer" },
  { "<Leader>/", "<CMD>lua require('Comment.api').toggle.linewise()<CR>", desc = "Comment out current line" },
  -- { "<Leader>a", require("harpoon.mark").add_file, desc = "Add file to harpoon" },
  { "<Leader>o", "<CMD>Goyo<CR>", desc = "Enable Goyo" },
  { "<Leader>h", vim.cmd.split, desc = "Horizontal Split" },
  -- { "<Leader>t", require("alternate-toggler").toggleAlternate, desc = "Toggle Alternate" },
  { "<Leader>v", vim.cmd.vsplit, desc = "Vertical Split" },
  { "<Leader>z", vim.cmd.ZenMode, desc = "Zen Mode" },
})

which_key.add({
    { "<Leader>/", "<ESC><CMD>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", desc = "Comment", mode = "v" },
})
