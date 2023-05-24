return {
  -- icons
  "nvim-tree/nvim-web-devicons",

  -- ui components
  "MunifTanjim/nui.nvim",

  -- keys
  {
    "folke/which-key.nvim",
    config = function()
      require("plugins.ui.which-key")
    end,
    event = "BufEnter",
  },

  -- noicer ui
  {
    "folke/noice.nvim",
    config = function()
      local noice = require("noice")
      noice.setup({
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
          hover = {
            enabled = false,
            view = nil, -- when nil, use defaults from documentation
            opts = {}, -- merged with defaults from documentation
          },
          signature = {
            enabled = false,
            auto_open = {
              enabled = true,
              trigger = true, -- Automatically show signature help when typing a trigger character from the LSP
              luasnip = true, -- Will open signature help when jumping to Luasnip insert nodes
              throttle = 50, -- Debounce lsp signature help request by 50ms
            },
            view = nil, -- when nil, use defaults from documentation
            opts = {}, -- merged with defaults from documentation
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = false, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false, -- add a border to hover docs and signature help
        },
        views = {
          cmdline_popup = {
            border = {
              -- style = { "▄", "▄", "▄", "█", "▀", "▀", "▀", "█", "1" }, -- [ top top top - right - bottom bottom bottom - left ]
              style = "rounded",
              padding = { 0, 0 },
            },
            filter_options = {},
          },
        },
      })
    end,
    event = "VeryLazy",
  },

  {
    "rcarriga/nvim-notify",
    keys = {
      {
        "<leader>un",
        function()
          require("notify").dismiss({ silent = true, pending = true })
        end,
        desc = "Delete all Notifications",
      },
    },
    opts = {
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
    },
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
            foldcolumn = "0",     -- disable fold column
            list = false,         -- disable whitespace characters
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

  -- better vim.ui
  {
    "stevearc/dressing.nvim",
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
  },

  -- indent guides for Neovim
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      char = "▏",
      context_char = "▏",
      show_end_of_line = false,
      space_char_blankline = " ",
      show_current_context = true,
      show_current_context_start = true,
      filetype_exclude = {
        "help",
        "startify",
        "dashboard",
        "packer",
        "neogitstatus",
        "NvimTree",
        "Trouble",
        "alpha",
        "neo-tree",
      },
      buftype_exclude = {
        "terminal",
        "nofile",
      },
      -- char_highlight_list = {
      --   "IndentBlanklineIndent1",
      --   "IndentBlanklineIndent2",
      --   "IndentBlanklineIndent3",
      --   "IndentBlanklineIndent4",
      --   "IndentBlanklineIndent5",
      --   "IndentBlanklineIndent6",
      -- },
    },
  },

  -- bufferline
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        diagnostics = "nvim_lsp",
        always_show_bufferline = false,
        diagnostics_indicator = function(_, _, diag)
          local icons = require("config.global").icons.diagnostics
          local ret = (diag.error and icons.Error .. diag.error .. " " or "")
              .. (diag.warning and icons.Warn .. diag.warning or "")
          return vim.trim(ret)
        end,
        offsets = {
          {
            filetype = "neo-tree",
            text = "Neo-tree",
            highlight = "Directory",
            text_align = "left",
          },
        },
      },
    },
  },

  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      local lualine_config = require("plugins.ui.lualine")
      lualine_config.setup({
        float = false,
        separator = "bubble", -- bubble | triangle
        ---@type any
        colorful = true,
      })
      lualine_config.load()
    end,
    event = "VeryLazy",
  },

  -- lsp symbol navigation for lualine
  "SmiteshP/nvim-navic",

  {
    "kevinhwang91/nvim-hlslens",
    config = function()
      require("hlslens").setup()
      vim.cmd([[
        hi default link HlSearchNear IncSearch
        hi default link HlSearchLens WildMenu
        hi default link HlSearchLensNear IncSearch
        hi default link HlSearchFloat IncSearch
        ]])

      local kopts = { noremap = true, silent = true }

      vim.api.nvim_set_keymap("n", "n",
        [[<CMD>execute("normal! " . v:count1 . "n")<CR><CMD>lua require("hlslens").start()<CR>]], kopts)
      vim.api.nvim_set_keymap("n", "N",
        [[<CMD>execute("normal! " . v:count1 . "N")<CR><CMD>lua require("hlslens").start()<CR>]], kopts)

      vim.api.nvim_set_keymap("n", "*", "*<CMD>lua require(\"hlslens\").start()<CR>", kopts)
      vim.api.nvim_set_keymap("n", "#", "#<CMD>lua require(\"hlslens\").start()<CR>", kopts)
      vim.api.nvim_set_keymap("n", "g*", "g*<CMD>lua require(\"hlslens\").start()<CR>", kopts)
      vim.api.nvim_set_keymap("n", "g#", "g#<CMD>lua require(\"hlslens\").start()<CR>", kopts)
    end,
    keys = {
      "n",
      "N",
      "*",
      "#",
      "g*",
      "g#",
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
    "b0o/incline.nvim",
    event = "BufReadPre",
    config = function()
      -- local colors = require("tokyonight.colors").setup()
      require("incline").setup({
        highlight = {
          groups = {
            InclineNormal = { guibg = "#FC56B1", guifg = "000" },
            InclineNormalNC = { guifg = "#FC56B1", guibg = "000" },
          },
        },
        window = { margin = { vertical = 0, horizontal = 1 } },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          local icon, color = require("nvim-web-devicons").get_icon_color(filename)
          return { { icon, guifg = color }, { " " }, { filename } }
        end,
      })
    end,
  },

  {
    "NvChad/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({
        RGB = true,
        RRGGBB = true,
        names = true,
        RRGGBBAA = true,
        AARRGGBB = true,
        rgb_fn = true,
        hsl_fn = true,
        css = true,
        css_fn = true,
        mode = "background",
        tailwind = true,
        sass = { enable = true, parsers = { "css" }, },
        virtualtext = "■",
        always_update = true,
      })
    end,
    lazy = false,
  },
}
