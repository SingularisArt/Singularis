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

  -- auto pairs
  {
    "windwp/nvim-autopairs",
    config = function()
      local npairs = require("nvim-autopairs")
      local Rule = require("nvim-autopairs.rule")

      npairs.setup({
        disable_filetype = { "TelescopePrompt", "guihua", "guihua_rust", "clap_input" },
        autopairs = { enable = true },
        ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]], "%s+", ""),
        enable_check_bracket_line = false,
        html_break_line_filetype = { "html", "vue", "typescriptreact", "svelte", "javascriptreact" },
        check_ts = true,
        ts_config = {
          lua = { "string" },
          javascript = { "template_string" },
          java = false,
        },
        fast_wrap = {
          map = "<M-e>",
          chars = { "{", "[", "(", '"', "'", "`" },
          pattern = string.gsub([[ [%'%"%`%+%)%>%]%)%}%,%s] ]], "%s+", ""),
          end_key = "$",
          keys = "qwertyuiopzxcvbnmasdfghjkl",
          check_comma = true,
          hightlight = "Search",
        },
      })

      npairs.add_rules({
        Rule("(", ")"):with_pair(function(opts)
          return opts.prev_char:match(".%)") ~= nil
        end):use_key(")"),
        Rule("{", "}"):with_pair(function(opts)
          return opts.prev_char:match(".%}") ~= nil
        end):use_key("}"),
        Rule("[", "]"):with_pair(function(opts)
          return opts.prev_char:match(".%]") ~= nil
        end):use_key("]"),
      })
    end,
    event = "InsertEnter",
  },

  -- comments
  {
    "numToStr/Comment.nvim",
    config = function()
      local nvim_comment = require("Comment")

      nvim_comment.setup({
        ignore = "^$",
        toggler = {
          line = "<Leader>/",
          block = "gbc",
        },
        pre_hook = function(ctx)
          local line_start = (ctx.srow or ctx.range.srow) - 1
          local line_end = ctx.erow or ctx.range.erow
          require("lsp-inlayhints.core").clear(0, line_start, line_end)

          require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()

          if vim.bo.filetype == "javascript" or vim.bo.filetype == "typescript" then
            local U = require("Comment.utils")

            local type = ctx.ctype == U.ctype.linewise and "__default" or "__multiline"

            local location = nil
            if ctx.ctype == U.ctype.blockwise then
              location = require("ts_context_commentstring.utils").get_cursor_location()
            elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
              location = require("ts_context_commentstring.utils").get_visual_start_location()
            end

            return require("ts_context_commentstring.internal").calculate_commentstring({
              key = type,
              location = location,
            })
          end
        end,
      })
    end,
    keys = { "<Leader>/" },
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
