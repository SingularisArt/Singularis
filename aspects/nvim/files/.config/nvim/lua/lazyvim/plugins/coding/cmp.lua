local cmp = require("cmp")
local ls = require("luasnip")
local neogen_ok, neogen = pcall(require, "neogen")

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
  luasnip = "(Snippets)",
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
  { name = "luasnip" },
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

cmp.setup({
  snippet = {
    expand = function(args)
      ls.lsp_expand(args.body)
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
        if ls.expand_or_jumpable() then
          ls.expand_or_jump()
        elseif neogen_ok and neogen.jumpable() then
          neogen.jump_next()
        else
          fallback()
        end
      end,
      s = function(fallback)
        if ls.expand_or_jumpable() then
          ls.expand_or_jump()
        else
          fallback()
        end
      end,
    }),
    ["<C-k>"] = cmp.mapping({
      i = function(fallback)
        if ls.jumpable(-1) then
          ls.jump(-1)
        elseif neogen_ok and neogen.jumpable(true) then
          neogen.jump_prev()
        else
          fallback()
        end
      end,
      s = function(fallback)
        if ls.jumpable(-1) then
          ls.jump(-1)
        else
          fallback()
        end
      end,
    }),
    ["<C-l>"] = cmp.mapping({
      i = function()
        if ls.choice_active() then
          ls.change_choice(1)
        end
      end
    }),
    ["<C-h>"] = cmp.mapping({
      i = function()
        if ls.choice_active() then
          ls.change_choice(-1)
        end
      end
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
