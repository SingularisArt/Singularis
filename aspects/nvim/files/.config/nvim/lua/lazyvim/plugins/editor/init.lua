return {
  -- file explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    config = function()
      require("neo-tree").setup({
        popup_border_style = "rounded",
        enable_diagnostics = false,
        default_component_configs = {
          indent = {
            padding = 0,
            with_expanders = false,
          },
          icon = {
            folder_closed = "",
            folder_open = "",
            folder_empty = "",
            default = "",
          },
          git_status = {
            symbols = {
              added = "",
              deleted = "",
              modified = "",
              renamed = "➜",
              untracked = "★",
              ignored = "◌",
              unstaged = "✗",
              staged = "✓",
              conflict = "",
            },
          },
        },
        window = {
          width = 25,
          mappings = {
            ["o"] = "open",
          },
        },
        filesystem = {
          filtered_items = {
            visible = false,
            hide_dotfiles = true,
            hide_gitignored = false,
            hide_by_name = {
              ".DS_Store",
              "thumbs.db",
              "node_modules",
              "__pycache__",
            },
          },
          follow_current_file = true,
          hijack_netrw_behavior = "open_current",
          use_libuv_file_watcher = true,
        },
        git_status = {
          window = {
            position = "float",
          },
        },
        event_handlers = {
          {
            event = "vim_buffer_enter",
            handler = function(_)
              if vim.bo.filetype == "neo-tree" then
                vim.wo.signcolumn = "auto"
              end
            end,
          },
        },
      })
    end,
    cmd = "Neotree",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
  },

  -- floating file explorer
  {
    "tamago324/lir.nvim",
    config = function()
      local lir = require("lir")

      local actions = require("lir.actions")
      local mark_actions = require("lir.mark.actions")
      local clipboard_actions = require("lir.clipboard.actions")

      lir.setup({
        show_hidden_files = false,
        devicons = { enable = true },
        mappings = {
          ["<cr>"] = actions.edit,
          ["l"] = actions.edit,
          ["<C-s>"] = actions.split,
          ["v"] = actions.vsplit,
          ["<C-t>"] = actions.tabedit,

          ["h"] = actions.up,
          ["q"] = actions.quit,

          ["A"] = actions.mkdir,
          ["a"] = actions.newfile,
          ["r"] = actions.rename,
          ["@"] = actions.cd,
          ["Y"] = actions.yank_path,
          ["i"] = actions.toggle_show_hidden,
          ["d"] = actions.delete,

          ["J"] = function()
            mark_actions.toggle_mark()
            vim.cmd("normal! j")
          end,
          ["c"] = clipboard_actions.copy,
          ["x"] = clipboard_actions.cut,
          ["p"] = clipboard_actions.paste,
        },
        float = {
          winblend = 0,
          curdir_window = {
            enable = false,
            highlight_dirname = true,
          },

          -- -- You can define a function that returns a table to be passed as the third
          -- -- argument of nvim_open_win().
          win_opts = function()
            local width = math.floor(vim.o.columns * 0.7)
            local height = math.floor(vim.o.lines * 0.7)
            return {
              border = "rounded",
              width = width,
              height = height,
              -- row = 1,
              -- col = math.floor((vim.o.columns - width) / 2),
            }
          end,
        },
        hide_cursor = false,
        on_init = function()
          -- use visual mode
          vim.api.nvim_buf_set_keymap(
            0,
            "x",
            "J",
            ':<C-u>lua require"lir.mark.actions".toggle_mark("v")<CR>',
            { noremap = true, silent = true }
          )

          -- echo cwd
          -- vim.api.nvim_echo({ { vim.fn.expand "%:p", "Normal" } }, false, {})
        end,
      })

      -- custom folder icon
      require("nvim-web-devicons").set_icon({
        lir_folder_icon = {
          icon = "",
          -- color = "#7ebae4",
          -- color = "#569CD6",
          color = "#42A5F5",
          name = "LirFolderNode",
        },
      })
    end,
    keys = {
      { "<Leader>-", "<CMD>lua require('lir.float').toggle()<CR>" },
    },
  },

  -- search/replace in multiple files
  {
    "windwp/nvim-spectre",
    -- stylua: ignore
    keys = {
      { "<leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
    },
  },

  -- fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    config = function()
      require("lazyvim.plugins.editor.telescope")
    end,
    cmd = "Telescope",
  },

  -- which-key
  {
    "folke/which-key.nvim",
    config = function()
      require("lazyvim.plugins.editor.which-key")
    end,
    event = "BufEnter",
  },

  -- git signs
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      local gitsigns = require("gitsigns")

      gitsigns.setup({
        signs = {
          add = {
            hl = "GitSignsAdd",
            text = "▎",
            numhl = "GitSignsAddNr",
            linehl = "GitSignsAddLn",
          },
          change = {
            hl = "GitSignsChange",
            text = "▎",
            numhl = "GitSignsChangeNr",
            linehl = "GitSignsChangeLn",
          },
          delete = {
            hl = "GitSignsDelete",
            text = "契",
            numhl = "GitSignsDeleteNr",
            linehl = "GitSignsDeleteLn",
          },
          topdelete = {
            hl = "GitSignsDelete",
            text = "契",
            numhl = "GitSignsDeleteNr",
            linehl = "GitSignsDeleteLn",
          },
          changedelete = {
            hl = "GitSignsChange",
            text = "▎",
            numhl = "GitSignsChangeNr",
            linehl = "GitSignsChangeLn",
          },
        },
        numhl = false,
        linehl = false,
        keymaps = {
          -- Default keymap options
          noremap = true,
          buffer = true,
        },
        signcolumn = true,
        word_diff = false,
        attach_to_untracked = true,
        current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        -- current_line_blame_opts = {
        --   virt_text = true,
        --   virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        --   delay = 1000,
        --   ignore_whitespace = false,
        -- },
        -- current_line_blame_formatter_opts = {
        --   relative_time = false,
        -- },
        max_file_length = 40000,
        preview_config = {
          -- Options passed to nvim_open_win
          border = "rounded",
          style = "minimal",
          relative = "cursor",
          row = 0,
          col = 1,
        },
        watch_gitdir = {
          interval = 1000,
          follow_files = true,
        },
        sign_priority = 6,
        update_debounce = 200,
        status_formatter = nil,
        yadm = { enable = false },
      })
    end,
    event = "BufReadPost",
  },

  -- references
  {
    "RRethy/vim-illuminate",
    config = function()
      require("illuminate").configure({ delay = 200 })
    end,
    event = "BufRead",
  },

  -- better diagnostics list and others
  {
    "folke/trouble.nvim",
    config = function()
      require("trouble").setup()
    end,
    cmd = {
      "Trouble",
      "TroubleClose",
      "TroubleToggle",
      "TroubleRefresh",
    },
  },

  -- todo comments
  {
    "folke/todo-comments.nvim",
    config = function()
      local todo_comments = require("todo-comments")

      local icons = require("lazyvim.config.global").icons

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
    event = "BufRead",
  },

  {
    "nacro90/numb.nvim",
    config = function()
      require("numb").setup()
    end,
    event = "CmdlineEnter",
  },

  {
    "andymass/vim-matchup",
    config = function()
      vim.g.matchup_enabled = 1
      vim.g.matchup_surround_enabled = 1
      vim.g.matchup_transmute_enabled = 1
      vim.g.matchup_matchparen_deferred = 1
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
      vim.cmd([[nnoremap <c-s-k> :<c-u>MatchupWhereAmI?<cr>]])
    end,
    event = {
      "CursorHold",
      "CursorHoldI",
    },
  },

  {
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup({
        keymaps = {
          visual = "<Leader>cr",
        },
      })
    end,
    keys = {
      "ys",
      "ds",
      "cs",
    },
  },

  {
    "chrisbra/Colorizer",
    ft = {
      "log",
      "txt",
      "text",
    },
  },

  {
    "booperlv/nvim-gomove",
    config = function()
      require("gomove").setup({
        map_defaults = true,
        reindent_mode = "vim-move",
        move_past_line = false,
        ignore_indent_lh_dup = true,
      })
    end,
    keys = {
      "v",
      "V",
      "<c-v>",
      "<c-V>",
    },
  },

  {
    "kevinhwang91/nvim-bqf",
    config = function()
      require("bqf").setup()
    end,
    cmd = {
      "BqfEnable",
      "BqfDisable",
      "BqfToggle",
      "BqfAutoToggle",
    },
    dependencies = {
      {
        "junegunn/fzf",
        run = function()
          vim.fn["fzf#install"]()
        end,
      },
    },
    ft = "qf",
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
    dependencies = "kevinhwang91/promise-async",
    lazy = false,
  },

  {
    "phaazon/hop.nvim",
    config = function()
      require("hop").setup()
    end,
    cmd = {
      "HopWord",
      "HopWordBC",
      "HopWordAC",
      "HopWordCurrentLine",
      "HopWordCurrentLineBC",
      "HopWordCurrentLineAC",
      "HopWordMW",
      "HopPattern",
      "HopPatternBC",
      "HopPatternAC",
      "HopPatternCurrentLine",
      "HopPatternCurrentLineBC",
      "HopPatternCurrentLineAC",
      "HopPatternMW",
      "HopChar1",
      "HopChar1BC",
      "HopChar1AC",
      "HopChar1CurrentLine",
      "HopChar1CurrentLineBC",
      "HopChar1CurrentLineAC",
      "HopChar1MW",
      "HopChar2",
      "HopChar2BC",
      "HopChar2AC",
      "HopChar2CurrentLine",
      "HopChar2CurrentLineBC",
      "HopChar2CurrentLineAC",
      "HopChar2MW",
      "HopLine",
      "HopLineBC",
      "HopLineAC",
      "HopLineCurrentLine",
      "HopLineCurrentLineBC",
      "HopLineCurrentLineAC",
      "HopLineMW",
      "HopLineStart",
      "HopLineStartBC",
      "HopLineStartAC",
      "HopLineStartCurrentLine",
      "HopLineStartCurrentLineBC",
      "HopLineStartCurrentLineAC",
      "HopLineStartMW",
      "HopVertical",
      "HopVerticalBC",
      "HopVerticalAC",
      "HopVerticalMW",
      "HopAnywhere",
      "HopAnywhereBC",
      "HopAnywhereAC",
      "HopAnywhereCurrentLine",
      "HopAnywhereCurrentLineBC",
      "HopAnywhereCurrentLineAC",
      "HopAnywhereMW",
    },
  },
  { "indianboy42/hop-extensions", after = "hop.nvim" },

  {
    "rmagatti/alternate-toggler",
    config = function()
      print("hi")
      require("alternate-toggler").setup({})
    end,
    keys = {
      { "<Space>t", "<CMD>lua require('alternate-toggler').toggleAlternate()<CR>" },
    },
  },

  -- {
  --   "wincent/corpus",
  --   config = function()
  --   end,
  --   event = "BufEnter",
  -- },

  {
    "mbbill/undotree",
    config = function()
      vim.cmd([[
      if has("persistent_undo")
        let target_path = expand("~/.config/nvim/misc/undo")

        " create the directory and any parent directories
        " if the location does not exist.
        if !isdirectory(target_path)
          call mkdir(target_path, "p", 0700)
        endif

        let &undodir=target_path
        set undofile
      endif
    ]])
    end,
    cmd = "UndotreeToggle",
  },
}
