local theme = {
  "echasnovski/mini.hues",
  config = function()
    require("mini.hues").setup({ background = "#090610", foreground = "#acc2d2", saturation = "high", n_hues = 6 })
  end,
  lazy = false,
}

if vim.g.isInkscape then
  return function(use)
    use(theme)
  end
end

local conf = require("modules.ui.config")

return function(use)
  use(theme)
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
    "stevearc/dressing.nvim",
    init = function()
      conf.dressing_init()
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
