return {
  {
    "wincent/base16-nvim",
    config = require("SingularisArt.plugins.colorschemes.functions").base16,
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
    "martinsione/darkplus.nvim",
    config = function()
      vim.cmd("colorscheme darkplus")
    end,
    lazy = true,
  },
  {
    "flazz/vim-colorschemes",
    config = require("SingularisArt.plugins.colorschemes.functions").vim_colorschemes,
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
    "folke/tokyonight.nvim",
    config = require("SingularisArt.plugins.colorschemes.functions").tokyonight,
    lazy = true,
  },
  {
    "projekt0n/github-nvim-theme",
    config = require("SingularisArt.plugins.colorschemes.functions").github_theme,
    lazy = true,
  },
  {
    "sainnhe/sonokai",
    config = require("SingularisArt.plugins.colorschemes.functions").sonokai,
    lazy = true,
  },
  {
    "sainnhe/gruvbox-material",
    config = require("SingularisArt.plugins.colorschemes.functions").gruvbox,
    lazy = true,
  },
  {
    "catppuccin/nvim",
    as = "catppuccin",
    config = require("SingularisArt.plugins.colorschemes.functions").catppuccin,
    lazy = true,
  },
  {
    "ray-x/starry.nvim",
    config = require("SingularisArt.plugins.colorschemes.functions").starry,
    lazy = true,
  },
  {
    "sainnhe/everforest",
    config = require("SingularisArt.plugins.colorschemes.functions").everforest,
    lazy = true,
  },
  {
    "sainnhe/edge",
    config = require("SingularisArt.plugins.colorschemes.functions").edge,
    lazy = true,
  },
  {
    "EdenEast/nightfox.nvim",
    config = require("SingularisArt.plugins.colorschemes.functions").nightfox,
    lazy = true,
  },
}
