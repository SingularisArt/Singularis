return {
  -- auto completion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-emoji",
      "kdheepak/cmp-latex-symbols",
      "octaltree/cmp-look",
      "f3fora/cmp-spell",
      "hrsh7th/cmp-calc",
    },
    config = function()
      local cmp = require("cmp")

      local icons = require("lazyvim.config.icons")
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
        { name = "vim-dadbod-completion" },
        { name = "neorg" },
        { name = "spell" },
        { name = "look" },
        { name = "latex_symbols",
          option = {
            strategy = 2,
          },
        },
        { name = "nvim_lua" },
        { name = "crates" },
        { name = "omni" },
      }

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
    ft = "tex",
    event = "InsertEnter",
  },

  -- auto pairs
  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    config = function()
      require("mini.pairs").setup({})
    end,
  },

  -- comments
  { "JoosepAlviste/nvim-ts-context-commentstring" },
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
    keys = {
      "g",
      "<ESC>",
      "v",
      "V",
      "<c-v>",
      "<Leader>/",
    },
    lazy = true,
  },

  -- better text-objects
  {
    "echasnovski/mini.ai",
    keys = {
      { "a", mode = { "x", "o" } },
      { "i", mode = { "x", "o" } },
    },
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        init = function()
          require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
        end,
      },
    },
    config = function()
      local ai = require("mini.ai")
      ai.setup({
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }, {}),
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
        },
      })
    end,
  },
}
