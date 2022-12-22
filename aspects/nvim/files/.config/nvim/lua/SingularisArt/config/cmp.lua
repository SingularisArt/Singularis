local cmp = require("cmp")

if cmp == nil then
  return
end

local icons = require("SingularisArt.icons")
local kind_icons = icons.kind
local source_names = {
  nvim_lsp = "(LSP)",
  nvim_lua = "(Lua)",
  tabnine = "(Tabnine)",
  ultisnips = "(Snippet)",
  calc = "(Calc)",
  path = "(Path)",
  buffer = "(Buffer)",
  emoji = "(Emoji)",
  latex_symbols = "(LaTeX)",
  crates = "(Crates)",
  omni = "(Vimtex)",
}

local duplicates = {
  buffer = 1,
  path = 1,
  nvim_lsp = 0,
  luasnip = 1,
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
  sources = {
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
    { name = "tabnine" },
    { name = "ultisnips" },
    { name = "calc" },
    { name = "path" },
    { name = "buffer" },
    { name = "emoji" },
    { name = "latex_symbols" },
    { name = "crates" },
    { name = "omni" },
  },
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
    entries = true,
  },
  experimental = {
    ghost_text = true,
  },
})
