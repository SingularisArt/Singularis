return {
  -- auto completion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
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
      "Dosx001/cmp-commit",
      "hrsh7th/cmp-cmdline",
      "David-Kunz/cmp-npm",
      "max397574/cmp-greek",
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
    config = function()
      local cmp = require("cmp")

      local icons = require("lazyvim.config.global").icons
      local kind_icons = icons.kind
      local duplicates = {
        buffer = 1,
        path = 1,
        nvim_lsp = 0,
        luasnip = 1,
      }

      local source_names = {
        nvim_lsp = "(LSP)",
        ultisnips = "(Snippets)",
        calc = "(Calc)",
        path = "(Path)",
        buffer = "(Buffer)",
        emoji = "(Emoji)",
        nvim_lsp_document_symbol = "(Symbols)",
        git = "(Git)",
        npm = "(NPM)",
        greek = "(Greek)",
        ["vim-dadbod-completion"] = "(SQL)",
        neorg = "(Neorg)",
        spell = "(Spell)",
        look = "(Look)",
        latex_symbols = "(LaTeX)",
        nvim_lua = "(Lua)",
        crates = "(Crates)",
        omni = "(Mail)",
      }

      local cmp_sources = {
        { name = "nvim_lsp" },
        { name = "ultisnips" },
        { name = "calc" },
        { name = "path" },
        { name = "buffer" },
        { name = "emoji" },
        { name = "nvim_lsp_document_symbol" },
        { name = "git" },
        { name = "npm" },
        { name = "greek" },
      }

      -- if vim.o.ft == "sql" then
      --   table.insert(sources, { name = "vim-dadbod-completion" })
      -- end

      -- if vim.o.ft == "norg" then
      --   table.insert(sources, { name = "neorg" })
      -- end

      -- if vim.o.ft == "markdown" or vim.o.ft == "tex" then
      --   table.insert(sources, { name = "spell" })
      --   table.insert(sources, { name = "look" })
      -- end

      -- if vim.o.ft == "tex" then
      --   table.insert(sources, { name = "latex_symbols",
      --     option = {
      --       strategy = 2,
      --     },
      --   })
      -- end

      -- if vim.o.ft == "lua" then
      --   table.insert(sources, { name = "nvim_lua" })
      -- end

      -- if vim.o.ft == "rust" then
      --   table.insert(sources, { name = "crates" })
      -- end

      -- if vim.o.ft == "elm" then
      --   table.insert(sources, { name = "omni" })
      -- end

      local t = function(str)
        return vim.api.nvim_replace_termcodes(str, true, true, true)
      end

      cmp.setup({
        snippet = {
          expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body)
          end,
        },

        mapping = cmp.mapping.preset.insert({
          ["<CR>"] = cmp.mapping.confirm({ select = false }),

          ["<C-j>"] = cmp.mapping({
            c = function()
              if cmp.visible() then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
              end
            end,
            i = function(fallback)
              if vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
                vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"), "m", true)
              else
                if require("neogen").jumpable() then
                  require("neogen").jump_next()
                else
                  fallback()
                end
              end
            end,
            s = function(fallback)
              if vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
                vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"), "m", true)
              else
                fallback()
              end
            end,
          }),
          ["<C-k>"] = cmp.mapping({
            i = function(fallback)
              if vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
                return vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_backward)"), "m", true)
              else
                if require("neogen").jumpable(true) then
                  require("neogen").jump_prev()
                else
                  fallback()
                end
              end
            end,
            s = function(fallback)
              if vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
                return vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_backward)"), "m", true)
              else
                fallback()
              end
            end,
          }),
        }),

        formatting = {
          fields = { "kind", "abbr", "menu" },

          format = function(entry, vim_item)
            local max_width = 50
            if max_width ~= 0 and #vim_item.abbr > max_width then
              vim_item.abbr = string.sub(vim_item.abbr, 1, max_width - 1) .. icons.ui.Ellipsis
            end

            vim_item.menu = ({
              omni = (vim.inspect(vim_item.menu):gsub('%"', "")),
              buffer = "[Buffer]",
            })[entry.source.name]
            vim_item.kind = kind_icons[vim_item.kind]
            vim_item.menu = source_names[entry.source.name]
            vim_item.dup = duplicates[entry.source.name]
            return vim_item
          end,
        },
        sources = cmp_sources,

        confirm_opts = {
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,
        },
        completion = {
          keyword_length = 1,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        view = {
          entries = { selection_order = "near_cursor" }
        },
        experimental = {
          ghost_text = true,
        },
      })
    end,
  },

  -- snippets
  {
    "SirVer/ultisnips",
    config = function()
      vim.cmd([[
      let g:UltiSnipsExpandTrigger="<Tab>"
      let g:UltiSnipsJumpForwardTrigger="<Plug>(ultisnips_jump_forward)"
      let g:UltiSnipsJumpBackwardTrigger="<Plug>(ultisnips_jump_backward)"
      let g:UltiSnipsListSnippets="<c-x><c-s>"
      let g:UltiSnipsRemoveSelectModeMappings=0
      let g:UltiSnipsEditSplit="tabdo"
      let g:UltiSnipsSnippetDirectories=[$HOME."/.config/nvim/UltiSnips", "UltiSnips"]
    ]] )
    end,
    event = "VeryLazy",
    ft = "tex",
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
    event = "VeryLazy",
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
    lazy = true,
  },
}
