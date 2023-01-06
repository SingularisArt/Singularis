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
    lazy = false,
  },
}
