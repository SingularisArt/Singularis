if vim.g.isInkscape then
  return function(_use) end
end

local latexPlugins = {
  "echasnovski/mini.hues",
  config = function()
    -- require("mini.hues").setup({ background = "#090610", foreground = "#acc2d2", saturation = "high", n_hues = 6 })
    -- require("mini.hues").setup({ background = "#0E0814", foreground = "#cfd9dc", saturation = "high", n_hues = 6
    require("mini.hues").setup({ background = "#0f0c22", foreground = "#7cdeec", saturation = "high", n_hues = 6 })
  end,
  lazy = false,
  -- {
  --   "echasnovski/mini.hues",
  --   config = function()
  --     -- require("mini.hues").setup({ background = "#090610", foreground = "#acc2d2", saturation = "high", n_hues = 6 })
  --     -- require("mini.hues").setup({ background = "#0E0814", foreground = "#cfd9dc", saturation = "high", n_hues = 6
  --     require("mini.hues").setup({ background = "#0f0c22", foreground = "#7cdeec", saturation = "high", n_hues = 6 })
  --   end,
  --   lazy = false,
  -- },
  -- {
  --   "folke/which-key.nvim",
  --   config = function()
  --     require("modules.ui.which-key")
  --   end,
  --   event = "BufEnter",
  -- },
}

if vim.g.isLATEX then
  return function(use)
    use(latexPlugins)
    use({ "windwp/windline.nvim" })
  end
end

local conf = require("modules.ui.config")

return function(use)
  use(latexPlugins)

  use({ "nvim-tree/nvim-web-devicons" })

  use({ "MunifTanjim/nui.nvim" })

  use({ "lambdalisue/glyph-palette.vim" })

  use({
    "stevearc/dressing.nvim",
    init = function()
      conf.dressing_init()
    end,
  })

  -- use({
  --   "lukas-reineke/indent-blankline.nvim",
  --   event = { "BufReadPost", "BufNewFile" },
  --   version = "2.20.8",
  --   opts = {
  --     char = "▏",
  --     context_char = "▏",
  --     show_end_of_line = false,
  --     space_char_blankline = " ",
  --     show_current_context = true,
  --     show_current_context_start = true,
  --     filetype_exclude = {
  --       "help",
  --       "startify",
  --       "dashboard",
  --       "packer",
  --       "neogitstatus",
  --       "NvimTree",
  --       "Trouble",
  --       "alpha",
  --       "neo-tree",
  --     },
  --     buftype_exclude = {
  --       "terminal",
  --       "nofile",
  --     },
  --   },
  -- })

  use({ "windwp/windline.nvim" })
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
end
