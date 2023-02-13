return {
  -- icons
  "nvim-tree/nvim-web-devicons",

  {
    "stevearc/dressing.nvim",
    config = function()
      require("dressing").setup()
    end,
    event = "BufEnter",
  },

  -- indent guides for Neovim
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      local indent_blankline = require("indent_blankline")

      vim.cmd("highlight IndentBlanklineChar guifg=Grey10 gui=nocombine")

      vim.g.indent_blankline_buftype_exclude = { "terminal", "nofile" }
      vim.g.indent_blankline_filetype_exclude = {
        "help",
        "startify",
        "dashboard",
        "packer",
        "neogitstatus",
        "NvimTree",
        "Trouble",
      }
      vim.g.indentLine_enabled = 1
      vim.g.indent_blankline_char = "▏"
      vim.g.indent_blankline_show_trailing_blankline_indent = false
      vim.g.indent_blankline_show_first_indent_level = true
      vim.g.indent_blankline_use_treesitter = true
      vim.g.indent_blankline_show_current_context = true
      vim.g.indent_blankline_context_patterns = {
        "class",
        "return",
        "function",
        "method",
        "^if",
        "^while",
        "jsx_element",
        "^for",
        "^object",
        "^table",
        "block",
        "arguments",
        "if_statement",
        "else_clause",
        "jsx_element",
        "jsx_self_closing_element",
        "try_statement",
        "catch_clause",
        "import_statement",
        "operation_type",
      }

      indent_blankline.setup({ show_current_context = true })
    end,
    event = "BufRead",
  },

  -- keys
  {
    "folke/which-key.nvim",
    config = function()
      require("lazyvim.plugins.ui.which-key")
    end,
    event = "BufEnter",
  },


  {
    "Pocco81/true-zen.nvim",
    config = function()
      require("true-zen").setup()
    end,
    cmd = {
      "TZAtaraxis",
      "TZMinimalist",
      "TZNarrow",
      "TZFocus",
    },
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
            cursorcolumn = false, -- disable cursor column
            foldcolumn = "0", -- disable fold column
            list = false, -- disable whitespace characters
          },
        },
        plugins = {
          gitsigns = { enabled = false },
          tmux = { enabled = false },
          twilight = { enabled = false },
        },
        on_open = function()
          require("lsp-inlayhints").toggle()
          vim.g.cmp_active = false
          vim.cmd("LspStop")
          local status_ok, _ = pcall(vim.api.nvim_set_option_value, "winbar", nil, { scope = "local" })
          if not status_ok then
            return
          end
          if vim.fn.exists("#" .. "_winbar") == 1 then
            vim.cmd("au! " .. "_winbar")
          end
        end,

        on_close = function()
          require("lsp-inlayhints").toggle()
          vim.g.cmp_active = true
          vim.cmd("LspStart")

          -- pcall(function()
          --   require("SingularisArt.plugins.winbar")
          -- end)
        end,
      })
    end,
    cmd = "ZenMode",
  },

  {
    "folke/twilight.nvim",
    config = function()
      require("twilight").setup()
    end,
  },

  {
    "dstein64/nvim-scrollview",
    config = function()
      if vim.wo.diff then
        return
      end
      local w = vim.api.nvim_call_function("winwidth", { 0 })
      if w < 70 then
        return
      end

      vim.g.scrollview_column = 1
    end,
    event = {
      "CursorMoved",
      "CursorMovedI",
    },
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
    "tjdevries/express_line.nvim",
    config = function()
      require("lazyvim.plugins.ui.statusline")
    end,
    event = "BufEnter",
  },

  {
    "akinsho/bufferline.nvim",
    config = function()
      require("lazyvim.plugins.ui.bufferline")
    end,
    event = "BufAdd",
  },

  -- {
  --   "kevinhwang91/nvim-hlslens",
  --   config = function()
  --     require("hlslens").setup()
  --     vim.cmd([[
  --       hi default link HlSearchNear IncSearch
  --       hi default link HlSearchLens WildMenu
  --       hi default link HlSearchLensNear IncSearch
  --       hi default link HlSearchFloat IncSearch
  --     ]])

  --     local kopts = { noremap = true, silent = true }

  --     vim.api.nvim_set_keymap("n", "n",
  --       [[<CMD>execute("normal! " . v:count1 . "n")<CR><CMD>lua require("hlslens").start()<CR>]], kopts)
  --     vim.api.nvim_set_keymap("n", "N",
  --       [[<CMD>execute("normal! " . v:count1 . "N")<CR><CMD>lua require("hlslens").start()<CR>]], kopts)

  --     vim.api.nvim_set_keymap("n", "*", "*<CMD>lua require(\"hlslens\").start()<CR>", kopts)
  --     vim.api.nvim_set_keymap("n", "#", "#<CMD>lua require(\"hlslens\").start()<CR>", kopts)
  --     vim.api.nvim_set_keymap("n", "g*", "g*<CMD>lua require(\"hlslens\").start()<CR>", kopts)
  --     vim.api.nvim_set_keymap("n", "g#", "g#<CMD>lua require(\"hlslens\").start()<CR>", kopts)
  --   end,
  --   keys = {
  --     "n",
  --     "N",
  --     "*",
  --     "#",
  --     "g*",
  --     "g#",
  --   },
  -- },

  {
    "SingularisArt/pommodoro-clock.nvim",
    config = function()
      require("pommodoro-clock").setup()
    end,
    keys = {
      "<Leader>pw",
      "<Leader>ps",
      "<Leader>pl",
      "<Leader>pc",
      "<Leader>pC",
    },
  },
}
