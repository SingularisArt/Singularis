local conf = require("modules.completion.config")

return function(use)
  use({
    "hrsh7th/nvim-cmp",
    config = conf.cmp,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "kdheepak/cmp-latex-symbols",
      "quangnguyen30192/cmp-nvim-ultisnips",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-calc",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-emoji",
      "f3fora/cmp-spell",
      "octaltree/cmp-look",
      {
        "roobert/tailwindcss-colorizer-cmp.nvim",
        opts = function(_, opts)
          opts.formatting = {
            format = require("tailwindcss-colorizer-cmp").formatter,
          }
        end,
      },
      -- {
      --   "jalvesaq/cmp-nvim-r",
      --   config = function()
      --     require("cmp_zotcite").setup({
      --       filetypes = { "pandoc", "markdown", "rmd", "r", "quarto" }
      --     })
      --   end,
      -- },
      -- {
      --   "jalvesaq/cmp-zotcite",
      --   config = function()
      --     require("cmp_zotcite").setup({
      --       filetypes = { "pandoc", "markdown", "rmd", "r", "quarto" }
      --     })
      --   end,
      --   dependencies = "jalvesaq/zotcite",
      -- },
    },
    event = "InsertEnter",
  })

  use({
    "SirVer/ultisnips",
    after = "nvim-cmp",
    config = conf.ultisnips(),
    event = "InsertEnter",
  })

  use({
    "windwp/nvim-autopairs",
    opts = {
      fast_wrap = {},
      disable_filetype = { "TelescopePrompt", "vim" },
    },
    config = conf.autopairs,
    event = "InsertEnter",
  })
end
