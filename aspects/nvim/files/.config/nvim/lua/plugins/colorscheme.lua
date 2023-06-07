return {
  {
    "echasnovski/mini.hues",
    config = function()
      require("mini.hues").setup({ background = "#09182E", foreground = "#dcc9db", saturation = "high", n_hues = 6 })
    end,
    lazy = true,
  },

  {
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
  },

  {
    "folke/tokyonight.nvim",
    config = function()
      local tokyonight = require("tokyonight")
      tokyonight.setup({ style = "night" })
      tokyonight.load()
    end,
    lazy = true,
  },

  {
    "LunarVim/horizon.nvim",
    config = function()
      vim.cmd("colorscheme horizon")
    end,
    lazy = true,
  },

  {
    "LunarVim/onedarker.nvim",
    config = function()
      vim.cmd("colorscheme onedarker")
    end,
    lazy = true,
  },

  {
    "sainnhe/sonokai",
    config = function()
      vim.g.sonokai_style = "atlantis"
      vim.g.sonokai_better_performance = 1
      vim.cmd("colorscheme sonokai")
    end,
    lazy = true,
  },

  {
    "sainnhe/everforest",
    config = function()
      vim.g.everforest_background = "dark"
      vim.g.everforest_better_performance = 1
      vim.cmd("colorscheme everforest")
    end,
    lazy = true,
  },

  {
    "sainnhe/edge",
    config = function()
      vim.g.edge_style = "neon"
      vim.g.edge_better_performance = 1
      vim.cmd("colorscheme edge")
    end,
    lazy = true,
  },

  {
    "EdenEast/nightfox.nvim",
    config = function()
      vim.cmd("colorscheme nightfox")
    end,
    lazy = true,
  },

  {
    "martinsione/darkplus.nvim",
    config = function()
      vim.cmd("colorscheme darkplus")
    end,
    lazy = true,
  },

  {
    "LunarVim/synthwave84.nvim",
    config = function()
      vim.cmd("colorscheme synthwave84")
    end,
    lazy = true,
  },

  {
    "glepnir/zephyr-nvim",
    config = function()
      vim.cmd("colorscheme zephyr")
    end,
    lazy = true,
  },
  {
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
  },
  {
    "nekonako/xresources-nvim",
    config = function()
      require("xresources")
    end,
    lazy = true,
  },
  {
    "talha-akram/noctis.nvim",
    config = function()
      vim.cmd("colorscheme noctis_minimus")
    end,
    lazy = true,
  },
  {
    "Yazeed1s/oh-lucy.nvim",
    config = function()
      vim.cmd("colorscheme oh-lucy-evening")
    end,
    lazy = true,
  },
  {
    "kvrohit/mellow.nvim",
    config = function()
      vim.cmd("colorscheme mellow")
    end,
    lazy = true,
  },

  {
    "bluz71/vim-nightfly-colors",
    config = function()
      vim.cmd("colorscheme nightfly")
    end,
    lazy = true,
  },

  {
    "JoosepAlviste/palenightfall.nvim",
    config = function()
      require("palenightfall").setup()
    end,
    lazy = true,
  },

  {
    "noorwachid/nvim-nightsky",
    config = function()
      vim.cmd("colorscheme nightsky")
    end,
    lazy = true,
  },

  {
    "AlexvZyl/nordic.nvim",
    config = function()
      require("nordic").load()
    end,
    lazy = true,
  },

  {
    "AlphaTechnolog/pywal.nvim",
    config = function()
      require("pywal").setup()
    end,
    lazy = true,
  },

  {
    "sainnhe/gruvbox-material",
    config = function()
      vim.g.gruvbox_material_better_performance = 1
      vim.g.gruvbox_material_background = "hard"

      vim.cmd("colorscheme gruvbox-material")
    end,
    lazy = false,
  },

  { "ray-x/starry.nvim", lazy = true },
  { "catppuccin/nvim", as = "catppuccin", lazy = true },
  { "projekt0n/github-nvim-theme", lazy = true },
  { "flazz/vim-colorschemes", lazy = true },
  { "wincent/base16-nvim", lazy = true },
}
