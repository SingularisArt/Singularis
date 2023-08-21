local conf = require("modules.ui.config")

return function(use)
  use({ "nvim-tree/nvim-web-devicons" })

  use({ "windwp/windline.nvim" })
  use({ "MunifTanjim/nui.nvim" })

  use({ "lambdalisue/glyph-palette.vim" })

  use({
    "akinsho/bufferline.nvim",
    config = conf.nvim_bufferline,
    lazy = true,
  })

  use({
    "folke/which-key.nvim",
    config = function()
      require("plugins.ui.which-key")
    end,
    event = "BufEnter",
  })

  use({ "rcarriga/nvim-notify" })

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
    event = "VeryLazy",
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
        sass = { enable = true, parsers = { "css" }, },
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

  use({
    "loctvl842/monokai-pro.nvim",
    config = function()
      local monokai = require("monokai-pro")
      monokai.setup({
        transparent_background = false,
        devicons = true,
        filter = "spectrum",
        day_night = {
          enable = false,
          day_filter = "classic",
          night_filter = "octagon",
        },
        inc_search = "background",
        background_clear = {},
        plugins = {
          bufferline = {
            underline_selected = true,
            underline_visible = false,
            bold = false,
          },
          indent_blankline = {
            context_highlight = "pro",
            context_start_underline = true,
          },
        },
      })
      monokai.load()
    end,
    lazy = true,
  })

  use({
    "folke/tokyonight.nvim",
    config = function()
      local tokyonight = require("tokyonight")
      tokyonight.setup({ style = "night" })
      tokyonight.load()
    end,
    lazy = true,
  })

  use({
    "LunarVim/horizon.nvim",
    config = function()
      vim.cmd("colorscheme horizon")
    end,
    lazy = true,
  })

  use({
    "LunarVim/onedarker.nvim",
    config = function()
      vim.cmd("colorscheme onedarker")
    end,
    lazy = true,
  })

  use({
    "sainnhe/sonokai",
    config = function()
      vim.g.sonokai_style = "atlantis"
      vim.g.sonokai_better_performance = 1
      vim.cmd("colorscheme sonokai")
    end,
    lazy = true,
  })

  use({
    "sainnhe/everforest",
    config = function()
      vim.g.everforest_background = "dark"
      vim.g.everforest_better_performance = 1
      vim.cmd("colorscheme everforest")
    end,
    lazy = true,
  })

  use({
    "sainnhe/edge",
    config = function()
      vim.g.edge_style = "neon"
      vim.g.edge_better_performance = 1
      vim.cmd("colorscheme edge")
    end,
    lazy = true,
  })

  use({
    "EdenEast/nightfox.nvim",
    config = function()
      vim.cmd("colorscheme nightfox")
    end,
    lazy = true,
  })

  use({
    "martinsione/darkplus.nvim",
    config = function()
      vim.cmd("colorscheme darkplus")
    end,
    lazy = true,
  })

  use({
    "LunarVim/synthwave84.nvim",
    config = function()
      vim.cmd("colorscheme synthwave84")
    end,
    lazy = true,
  })

  use({
    "glepnir/zephyr-nvim",
    config = function()
      vim.cmd("colorscheme zephyr")
    end,
    lazy = true,
  })

  use({
    "ray-x/aurora",
    config = function()
      vim.cmd("colorscheme aurora")
    end,
    lazy = true,
    setup = function()
      vim.g.aurora_italic = 1
      vim.g.aurora_transparent = 1
      vim.g.aurora_bold = 1
    end,
  })

  use({
    "nekonako/xresources-nvim",
    config = function()
      require("xresources")
    end,
    lazy = true,
  })

  use({
    "talha-akram/noctis.nvim",
    config = function()
      vim.cmd("colorscheme noctis_minimus")
    end,
    lazy = true,
  })

  use({
    "Yazeed1s/oh-lucy.nvim",
    config = function()
      vim.cmd("colorscheme oh-lucy-evening")
    end,
    lazy = true,
  })

  use({
    "kvrohit/mellow.nvim",
    config = function()
      vim.cmd("colorscheme mellow")
    end,
    lazy = true,
  })

  use({
    "bluz71/vim-nightfly-colors",
    config = function()
      vim.cmd("colorscheme nightfly")
    end,
    lazy = true,
  })

  use({
    "JoosepAlviste/palenightfall.nvim",
    config = function()
      require("palenightfall").setup()
    end,
    lazy = true,
  })

  use({
    "noorwachid/nvim-nightsky",
    config = function()
      vim.cmd("colorscheme nightsky")
    end,
    lazy = true,
  })

  use({
    "AlexvZyl/nordic.nvim",
    config = function()
      require("nordic").load()
    end,
    lazy = true,
  })

  use({
    "AlphaTechnolog/pywal.nvim",
    config = function()
      require("pywal").setup()
    end,
    lazy = true,
  })

  use({
    "sainnhe/gruvbox-material",
    config = function()
      vim.g.gruvbox_material_better_performance = 1
      vim.g.gruvbox_material_background = "hard"

      vim.cmd("colorscheme gruvbox-material")
    end,
    lazy = true,
  })

  use({
    "rebelot/kanagawa.nvim",
    lazy = true,
    config = conf.kanagawa,
  })

  use({ "ray-x/starry.nvim" })
  use({ "projekt0n/github-nvim-theme" })
  use({ "flazz/vim-colorschemes" })
  use({ "wincent/base16-nvim" })
  use({ "bluz71/vim-nightfly-colors" })
  use({ "projekt0n/github-nvim-theme" })
  use({ "sainnhe/sonokai" })
  use({ "sainnhe/gruvbox-material" })
  use({ "catppuccin/nvim", name = "catppuccin" })

  use({
    "ray-x/starry.nvim",
    init = conf.starry,
    config = conf.starry_conf,
  })
end
