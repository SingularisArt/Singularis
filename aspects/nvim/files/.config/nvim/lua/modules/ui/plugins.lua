if vim.g.isInkscape then
  return function(use)
    use({
      "echasnovski/mini.hues",
      config = function()
        require("mini.hues").setup({ background = "#090610", foreground = "#acc2d2", saturation = "high", n_hues = 6 })
      end,
      lazy = false,
    })
  end
end

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
    "junegunn/goyo.vim",
    init = conf.goyo_init,
    cmd = "Goyo",
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
    "karb94/neoscroll.nvim",
    config = function()
      conf.neoscroll()
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

  use({
    "kevinhwang91/nvim-ufo",
    event = "VeryLazy",
    dependencies = "kevinhwang91/promise-async",
    init = function()
      conf.ufo_init()
    end,
    config = function(_, opts)
      conf.ufo(opts)
    end,
    opts = {
      close_fold_kinds_for_ft = {
        default = { "imports" },
      },
    },
  })

  use({
    "luukvbaal/statuscol.nvim",
    lazy = false,

    opts = function()
      local builtin = require("statuscol.builtin")

      return {
        bt_ignore = { "nofile", "terminal" },
        ft_ignore = { "NeogitStatus" },
        segments = {
          {
            text = {
              function(args)
                args.fold.close = ""
                args.fold.open = ""
                args.fold.sep = "▕"
                return builtin.foldfunc(args)
              end,
            },
            condition = {
              function()
                return vim.o.foldcolumn ~= "0"
              end,
            },
            click = "v:lua.ScFa",
          },
          {
            sign = {
              name = { ".*" },
              text = { ".*" },
            },
            click = "v:lua.ScSa",
          },
          {
            sign = { namespace = { "gitsigns" }, colwidth = 1, wrap = true },
            click = "v:lua.ScSa",
          },
          {
            text = { builtin.lnumfunc, " " },
            condition = { builtin.not_empty },
            click = "v:lua.ScLa",
          },
        },
      }
    end,
  })

  use({
    "nvim-pack/nvim-spectre",
    config = function()
      require("spectre").setup()
    end,
    dependencies = {
      "grapp-dev/nui-components.nvim",
    },
  })
end
