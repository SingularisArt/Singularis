return {
  {
    "folke/tokyonight.nvim",
    config = function()
      local tokyonight = require("tokyonight")
      tokyonight.setup({ style = "moon" })
      tokyonight.load()
    end,
    lazy = true,
  },

  {
    "LunarVim/horizon.nvim",
    config = function()
      vim.cmd("colorscheme horizon")
    end,
    lazy = false,
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

  { "ray-x/starry.nvim", lazy = true },
  { "catppuccin/nvim", as = "catppuccin", lazy = true },
  { "sainnhe/gruvbox-material", lazy = true },
  { "projekt0n/github-nvim-theme", lazy = true },
  { "flazz/vim-colorschemes", lazy = true },
  { "wincent/base16-nvim", lazy = true },
}
