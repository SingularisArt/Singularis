local cmp = require("cmp")
local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")
local neogen_ok, neogen = pcall(require, "neogen")

local kind_icons = require("lazyvim.config.global").icons.kind
local duplicates = {
  buffer = 1,
  path = 1,
  nvim_lsp = 0,
}

local source_names = {
  nvim_lsp = "(LSP)",
  nvim_lua = "(Lua)",
  ultisnips = "(Snippets)",
  calc = "(Calc)",
  path = "(Path)",
  buffer = "(Buffer)",
  emoji = "(Emoji)",
  nvim_lsp_document_symbol = "(Symbols)",
  git = "(Git)",
  commit = "(Git)",
  npm = "(NPM)",
  greek = "(Greek)",
  ["vim-dadbod-completion"] = "(SQL)",
  spell = "(Spell)",
  look = "(Look)",
  latex_symbols = "(LaTeX)",
  crates = "(Crates)",
  omni = "(Mail)",
  neorg = "(Norg)",
}

local cmp_sources = {
  { name = "nvim_lsp" },
  { name = "ultisnips" },
  { name = "calc" },
  { name = "path" },
  { name = "buffer" },
  { name = "emoji" },
  { name = "nvim_lsp_document_symbol" },
}

if vim.o.ft == "sql" then
  table.insert(cmp_sources, { name = "vim-dadbod-completion" })
end

if vim.o.ft == "norg" then
  table.insert(cmp_sources, { name = "neorg" })
end

if vim.o.ft == "markdown" or vim.o.ft == "tex" then
  table.insert(cmp_sources, { name = "spell" })
  table.insert(cmp_sources, { name = "look" })
  table.insert(cmp_sources, { name = "greek" })
end

if vim.o.ft == "tex" then
  table.insert(cmp_sources, { name = "latex_symbols",
    option = {
      strategy = 2,
    },
  })
end

if vim.o.ft == "lua" then
  table.insert(cmp_sources, { name = "nvim_lua" })
end

if vim.o.ft == "rust" then
  table.insert(cmp_sources, { name = "crates" })
end

if vim.o.ft == "elm" then
  table.insert(cmp_sources, { name = "omni" })
end

if vim.o.ft == "gitcommit" then
  table.insert(cmp_sources, { name = "git" })
  table.insert(cmp_sources, { name = "commit" })
end

if vim.o.ft == "json" then
  table.insert(cmp_sources, { name = "npm" })
end
print(vim.inspect(cmp_sources))

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["UltiSnips#Anon"](args.body)
    end,
  },

  mapping = cmp.mapping.preset.insert({
    ["<CR>"] = cmp.mapping({
      i = function(fallback)
        cmp_ultisnips_mappings.compose { "expand" } (fallback)
      end,
    }),

    ["<C-j>"] = cmp.mapping({
      i = function(fallback)
        cmp_ultisnips_mappings.compose { "jump_forwards" } (function()
          if neogen_ok and neogen.jumpable() then
            neogen.jump_next()
          else
            fallback()
          end
        end)
      end,
    }),

    ["<C-k>"] = cmp.mapping({
      i = function(fallback)
        cmp_ultisnips_mappings.compose { "jump_backwards" } (function()
          if neogen_ok and neogen.jumpable(true) then
            neogen.jump_prev()
          else
            fallback()
          end
        end)
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
