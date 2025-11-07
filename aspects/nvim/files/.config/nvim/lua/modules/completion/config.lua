local config = {}

function config.cmp()
  local cmp = require("cmp")
  local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")
  local neogen_ok, neogen = pcall(require, "neogen")

  local icons = require("config.global").icons
  local kind_icons = icons.kind
  local duplicates = {
    buffer = 1,
    path = 1,
    nvim_lsp = 0,
  }

  local source_names = {
    copilot = "(Copilot)",
    nvim_lsp = "(LSP)",
    nvim_lua = "(Lua)",
    ultisnips = "(Snippets)",
    calc = "(Calc)",
    path = "(Path)",
    buffer = "(Buffer)",
    ["vim-dadbod-completion"] = "(SQL)",
    spell = "(Spell)",
    latex_symbols = "(LaTeX)",
    crates = "(Crates)",
    omni = "(Mail)",
    cmp_nvim_r = "(R)",
    cmp_zotcite = "(Zotero)",
  }

  local cmp_sources = {
    { name = "copilot" },
    { name = "nvim_lsp" },
    { name = "ultisnips" },
    { name = "calc" },
    { name = "path" },
    { name = "buffer" },
  }

  local function border(hl_name)
    return {
      { "╭", hl_name },
      { "─", hl_name },
      { "╮", hl_name },
      { "│", hl_name },
      { "╯", hl_name },
      { "─", hl_name },
      { "╰", hl_name },
      { "│", hl_name },
    }
  end

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
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-e>"] = cmp.mapping.abort(),
      ["<CR>"] = cmp.mapping.confirm({ select = false }),
      ["<Tab>"] = cmp.mapping(
        function(fallback)
          cmp_ultisnips_mappings.expand_or_jump_forwards(fallback)
        end,
        { "i", "s", }
      ),
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
        vim_item.kind = kind_icons[vim_item.kind]
        vim_item.menu = source_names[entry.source.name]
        vim_item.dup = duplicates[entry.source.name]

        return vim_item
      end,
    },
    sources = cmp_sources,
    completion = {
      completeopt = "menu,menuone,noinsert",
      autocomplete = { require("cmp.types").cmp.TriggerEvent.TextChanged },
      keyword_length = 1,
    },
    experimental = {
      ghost_text = true,
    },
    confirm_opts = {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },
    window = {
      completion = {
        border = border("CmpDocBorder"),
        winhighlight = "Normal:CmpDoc",
      },
      documentation = {
        border = border("CmpDocBorder"),
        winhighlight = "Normal:CmpDoc",
      },
    },
  })

  ------------------------------
  --  FileType Configuration  --
  ------------------------------

  -- if vim.g.isLATEX then
  --   cmp.setup.filetype("tex", {})
  -- end

  cmp.setup.filetype("tex", {
    sources = cmp.config.sources({
      { name = "copilot" },
      { name = "nvim_lsp" },
      { name = "ultisnips" },
      { name = "calc" },
      { name = "path" },
      { name = "buffer" },
      { name = "spell" },
      { name = "latex_symbols", option = { strategy = 2 } },
    }, {}),
  })

  cmp.setup.filetype({ "markdown", "tex" }, {
    sources = cmp.config.sources({
      { name = "spell" },
    }, cmp.get_config().sources),
  })

  cmp.setup.filetype("sql", {
    sources = cmp.config.sources({
      { name = "vim-dadbod-completion" },
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

  cmp.setup.filetype("toml", {
    sources = cmp.config.sources({
      { name = "crates" },
    }, cmp.get_config().sources),
  })

  cmp.setup.filetype("java", {
    completion = {
      keyword_length = 2,
    },
  })
end

function config.autopairs()
  require("nvim-autopairs").setup({})

  local cmp_autopairs = require("nvim-autopairs.completion.cmp")
  local rule = require("nvim-autopairs.rule")
  local cond = require("nvim-autopairs.conds")
  local autopairs = require("nvim-autopairs")

  require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())

  autopairs.add_rules({
    rule("$", "$", {"tex", "latex"}):with_cr(cond.none())
  })

  autopairs.get_rules("`")[1].not_filetypes = {"tex", "latex"}
  autopairs.get_rules("'")[1].not_filetypes = {"tex", "latex", "rust"}
end

return config
