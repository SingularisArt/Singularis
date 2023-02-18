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

  -- -- noicer ui
  -- {
  --   "folke/noice.nvim",
  --   event = "VeryLazy",
  --   opts = {
  --     lsp = {
  --       hover = {
  --         enabled = false,
  --       },
  --       signature = {
  --         enabled = false,
  --       },
  --     },
  --     presets = {
  --       bottom_search = true,
  --       command_palette = true,
  --       long_message_to_split = true,
  --     },
  --   },
  -- },

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
      -- char = "▏",
char = "│",
      filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy" },
      show_trailing_blankline_indent = false,
      show_current_context = false,
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
    event = "VeryLazy",
    opts = function(plugin)
      local icons = require("config.global").icons

      local function fg(name)
        return function()
          ---@type {foreground?:number}?
          local hl = vim.api.nvim_get_hl_by_name(name, true)
          return hl and hl.foreground and { fg = string.format("#%06x", hl.foreground) }
        end
      end

      return {
        options = {
          theme = "auto",
          globalstatus = true,
          disabled_filetypes = { statusline = { "dashboard", "lazy", "alpha" } },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch" },
          lualine_c = {
            {
              "diagnostics",
              symbols = {
                error = icons.diagnostics.Error,
                warn = icons.diagnostics.Warn,
                info = icons.diagnostics.Info,
                hint = icons.diagnostics.Hint,
              },
            },
            { "filetype", icon_only = true, separator = "",                                               padding = { left = 1, right = 0 } },
            { "filename", path = 1,         symbols = { modified = "  ", readonly = "", unnamed = "" } },
            -- stylua: ignore
            {
              function() return require("nvim-navic").get_location() end,
              cond = function() return package.loaded["nvim-navic"] and require("nvim-navic").is_available() end,
            },
          },
          lualine_x = {
            -- stylua: ignore
            {
              function() return require("noice").api.status.command.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
              color = fg("Statement")
            },
            -- stylua: ignore
            {
              function() return require("noice").api.status.mode.get() end,
cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
              color = fg("Constant"),
            },
            { require("lazy.status").updates, cond = require("lazy.status").has_updates, color = fg("Special") },
            {
              "diff",
              symbols = {
                added = icons.git.added,
                modified = icons.git.modified,
                removed = icons.git.removed,
              },
            },
          },
          lualine_y = {
            { "progress", separator = " ",                  padding = { left = 1, right = 0 } },
            { "location", padding = { left = 0, right = 1 } },
          },
          lualine_z = {
            function()
              return " " .. os.date("%R")
            end,
          },
        },
        extensions = { "neo-tree" },
      }
    end,
  },

  -- lsp symbol navigation for lualine
  { "SmiteshP/nvim-navic" },

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
      local colors = require("tokyonight.colors").setup()
      require("incline").setup({
        highlight = {
          groups = {
            InclineNormal = { guibg = "#FC56B1", guifg = colors.black },
            InclineNormalNC = { guifg = "#FC56B1", guibg = colors.black },
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

  -- auto-resize windows
  {
    "anuvyklack/windows.nvim",
    event = "WinNew",
    dependencies = {
      { "anuvyklack/middleclass" },
      { "anuvyklack/animation.nvim", enabled = false },
    },
    keys = { { "<leader>Z", "<cmd>WindowsMaximize<cr>", desc = "Zoom" } },
    config = function()
      vim.o.winwidth = 5
      vim.o.equalalways = false
      require("windows").setup({
        animation = { enable = false, duration = 150 },
      })
    end,
  },

  -- style windows with different colorschemes
  {
    "folke/styler.nvim",
    event = "VeryLazy",
    opts = {
      themes = {
        markdown = { colorscheme = "tokyonight-storm" },
        help = { colorscheme = "oxocarbon", background = "dark" },
      },
    },
  },
}
