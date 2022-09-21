local M = {}

M.setup = function()
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
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
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

  local opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
  }
  local vopts = {
    mode = "v", -- VISUAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
  }

  local vmappings = {
    ["/"] = {
      '<ESC><CMD>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>',
      "Comment",
    },
  }
  local mappings = {
    ["v"] = { "<cmd>vsplit<CR>", "Vertical Split" },
    ["h"] = { "<cmd>split<CR>", "Horizontal Split" },
    ["u"] = { "<cmd>SymbolsOutline<CR>", "Toggle Symbols Outline" },
    [" "] = { "<cmd>normal <C-^><CR>", "Jump to previous buffer" },
    ["c"] = { "<Plug>(Corpus)", "Corpus" },

    ["g"] = {
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
    },

    ["m"] = {
      name = "Markdown",
      p = { "<cmd>MarkdownPreview<CR>", "View Markdown" },
    },

    ["t"] = {
      name = "Table",
      t = { "<cmd>TableModeToggle<CR>", "Enable/Disable Table Mode" },
      n = { "<Leader>ti", "Get cell info" },
      f = {
        name = "Formula",
        a = { "<cmd>TableAddFormula<CR>", "Add formula" },
        e = { "<Leader>tfe", "Evaluate formula on current row" },
      },
      d = {
        name = "Delete",
        r = { "<Leader>tdr", "Delete row" },
        c = { "<Leader>tdc", "Delete column" },
      },
      i = {
        name = "Insert",
        c = { "<Leader>tic", "Insert column" },
      },
    },

    ["l"] = {
      name = "LaTeX",
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

    ["f"] = {
      name = "Telescope",
      f = { "<cmd>Telescope find_files<CR>", "Fuzzy find files" },
      o = { "<cmd>Telescope oldfiles<CR>", "Fuzzy find old files" },
      c = { "<cmd>Telescope colorscheme<CR>", "Fuzzy find colorschemes" },
      b = { "<cmd>Telescope buffers<CR>", "Fuzzy find buffers" },
      a = { "<cmd>Telescope autocommands<CR>", "Fuzzy find auto commands" },
      l = { "<cmd>Telescope live_grep<CR>", "Fuzzy find words" },
      m = { "<cmd>Telescope marks<CR>", "Fuzzy find marks" },
      p = { "<cmd>Telescope projects<CR>", "Fuzzy find projects" },
      s = { "<cmd>Telescope symbols<CR>", "Fuzzy find symbols" },
      d = { "<cmd>Telescope diagnostics<CR>", "Fuzzy find diagnostics" },
      v = { "<cmd>Telescope vim_options<CR>", "Fuzzy find vim options" },
      M = { "<cmd>Telescope man_pages<CR>", "Fuzzy find man pages" },
      k = { "<cmd>Telescope keymaps<CR>", "Fuzzy find keymaps" },
      t = { "<cmd>Telescope treesitter<CR>", "Fuzzy find treesitter" },
      r = { "<cmd>Telescope registers<CR>", "Fuzzy find registers" },
      h = { "<cmd>Telescope help_tags<CR>", "Fuzzy find help tags" },
      S = { "<cmd>Telescope search_history<CR>", "Fuzzy find search history" },
      C = {
        name = "Commands",
        c = { "<cmd>Telescope commands<CR>", "Fuzzy find commands" },
        h = {
          "<cmd>Telescope command_history<CR>",
          "Fuzzy find commands history",
        },
      },
      q = {
        name = "QuickFix",
        q = { "<cmd>Telescope quickfix<CR>", "Fuzzy find quickfix" },
        h = {
          "<cmd>Telescope quickfixhistory<CR>",
          "Fuzzy find quickfix history",
        },
      },
    },

    ["d"] = {
      name = "Debug",
      R = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run to Cursor" },
      E = {
        "<cmd>lua require'dapui'.eval(vim.fn.input '[Expression] > ')<cr>",
        "Evaluate Input",
      },
      C = {
        "<cmd>lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<cr>",
        "Conditional Breakpoint",
      },
      U = { "<cmd>lua require'dapui'.toggle()<cr>", "Toggle UI" },
      b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
      c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
      d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
      e = { "<cmd>lua require'dapui'.eval()<cr>", "Evaluate" },
      g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
      h = { "<cmd>lua require'dap.ui.widgets'.hover()<cr>", "Hover Variables" },
      S = { "<cmd>lua require'dap.ui.widgets'.scopes()<cr>", "Scopes" },
      i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
      o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
      p = { "<cmd>lua require'dap'.pause.toggle()<cr>", "Pause" },
      q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
      r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
      s = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
      t = {
        "<cmd>lua require'dap'.toggle_breakpoint()<cr>",
        "Toggle Breakpoint",
      },
      x = { "<cmd>lua require'dap'.terminate()<cr>", "Terminate" },
      u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
    },

    ["s"] = {
      name = "LSP",
      c = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Show code actions" },
      e = {
        function()
          local config = SingularisArt.lsp.diagnostics.float
          config.scope = "line"
          vim.diagnostic.open_float(0, config)
        end,
        "Show line diagnostics",
      },
      q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", "Show QuickFix" },
      f = { "<cmd>lua vim.lsp.buf.format { async = true }<CR>", "Format" },
      r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
      i = {
        "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>",
        "Go to implementation",
      },
      j = { "<cmd>lua vim.diagnostic.goto_next()<CR>", "Go to next diagnostic" },
      k = {
        "<cmd>lua vim.diagnostic.goto_prev()<CR>",
        "Go to previous diagnostic",
      },
      C = {
        "<cmd>lua require('goto-preview').close_all_win()<CR>",
        "Close all windows",
      },
      l = { "<cmd>lua require('lsp_lines').toggle()<CR>", "Toggle LSP Lines" },
      d = {
        name = "Definition",
        d = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Go to definition" },
        r = { "<cmd>lua vim.lsp.buf.references()<CR>", "Find references" },
        t = {
          "<cmd>lua vim.lsp.buf.type_definition()<CR>",
          "Get type definition",
        },
        p = {
          function()
            require("SingularisArt.lsp.peek").Peek("definition")
          end,
          "Peek definition",
        },
      },
      w = {
        name = "Workspace",
        a = {
          "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>",
          "Add workspace",
        },
        r = {
          "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>",
          "Remove workspace",
        },
      },
    },

    ["p"] = {
      name = "Packer",
      c = { "<cmd>PackerClean<CR>", "Clean Plugins" },
      C = { "<cmd>PackerCompile<CR>", "Compile Plugins" },
      i = { "<cmd>PackerInstall<CR>", "Install Plugins" },
      l = { "<cmd>PackerLoad<CR>", "Load Plugins" },
      p = { "<cmd>PackerProfile<CR>", "Profile Plugins" },
      t = { "<cmd>PackerStatus<CR>", "Plugins Status" },
      y = { "<cmd>PackerSync<CR>", "Sync Plugins" },
      u = { "<cmd>PackerUpdate<CR>", "Update Plugins" },
      s = {
        name = "Snapshot",
        s = { "<cmd>PackerSnapshot<CR>", "Snapshot Plugins" },
        d = { "<cmd>PackerSnapshotDelete<CR>", "Delete Snapshot Plugins" },
        r = { "<cmd>PackerSnapshotRollback<CR>", "Rollback Snapshot Plugins" },
      },
    },

    ["T"] = {
      name = "Translator",
      t = { "<cmd>Translate --engines=google<CR>", "Translate" },
      h = { "<cmd>TranslateH --engines=google<CR>", "Translate History" },
      l = { "<cmd>TranslateL --engines=google<CR>", "Translate Log" },
      r = { "<cmd>TranslateR --engines=google<CR>", "Translate" },
      w = {
        "<cmd>TranslateW --engines=google<CR>",
        "Translate and display in a Popup Window",
      },
      x = {
        "<cmd>TranslateX --engines=google<CR>",
        "Translate and Display in the cmdline",
      },
    },

    ["o"] = {
      name = "Only",
      o = {
        name = "Close",
        o = {
          "<cmd>wincmd _ | wincmd |<CR>",
          "Minimize all tabs (you can always bring them back with <Leader>oO)",
        },
        O = {
          "<cmd>only<CR>",
          "Close all tabs",
        },
      },
      O = { "<cmd>wincmd =<CR>", "Bring back the tabs" },
    },

    ["n"] = {
      name = "Neorg",
      i = { "<cmd>Telescope neorg insert_link<CR>", "Insert Link" },
      f = { "<cmd>Telescope neorg find_linkable<CR>", "" },
      F = { "<cmd>Telescope neorg find_aof_tasks<CR>", "" },
      s = { "<cmd>Telescope neorg search_headings<CR>", "" },
      S = { "<cmd>Telescope neorg switch_workspace<CR>", "" },
      I = { "<cmd>Telescope neorg insert_file_link<CR>", "" },
      p = { "<cmd>Telescope neorg find_project_tasks<CR>", "" },
      c = { "<cmd>Telescope neorg find_context_tasks<CR>", "" },
      a = { "<cmd>Telescope neorg find_aof_project_tasks<CR>", "" },

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
  }

  local which_key = require("which-key")

  which_key.setup(setup)
  which_key.register(mappings, opts)
  which_key.register(vmappings, vopts)
end

return M
