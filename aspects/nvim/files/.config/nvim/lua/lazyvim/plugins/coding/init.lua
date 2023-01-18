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
      require("lazyvim.plugins.coding.cmp")
    end,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "quangnguyen30192/cmp-nvim-ultisnips",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-calc",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-emoji",
      "ray-x/cmp-treesitter",
      "f3fora/cmp-spell",
      "octaltree/cmp-look",
      "kdheepak/cmp-latex-symbols",
      "hrsh7th/cmp-nvim-lsp-document-symbol",
      "hrsh7th/cmp-cmdline",
      "David-Kunz/cmp-npm",
      "max397574/cmp-greek",
      "Dosx001/cmp-commit",
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
      {
        "petertriho/cmp-git",
        config = function()
          local format = require("cmp_git.format")
          local sort = require("cmp_git.sort")

          require("cmp_git").setup({
            -- defaults
            filetypes = { "gitcommit", "octo" },
            remotes = { "upstream", "origin" }, -- in order of most to least prioritized
            enableRemoteUrlRewrites = false, -- enable git url rewrites, see https://git-scm.com/docs/git-config#Documentation/git-config.txt-urlltbasegtinsteadOf
            git = {
              commits = {
                limit = 100,
                sort_by = sort.git.commits,
                format = format.git.commits,
              },
            },
            github = {
              issues = {
                fields = { "title", "number", "body", "updatedAt", "state" },
                filter = "all", -- assigned, created, mentioned, subscribed, all, repos
                limit = 100,
                state = "open", -- open, closed, all
                sort_by = sort.github.issues,
                format = format.github.issues,
              },
              mentions = {
                limit = 100,
                sort_by = sort.github.mentions,
                format = format.github.mentions,
              },
              pull_requests = {
                fields = { "title", "number", "body", "updatedAt", "state" },
                limit = 100,
                state = "open", -- open, closed, merged, all
                sort_by = sort.github.pull_requests,
                format = format.github.pull_requests,
              },
            },
            gitlab = {
              issues = {
                limit = 100,
                state = "opened", -- opened, closed, all
                sort_by = sort.gitlab.issues,
                format = format.gitlab.issues,
              },
              mentions = {
                limit = 100,
                sort_by = sort.gitlab.mentions,
                format = format.gitlab.mentions,
              },
              merge_requests = {
                limit = 100,
                state = "opened", -- opened, closed, locked, merged
                sort_by = sort.gitlab.merge_requests,
                format = format.gitlab.merge_requests,
              },
            },
            trigger_actions = {
              {
                debug_name = "git_commits",
                trigger_character = ":",
                action = function(sources, trigger_char, callback, params, _)
                  return sources.git:get_commits(callback, params, trigger_char)
                end,
              },
              {
                debug_name = "gitlab_issues",
                trigger_character = "#",
                action = function(sources, trigger_char, callback, _, git_info)
                  return sources.gitlab:get_issues(callback, git_info, trigger_char)
                end,
              },
              {
                debug_name = "gitlab_mentions",
                trigger_character = "@",
                action = function(sources, trigger_char, callback, _, git_info)
                  return sources.gitlab:get_mentions(callback, git_info, trigger_char)
                end,
              },
              {
                debug_name = "gitlab_mrs",
                trigger_character = "!",
                action = function(sources, trigger_char, callback, _, git_info)
                  return sources.gitlab:get_merge_requests(callback, git_info, trigger_char)
                end,
              },
              {
                debug_name = "github_issues_and_pr",
                trigger_character = "#",
                action = function(sources, trigger_char, callback, _, git_info)
                  return sources.github:get_issues_and_prs(callback, git_info, trigger_char)
                end,
              },
              {
                debug_name = "github_mentions",
                trigger_character = "@",
                action = function(sources, trigger_char, callback, _, git_info)
                  return sources.github:get_mentions(callback, git_info, trigger_char)
                end,
              },
            },
          }
          )
        end,
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
        Rule(" ", " "):with_pair(function(opts)
          local pair = opts.line:sub(opts.col - 1, opts.col)
          return vim.tbl_contains({ "()", "[]", "{}" }, pair)
        end),
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

  {
    "SingularisArt/nvim-possession",
    config = function()
      require("nvim-possession").setup({
        sessions = {
          sessions_path = os.getenv("HOME") .. "/.config/nvim/misc/sessions/",
        },
        fzf_winopts = {
          width = 0.5,
          preview = {
            vertical = "right:30%"
          }
        }
      })
    end,
    dependencies = {
      "ibhagwan/fzf-lua"
    },
    keys = {
      { "<Leader>Sl", "<CMD>lua require('nvim-possession').list()<CR>" },
      { "<Leader>Sc", "<CMD>lua require('nvim-possession').new()<CR>" },
      { "<Leader>Su", "<CMD>lua require('nvim-possession').update()<CR>" },
    },
  },
}
