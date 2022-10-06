local cmp = require("cmp")
local icons = require("SingularisArt.icons")
local kind_icons = icons.kind

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

if cmp == nil then
  return
end

local success, emails_with_names_and_emails = pcall(function()
  local json_path = vim.fn.expand("~/.config/nvim/misc/personal/emails.json")
  if vim.fn.filereadable(json_path) == 0 then
    error(json_path .. " not readable")
  end
  return vim.fn.json_decode(vim.fn.readfile(json_path))
end)
if not success then
  return
end

local source = {}

source.new = function()
  return setmetatable({}, { __index = source })
end

source.get_trigger_characters = function()
  return { "@" }
end

source.get_keyword_pattern = function()
  -- Add dot to existing keyword characters (\k).
  return [[\%(\k\|\.\)\+]]
end

source.complete = function(_, request, callback)
  local input = string.sub(request.context.cursor_before_line, request.offset - 1)
  local prefix = string.sub(request.context.cursor_before_line, 1, request.offset - 1)

  if vim.startswith(input, "@") and (prefix == "@" or vim.endswith(prefix, " @")) then
    local items = {}

    for handle, name_and_email in pairs(emails_with_names_and_emails) do
      table.insert(items, {
        filterText = handle .. " " .. name_and_email,
        label = name_and_email,
        textEdit = {
          newText = name_and_email,
          range = {
            start = {
              line = request.context.cursor.row - 1,
              character = request.context.cursor.col - 1 - #input,
            },
            ["end"] = {
              line = request.context.cursor.row - 1,
              character = request.context.cursor.col - 1,
            },
          },
        },
      })
    end
    callback({
      items = items,
      isIncomplete = true,
    })
  else
    callback({ isIncomplete = true })
  end
end

cmp.register_source("emails", source.new())

local source_names = {
  nvim_lsp = "(LSP)",
  nvim_lua = "(Lua)",
  ultisnips = "(Snippet)",
  cmp_tabnine = "(Tabnine)",
  calc = "(Calc)",
  path = "(Path)",
  buffer = "(Buffer)",
  emoji = "(Emoji)",
  tmux = "(TMUX)",
  latex_symbols = "(LaTeX)",
  crates = "(Crates)",
  email = "(Email)",
}

local duplicates = {
  buffer = 1,
  path = 1,
  nvim_lsp = 0,
  luasnip = 1,
}

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["UltiSnips#Anon"](args.body)
    end,
  },

  mapping = cmp.mapping.preset.insert({
    ["<CR>"] = cmp.mapping.confirm({ select = false }),
    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
    ["<C-c>"] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),

    ["<C-j>"] = cmp.mapping({
      c = function()
        if cmp.visible() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
          -- else
          --   cmp.complete()
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
      local max_width = 0
      if max_width ~= 0 and #vim_item.abbr > max_width then
        vim_item.abbr = string.sub(vim_item.abbr, 1, max_width - 1) .. "…"
      end
      vim_item.kind = kind_icons[vim_item.kind]
      vim_item.menu = source_names[entry.source.name]
      vim_item.dup = duplicates[entry.source.name] or duplicates_default
      return vim_item
    end,
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
    { name = "ultisnips" },
    { name = "cmp_tabnine" },
    { name = "calc" },
    { name = "path" },
    { name = "buffer" },
    { name = "emoji" },
    { name = "tmux" },
    { name = "latex_symbols" },
    { name = "crates" },
    { name = "email" },
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
  experimental = {
    ghost_text = true,
    native_menu = false,
  },
  sorting = {
    comparators = {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.recently_used,
      -- require("clangd_extensions.cmp_scores"),
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },
})

cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "cmdline", keyword_length = 2 },
  },
})

-- require("SingularisArt.config.cmp.cmp_emails").setup()
