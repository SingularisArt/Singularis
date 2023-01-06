return {
  -- file explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = "MunifTanjim/nui.nvim",
    cmd = "Neotree",
    keys = {
      {
        "<leader>ft",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = require("SingularisArt.util").get_root() })
        end,
        desc = "NeoTree (root dir)",
      },
      { "<leader>fT", "<cmd>Neotree toggle<CR>", desc = "NeoTree (cwd)" },
    },
    init = function()
      vim.g.neo_tree_remove_legacy_commands = 1
    end,
    config = function()
      vim.g.neo_tree_remove_legacy_commands = 1

      require("neo-tree").setup({
        sources = {
          "filesystem",
          "buffers",
          "git_status",
          "diagnostics",
        },
        source_selector = {
          winbar = true,
          separator_active = " ",
        },
        enable_git_status = true,
        git_status_async = true,
        filesystem = {
          hijack_netrw_behavior = "open_current",
          use_libuv_file_watcher = true,
          group_empty_dirs = true,
          follow_current_file = false,
          filtered_items = {
            visible = true,
            hide_dotfiles = false,
            hide_gitignored = true,
            never_show = {
              ".DS_Store",
            },
          },
          window = {
            mappings = {
              ["/"] = "noop",
              ["g/"] = "fuzzy_finder",
            },
          },
        },
        default_component_configs = {
          icon = {
            folder_empty = "",
          },
          diagnostics = {
            highlights = {
              hint = "DiagnosticHint",
              info = "DiagnosticInfo",
              warn = "DiagnosticWarn",
              error = "DiagnosticError",
            },
          },
          modified = {
            symbol = icons.misc.circle .. " ",
          },
          git_status = {
            symbols = {
              added = icons.git.add,
              deleted = icons.git.remove,
              modified = icons.git.mod,
              renamed = icons.git.rename,
              untracked = "",
              ignored = "",
              unstaged = "",
              staged = "",
              conflict = "",
            },
          },
        },
        window = {
          mappings = {
            ["o"] = "toggle_node",
            ["<CR>"] = "open_with_window_picker",
            ["<c-s>"] = "split_with_window_picker",
            ["<c-v>"] = "vsplit_with_window_picker",
            ["<esc>"] = "revert_preview",
            ["P"] = { "toggle_preview", config = { use_float = true } },
          },
        },
      })
    end,
    lazy = true,
  },

  -- floating file browser
  {
    "tamago324/lir.nvim",
    config = function()
      require("lir").setup()
    end,
    keys = {
      {
        "<Leader>-",
        "<cmd>lua require('lir.float').toggle()<cr>",
      },
    },
  },

  -- search/replace in multiple files
  {
    "windwp/nvim-spectre",
    keys = {
      { "<leader>r", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
    },
  },

  -- fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    config = function()
      local telescope = require("telescope")

      local actions = require("telescope.actions")
      local icons = require("SingularisArt.config.icons")

      telescope.setup({
        defaults = {
          prompt_prefix = icons.ui.Telescope .. " ",
          selection_caret = " ",
          path_display = { "smart" },
          file_ignore_patterns = {
            ".git/",
            "target/",
            "docs/",
            "vendor/*",
            "%.lock",
            "__pycache__/*",
            "%.sqlite3",
            "%.ipynb",
            "node_modules/*",
            -- "%.jpg",
            -- "%.jpeg",
            -- "%.png",
            "%.svg",
            "%.otf",
            "%.ttf",
            "%.webp",
            ".dart_tool/",
            ".github/",
            ".gradle/",
            ".idea/",
            ".settings/",
            ".vscode/",
            "__pycache__/",
            "build/",
            "env/",
            "gradle/",
            "node_modules/",
            "%.pdb",
            "%.dll",
            "%.class",
            "%.exe",
            "%.cache",
            "%.ico",
            "%.pdf",
            "%.dylib",
            "%.jar",
            "%.docx",
            "%.met",
            "smalljre_*/*",
            ".vale/",
            "%.burp",
            "%.mp4",
            "%.mkv",
            "%.rar",
            "%.zip",
            "%.7z",
            "%.tar",
            "%.bz2",
            "%.epub",
            "%.flac",
            "%.tar.gz",
          },

          mappings = {
            i = {
              ["<C-n>"] = actions.cycle_history_next,
              ["<C-p>"] = actions.cycle_history_prev,

              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,

              ["<C-b>"] = actions.results_scrolling_up,
              ["<C-f>"] = actions.results_scrolling_down,

              ["<C-c>"] = actions.close,

              ["<Down>"] = actions.move_selection_next,
              ["<Up>"] = actions.move_selection_previous,

              ["<CR>"] = actions.select_default,
              ["<C-s>"] = actions.select_horizontal,
              ["<C-v>"] = actions.select_vertical,
              ["<C-t>"] = actions.select_tab,

              ["<c-d>"] = require("telescope.actions").delete_buffer,

              -- ["<C-u>"] = actions.preview_scrolling_up,
              -- ["<C-d>"] = actions.preview_scrolling_down,

              -- ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
              ["<Tab>"] = actions.close,
              ["<S-Tab>"] = actions.close,
              -- ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
              ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
              ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
              ["<C-l>"] = actions.complete_tag,
              ["<C-h>"] = actions.which_key, -- keys from pressing <C-h>
              ["<esc>"] = actions.close,
            },

            n = {
              ["<esc>"] = actions.close,
              ["<CR>"] = actions.select_default,
              ["<C-x>"] = actions.select_horizontal,
              ["<C-v>"] = actions.select_vertical,
              ["<C-t>"] = actions.select_tab,
              ["<C-b>"] = actions.results_scrolling_up,
              ["<C-f>"] = actions.results_scrolling_down,

              -- ["<Tab>"] = actions.close,
              -- ["<S-Tab>"] = actions.close,
              ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
              ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
              ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
              ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

              ["j"] = actions.move_selection_next,
              ["k"] = actions.move_selection_previous,
              ["H"] = actions.move_to_top,
              ["M"] = actions.move_to_middle,
              ["L"] = actions.move_to_bottom,
              ["q"] = actions.close,
              ["dd"] = require("telescope.actions").delete_buffer,
              ["s"] = actions.select_horizontal,
              ["v"] = actions.select_vertical,
              ["t"] = actions.select_tab,

              ["<Down>"] = actions.move_selection_next,
              ["<Up>"] = actions.move_selection_previous,
              ["gg"] = actions.move_to_top,
              ["G"] = actions.move_to_bottom,

              ["<C-u>"] = actions.preview_scrolling_up,
              ["<C-d>"] = actions.preview_scrolling_down,

              ["<PageUp>"] = actions.results_scrolling_up,
              ["<PageDown>"] = actions.results_scrolling_down,

              ["?"] = actions.which_key,
            },
          },
        },
        pickers = {
          live_grep = {
            theme = "dropdown",
          },
          grep_string = {
            theme = "dropdown",
          },
          find_files = {
            theme = "dropdown",
            previewer = true,
          },
          buffers = {
            theme = "dropdown",
            previewer = false,
          },
          colorscheme = {
            enable_preview = false,
          },
          lsp_references = {
            theme = "dropdown",
          },
          lsp_definitions = {
            theme = "dropdown",
          },
          lsp_declarations = {
            theme = "dropdown",
          },
          lsp_implementations = {
            theme = "dropdown",
          },
        },
        extensions = {},
      })
    end,
  },

  -- which-key
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
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

      local vars = {
        options = {
          mode = "n", -- NORMAL mode
          prefix = "<leader>",
          buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
          silent = true, -- use `silent` when creating keymaps
          noremap = true, -- use `noremap` when creating keymaps
          nowait = true, -- use `nowait` when creating keymaps
        },
        voptions = {
          mode = "v", -- VISUAL mode
          prefix = "<leader>",
          buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
          silent = true, -- use `silent` when creating keymaps
          noremap = true, -- use `noremap` when creating keymaps
          nowait = true, -- use `nowait` when creating keymaps
        },
        mappings = {},
        vmappings = {},
      }

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
    end,
  },

  -- references
  {
    "RRethy/vim-illuminate",
    event = "BufReadPost",
    config = function()
      require("illuminate").configure({ delay = 200 })
    end,
  },

  -- better diagnostics list and others
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    config = { use_diagnostic_signs = true },
    keys = {
      { "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
    },
  },

  -- nice way of seeing lsp status
  {
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup({
        sources = {
          ["null-ls"] = { ignore = true },
        },
      })
    end,
  },

  -- comment.
  {
    "numToStr/Comment.nvim",
    config = function()
      local nvim_comment = require("Comment")

      nvim_comment.setup({
        ignore = "^$",
        toggler = {
          ---Line-comment toggle keymap
          line = "<Leader>/",
          ---Block-comment toggle keymap
          block = "gbc",
        },
        pre_hook = function(ctx)
          -- For inlay hints
          local line_start = (ctx.srow or ctx.range.srow) - 1
          local line_end = ctx.erow or ctx.range.erow
          require("lsp-inlayhints.core").clear(0, line_start, line_end)

          require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()

          if vim.bo.filetype == "javascript" or vim.bo.filetype == "typescript" then
            local U = require("Comment.utils")

            -- Determine whether to use linewise or blockwise commentstring
            local type = ctx.ctype == U.ctype.linewise and "__default" or "__multiline"

            -- Determine the location where to calculate commentstring from
            local location = nil
            if ctx.ctype == U.ctype.blockwise then
              location = require("ts_context_commentstring.utils").get_cursor_location()
            elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
              location = require("ts_context_commentstring.utils").get_visual_start_location()
            end

            return require("ts_context_commentstring.internal").calculate_commentstring({
              key = type,
              location = location,
            })
          end
        end,
      })
    end,
    keys = {
      "g",
      "<ESC>",
      "v",
      "V",
      "<c-v>",
      "<Leader>/",
    },
    lazy = true,
  },

  -- todo comments
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = "BufReadPost",
    config = function()
      local todo_comments = require("todo-comments")

      local icons = require("SingularisArt.confg.icons")

      local error_red = "#F44747"
      local warning_orange = "#ff8800"
      local hint_blue = "#4FC1FF"
      local perf_purple = "#7C3AED"
      local note_green = "#10B981"

      todo_comments.setup({
        signs = true,
        sign_priority = 8,
        keywords = {
          FIX = {
            icon = icons.ui.Bug,
            color = error_red,
            alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
          },
          TODO = { icon = icons.ui.Check, color = hint_blue, alt = { "TIP" } },
          HACK = { icon = icons.ui.Fire, color = warning_orange },
          WARN = { icon = icons.diagnostics.Warning, color = warning_orange, alt = { "WARNING", "XXX" } },
          PERF = {
            icon = icons.ui.Dashboard,
            color = perf_purple,
            alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE", "TEST" },
          },
          NOTE = { icon = icons.ui.Note, color = note_green, alt = { "INFO" } },
        },
        highlight = {
          before = "",
          keyword = "wide",
          after = "fg",
          pattern = [[.*<(KEYWORDS)\s*:]],
          comments_only = true,
          max_line_len = 400,
          exclude = { "markdown" },
        },
        search = {
          command = "rg",
          args = {
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
          },
          pattern = [[\b(KEYWORDS):]],
        },
      })
    end,
    -- keys = {
    --   { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
    --   { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
    --   { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo Trouble" },
    --   { "<leader>xtt", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo Trouble" },
    --   { "<leader>xT", "<cmd>TodoTelescope<cr>", desc = "Todo Telescope" },
    -- },
  },

  {
    "folke/zen-mode.nvim",
    config = function()
      require("zen-mode").setup({
        window = {
          backdrop = 1,
          height = 0.9,
          -- width = 0.5,
          width = 80,
          options = {
            signcolumn = "no",
            number = false,
            relativenumber = false,
            cursorline = true,
            cursorcolumn = false,
            foldcolumn = "0",
            list = false,
          },
        },
        plugins = {
          gitsigns = { enabled = false },
          twilight = { enabled = false },
        },
        -- on_open = function()
        --   require("lsp-inlayhints").toggle()
        --   vim.g.cmp_active = false
        --   vim.cmd([[LspStop]])
        --   local status_ok, _ = pcall(vim.api.nvim_set_option_value, "winbar", nil, { scope = "local" })
        --   if not status_ok then
        --     return
        --   end
        --   if vim.fn.exists("#" .. "_winbar") == 1 then
        --     vim.cmd("au! " .. "_winbar")
        --   end
        -- end,

        -- on_close = function()
        --   require("lsp-inlayhints").toggle()
        --   vim.g.cmp_active = true
        --   vim.cmd([[LspStart]])

        --   pcall(function()
        --     require("SingularisArt.plugins.winbar")
        --   end)
        -- end,
      })
    end,
    cmd = "ZenMode",
  },

  {
    "folke/twilight.nvim",
    config = function()
      require("twilight").setup()
    end,
    cmd = "Twilight",
  },

  {
    "karb94/neoscroll.nvim",
    config = function()
      require("neoscroll").setup({
        mappings = { "<C-u>", "<C-d>", "<C-y>", "<C-e>", "zt", "zz", "zb", "n", "N" },
        hide_cursor = true,
        stop_eof = true,
        use_local_scrolloff = false,
        respect_scrolloff = true,
        cursor_scrolls_alone = false,
      })
    end,
    keys = {
      "<C-u>",
      "<C-d>",
      "<C-e>",
      "<C-y>",
      "zz",
      "n",
      "N",
    },
  },

  {
    "ghillb/cybu.nvim",
    config = function()
      require("cybu").setup({
        position = {
          relative_to = "win",
          anchor = "topright",
        },
        display_time = 1750,
        style = {
          path = "relative",
          border = "rounded",
          separator = " ",
          prefix = "…",
          padding = 1,
          hide_buffer_id = true,
          devicons = {
            enabled = true,
            colored = true,
          },
        },
      })

      vim.keymap.set("n", "H", "<Plug>(CybuPrev)")
      vim.keymap.set("n", "L", "<Plug>(CybuNext)")
    end,
    keys = {
      "H",
      "L",
    },
  },

  {
    "bennypowers/nvim-regexplainer",
    config = function()
      require("regexplainer").setup({
        mode = "narrative",
        auto = true,
        mappings = {
          toggle = "<Leader>gR",
        },

        narrative = {
          separator = "\n",
        },
      })
    end,
    cmd = {
      "RegexplainerToggle",
      "RegexplainerShow",
    },
  },

  {
    "danymat/neogen",
    config = function()
      require("neogen").setup({
        enabled = true,
        languages = {
          python = {
            template = {
              annotation_convention = "google_docstrings",
            },
          },
        },
      })
    end,
    cmd = "Neogen",
  },

  {
    "mbbill/undotree",
    config = function()
      vim.g.undotree_TreeNodeShape = "◦"
      vim.g.undotree_SetFocusWhenToggle = 1
    end,
    cmd = "UndotreeToggle",
  },

  {
    "nacro90/numb.nvim",
    config = function()
      require("numb").setup()
    end,
    event = "CmdlineEnter",
  },


  {
    "kevinhwang91/nvim-ufo",
    config = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }
      local handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = ("  %d "):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        table.insert(newVirtText, { suffix, "MoreMsg" })
        return newVirtText
      end
      local whitelist = {
        ["gotmpl"] = "indent",
        ["python"] = "lsp",
        ["html"] = "indent",
      }
      require("ufo").setup({
        provider_selector = function(bufnr, filetype)
          if whitelist[filetype] then
            return whitelist[filetype]
          end
          return ""
        end,
      })
      local bufnr = vim.api.nvim_get_current_buf()
      local ft = vim.o.ft
      if whitelist[ft] then
        require("ufo").setVirtTextHandler(bufnr, handler)
      end
    end,
    dependencies = { "kevinhwang91/promise-async" },
  },

  {
    "dhruvasagar/vim-table-mode",
    cmd = "TableModeToggle",
  },
}
