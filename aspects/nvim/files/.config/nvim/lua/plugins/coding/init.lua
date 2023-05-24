return {
  -- snippets
  {
    "SirVer/ultisnips",
    config = function()
      vim.g.UltiSnipsRemoveSelectModeMappings = 0
      vim.g.UltiSnipsEditSplit = "tabdo"
      vim.g.UltiSnipsSnippetDirectories = {
        "~/.config/nvim/UltiSnips", "UltiSnips"
      }
    end,
    event = "InsertEnter",
  },

  -- auto completion
  {
    "hrsh7th/nvim-cmp",
    config = function()
      require("plugins.coding.cmp")
    end,
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
      "roobert/tailwindcss-colorizer-cmp.nvim",
      {
        "jalvesaq/cmp-nvim-r",
        config = function()
          require("cmp_zotcite").setup({
            filetypes = { "pandoc", "markdown", "rmd", "r", "quarto" }
          })
        end,
      },
      {
        "jalvesaq/cmp-zotcite",
        config = function()
          require("cmp_zotcite").setup({
            filetypes = { "pandoc", "markdown", "rmd", "r", "quarto" }
          })
        end,
        dependencies = "jalvesaq/zotcite",
      },
    },
    event = "InsertEnter",
  },

  -- todo comments
  {
    "folke/todo-comments.nvim",
    config = function()
      local todo_comments = require("todo-comments")

      local icons = require("config.global").icons

      local error_red = "#F44747"
      local warning_orange = "#ff8800"
      local hint_blue = "#4FC1FF"
      local perf_purple = "#7C3AED"
      local note_green = "#10B981"

      todo_comments.setup({
        signs = true,
        sign_priority = 8,
        keywords = {
          FIX = {
            icon = icons.ui.Bug,
            color = error_red,
            alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
          },
          TODO = { icon = icons.ui.Check, color = hint_blue, alt = { "TIP" } },
          HACK = { icon = icons.ui.Fire, color = warning_orange },
          WARN = { icon = icons.diagnostics.Warning, color = warning_orange, alt = { "WARNING", "XXX" } },
          PERF = {
            icon = icons.ui.Dashboard,
            color = perf_purple,
            alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE", "TEST" },
          },
          NOTE = { icon = icons.ui.Note, color = note_green, alt = { "INFO" } },
        },
        highlight = {
          before = "",
          keyword = "wide",
          after = "fg",
          pattern = [[.*<(KEYWORDS)\s*:]],
          comments_only = true,
          max_line_len = 400,
          exclude = { "markdown" },
        },
        search = {
          command = "rg",
          args = {
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
          },
          pattern = [[\b(KEYWORDS):]],
        },
      })
    end,
    event = "BufRead",
  },


  {
    "danymat/neogen",
    config = function()
      require("neogen").setup({
        enabled = true,
        languages = {
          python = {
            template = {
              annotation_convention = "google_docstrings",
            },
          },
        },
      })
    end,
    cmd = "Neogen",
  },

  { "wakatime/vim-wakatime", event = "BufEnter" },
}
