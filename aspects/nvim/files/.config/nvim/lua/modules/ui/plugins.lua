local conf = require("modules.ui.config")

return function(use)
  use({ "nvim-tree/nvim-web-devicons" })

  use({ "windwp/windline.nvim" })
  use({ "MunifTanjim/nui.nvim" })

  use({ "lambdalisue/glyph-palette.vim" })

  use({
    "folke/which-key.nvim",
    config = function()
      require("modules.ui.which-key")
    end,
    event = "BufEnter",
  })

  use({
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
  })

  use({
    "folke/zen-mode.nvim",
    config = conf.zen_mode,
    cmd = "ZenMode",
  })

  use({
    "folke/twilight.nvim",
    config = function()
      require("twilight").setup()
    end,
  })

  use({
    "stevearc/dressing.nvim",
    init = function()
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
  })

  use({
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    version = "2.20.8",
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
    },
  })

  use({
    "kevinhwang91/nvim-hlslens",
    config = conf.hlslens,
    keys = {
      "n",
      "N",
      "*",
      "#",
      "g*",
      "g#",
    },
  })

  use({
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
  })

  use({
    "dstein64/nvim-scrollview",
    config = function()
      require("scrollview").setup({
        excluded_filetypes = { "nerdtree" },
        signs_on_startup = {},
        diagnostics_severities = {},
      })
    end,
    event = {
      "CursorMoved",
      "CursorMovedI",
    },
  })

  use({
    "NvChad/nvim-colorizer.lua",
    opts = {
      user_default_options = {
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
        sass = { enable = true, parsers = { "css" } },
        virtualtext = "■",
        always_update = true,
      },
    },
  })

  use({
    "echasnovski/mini.hues",
    config = function()
      require("mini.hues").setup({ background = "#090610", foreground = "#acc2d2", saturation = "high", n_hues = 6 })
    end,
    lazy = false,
  })
end
