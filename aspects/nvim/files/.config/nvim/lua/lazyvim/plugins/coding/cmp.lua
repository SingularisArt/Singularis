local cmp = require("cmp")
local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")
local neogen_ok, neogen = pcall(require, "neogen")

local icons = require("lazyvim.config.global").icons
local kind_icons = icons.kind
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
  cmp_nvim_r = "(R)",
  cmp_zotcite = "(Zotero)",
}

local cmp_sources = {
  { name = "nvim_lsp" },
  { name = "ultisnips" },
  { name = "calc" },
  { name = "path" },
  { name = "buffer" },
  { name = "emoji" },
  { name = "nvim_lsp_document_symbol" },
  -- { name = "nvim_lua" },
}

----------------------------
--  Global Configuration  --
----------------------------

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["UltiSnips#Anon"](args.body)
    end,
  },

  mapping = cmp.mapping.preset.insert({
    ["<CR>"] = cmp.mapping({
      i = function(fallback)
        cmp_ultisnips_mappings.compose({ "expand" })(fallback)
      end,
    }),

    ["<C-j>"] = cmp.mapping({
      i = function(fallback)
        cmp_ultisnips_mappings.compose({ "jump_forwards" })(function()
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
        cmp_ultisnips_mappings.compose({ "jump_backwards" })(function()
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
        omni = (vim.inspect(vim_item.menu):gsub("%\"", "")),
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
    entries = { selection_order = "near_cursor" },
  },
  experimental = {
    ghost_text = true,
  },
})

------------------------------
--  FileType Configuration  --
------------------------------

cmp.setup.filetype("tex", { sources = { name = "ultisnips" } })

cmp.setup.filetype("sql", {
  sources = cmp.config.sources({
    { name = "vim-dadbod-completion" },
  }, cmp.get_config().sources),
})

cmp.setup.filetype("norg", {
  sources = cmp.config.sources({
    { name = "neorg" },
  }, cmp.get_config().sources),
})

cmp.setup.filetype("markdown", {
  sources = cmp.config.sources({
    { name = "spell" },
    { name = "look" },
    { name = "greek" },
  }, cmp.get_config().sources),
})

cmp.setup.filetype("lua", {
  sources = cmp.config.sources({
    { name = "nvim_lua" },
  }, cmp.get_config().sources),
})

cmp.setup.filetype("rust", {
  sources = cmp.config.sources({
    { name = "crates" },
  }, cmp.get_config().sources),
})

cmp.setup.filetype("elm", {
  sources = cmp.config.sources({
    { name = "omni" },
  }, cmp.get_config().sources),
})

cmp.setup.filetype("gitcommit", {
  sources = cmp.config.sources({
    { name = "git" },
    { name = "commit" },
  }, cmp.get_config().sources),
})

cmp.setup.filetype("json", {
  sources = cmp.config.sources({
    { name = "npm" },
  }, cmp.get_config().sources),
})

cmp.setup.filetype({ "r", "rmd" }, {
  sources = cmp.config.sources({
    { name = "cmp_zotcite" },
    { name = "cmp_nvim_r" },
  }, cmp.get_config().sources),
})
