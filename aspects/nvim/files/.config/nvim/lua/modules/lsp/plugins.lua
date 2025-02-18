if vim.g.isLATEX or vim.g.isInkscape then
  return function(_use) end
end

local conf = require("modules.lsp.config")
local icons = require("config.global").icons

return function(use)
  ------------------------------
  --  General LSP Management  --
  ------------------------------

  -- lsp config
  use({
    "neovim/nvim-lspconfig",
    config = conf.nvim_lsp,
  })

  -- mason
  use({
    "williamboman/mason.nvim",
    after = "nvim-lspconfig",
    opts = {
      ui = {
        border = "rounded",
        icons = {
          package_installed = "◍",
          package_pending = "◍",
          package_uninstalled = "◍",
        },
      },
      log_level = vim.log.levels.INFO,
      max_concurrent_installers = 4,
    },
  })
  use({
    "williamboman/mason-lspconfig.nvim",
    after = "mason.nvim",
    config = function()
      require("mason-lspconfig").setup({
        AllowKinds = {
          default = {
            "Function",
            "Method",
            "Class",
            "Module",
            "Property",
            "Variable",
            -- "Constant",
            -- "Enum",
            -- "Interface",
            -- "Field",
            -- "Struct",
          },
          go = {
            "Function",
            "Method",
            "Struct", -- For struct definitions
            "Field", -- For struct fields
            "Interface",
            "Constant",
            -- "Variable",
            "Property",
            -- "TypeParameter", -- For type parameters if using generics
          },
          lua = { "Function", "Method", "Table", "Module" },
          python = { "Function", "Class", "Method" },
          -- Filetype specific
          yaml = { "Object", "Array" },
          json = { "Module" },
          toml = { "Object" },
          markdown = { "String" },
        },
        BlockList = {
          default = {},
          -- Filetype-specific
          lua = {
            "^vim%.", -- anonymous functions passed to nvim api
            "%.%.%. :", -- vim.iter functions
            ":gsub", -- lua string.gsub
            "^callback$", -- nvim autocmds
            "^filter$",
            "^map$", -- nvim keymaps
          },
          -- another example:
          -- python = { "^__" }, -- ignore __init__ functions
        },
        display = {
          mode = "text", -- "icon" or "raw"
          padding = 2,
        },
        kindText = {
          Function = "function",
          Method = "method",
          Class = "class",
          Module = "module",
          Constructor = "constructor",
          Interface = "interface",
          Property = "property",
          Field = "field",
          Enum = "enum",
          Constant = "constant",
          Variable = "variable",
        },
        kindIcons = {
          File = "󰈙",
          Module = "󰏗",
          Namespace = "󰌗",
          Package = "󰏖",
          Class = "󰌗",
          Method = "󰆧",
          Property = "󰜢",
          Field = "󰜢",
          Constructor = "󰆧",
          Enum = "󰒻",
          Interface = "󰕘",
          Function = "󰊕",
          Variable = "󰀫",
          Constant = "󰏿",
          String = "󰀬",
          Number = "󰎠",
          Boolean = "󰨙",
          Array = "󰅪",
          Object = "󰅩",
          Key = "󰌋",
          Null = "󰟢",
          EnumMember = "󰒻",
          Struct = "󰌗",
          Event = "󰉁",
          Operator = "󰆕",
          TypeParameter = "󰊄",
        },
        preview = {
          highlight_on_move = true, -- Whether to highlight symbols as you move through them
          -- TODO: still needs implmenting, keep it always now
          highlight_mode = "always", -- "always" | "select" (only highlight when selecting)
        },
        icon = "󱠦", -- 󱠦 -  -  -- 󰚟
        highlight = "NamuPreview",
        highlights = {
          parent = "NamuParent",
          nested = "NamuNested",
          style = "NamuStyle",
        },
        kinds = {
          prefix_kind_colors = true,
          enable_highlights = true,
          highlights = {
            PrefixSymbol = "NamuPrefixSymbol",
            Function = "NamuSymbolFunction",
            Method = "NamuSymbolMethod",
            Class = "NamuSymbolClass",
            Interface = "NamuSymbolInterface",
            Variable = "NamuSymbolVariable",
            Constant = "NamuSymbolConstant",
            Property = "NamuSymbolProperty",
            Field = "NamuSymbolField",
            Enum = "NamuSymbolEnum",
            Module = "NamuSymbolModule",
          },
        },
        window = {
          auto_size = true,
          min_width = 30,
          padding = 4,
          border = "rounded",
          show_footer = true,
          footer_pos = "right",
        },
        debug = false, -- Debug flag for both namu and selecta
        focus_current_symbol = true, -- Add this option to control the feature
        auto_select = false,
        row_position = "top10", -- options: "center"|"top10",
        initially_hidden = false,
        multiselect = {
          enabled = true,
          indicator = "●", -- or "✓"
          keymaps = {
            toggle = "<Tab>",
            untoggle = "<S-Tab>",
            select_all = "<C-a>",
            clear_all = "<C-l>",
          },
          max_items = nil, -- No limit by default
        },
        actions = {
          close_on_yank = false, -- Whether to close picker after yanking
          close_on_delete = true, -- Whether to close picker after deleting
        },
        keymaps = {
          {
            key = "<C-y>",
            handler = function(items_or_item, state)
              local success = M.yank_symbol_text(items_or_item, state)
              -- Only close if yanking was successful and config says to close
              if success and M.config.actions.close_on_yank then
                M.clear_preview_highlight()
                return false -- This should close the picker
              end
            end,
            desc = "Yank symbol text",
          },
          {
            key = "<C-d>",
            handler = function(items_or_item, state)
              local deleted = M.delete_symbol_text(items_or_item, state)
              -- Only close if deletion was successful and config says to close
              if deleted and M.config.actions.close_on_delete then
                M.clear_preview_highlight()
                return false
              end
            end,
            desc = "Delete symbol text",
          },
          {
            key = "<C-v>",
            handler = function(item, state)
              if not state.original_buf then
                vim.notify("No original buffer available", vim.log.levels.ERROR)
                return
              end

              local new_win = selecta.open_in_split(state, item, "vertical")
              if new_win then
                local symbol = item.value
                if symbol and symbol.lnum and symbol.col then
                  -- Set cursor to symbol position
                  pcall(vim.api.nvim_win_set_cursor, new_win, { symbol.lnum, symbol.col - 1 })
                  vim.cmd("normal! zz")
                end
                M.clear_preview_highlight()
                return false
              end
            end,
            desc = "Open in vertical split",
          },
          {
            key = "<C-o>",
            handler = function(items_or_item)
              if type(items_or_item) == "table" and items_or_item[1] then
                M.add_symbol_to_codecompanion(items_or_item, state.original_buf)
              else
                -- Single item case
                M.add_symbol_to_codecompanion({ items_or_item }, state.original_buf)
              end
            end,
            desc = "Add symbol to CodeCompanion",
          },
          {
            key = "<C-t>",
            handler = function(items_or_item)
              if type(items_or_item) == "table" and items_or_item[1] then
                M.add_symbol_to_avante(items_or_item, state.original_buf)
              else
                -- Single item case
                M.add_symbol_to_avante({ items_or_item }, state.original_buf)
              end
            end,
            desc = "Add symbol to Avante",
          },
        },
      })
    end,
  })

  -- formatter
  use({
    "nvimtools/none-ls.nvim",
    after = "nvim-lspconfig",
    config = conf.null_ls,
    dependencies = {
      {
        "jay-babu/mason-null-ls.nvim",
        after = "mason.nvim",
        config = conf.mason_null_ls,
      },
    },
  })

  -- lsp notifier
  use({
    "j-hui/fidget.nvim",
    branch = "legacy",
    opts = {
      sources = {
        ["null-ls"] = { ignore = true },
      },
    },
  })

  -- inlay hints
  use({
    "simrat39/inlay-hints.nvim",
    after = "nvim-lspconfig",
    config = function()
      require("inlay-hints").setup()
    end,
  })

  -- lsp manager
  use({
    "ray-x/navigator.lua",
    after = "nvim-lspconfig",
    config = conf.navigator,
  })

  -- signature help
  use({
    "ray-x/lsp_signature.nvim",
    opts = {
      bind = true,
      noice = true,
      doc_lines = 10,

      max_height = 10,
      max_width = 80,

      wrap = true,
      fix_pos = false,

      floating_window = true,
      floating_window_above_cur_line = true,
      floating_window_off_x = 1,
      floating_window_off_y = 0,

      hint_enable = true,
      hi_parameter = "LspSignatureActiveParameter",

      toggle_key = "<C-s>",
      toggle_key_flip_floatwin_setting = true,

      hint_prefix = icons.misc.Squirrel .. " ",
      hint_scheme = "Comment",

      handler_opts = {
        border = "rounded",
      },
    },
  })

  -- documentation
  use({
    "danymat/neogen",
    opts = {
      enabled = true,
      languages = {
        lua = {
          template = {
            annotation_convention = "ldoc",
          },
        },
        python = {
          template = {
            annotation_convention = "google_docstrings",
          },
        },
        rust = {
          template = {
            annotation_convention = "rustdoc",
          },
        },
        javascript = {
          template = {
            annotation_convention = "jsdoc",
          },
        },
        typescript = {
          template = {
            annotation_convention = "tsdoc",
          },
        },
        typescriptreact = {
          template = {
            annotation_convention = "tsdoc",
          },
        },
      },
    },
    cmd = "Neogen",
  })

  -- symbols outline
  -- use({
  --   "hedyhli/outline.nvim",
  --   opts = {},
  --   cmd = { "Outline", "OutlineOpen" },
  -- })
  use({
    "bassamsdata/namu.nvim",
    config = function()
      require("namu").setup({})
    end
  })

  -------------------------------------
  --  Language Specific LSP Plugins  --
  -------------------------------------

  -- typescript/javascript
  use({
    "dmmulroy/tsc.nvim",
    cmd = { "TSC" },
    config = true,
  })
  use({
    "pmizio/typescript-tools.nvim",
    ft = { "typescript", "typescriptreact" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "neovim/nvim-lspconfig",
    },
  })
  use({
    "vuki656/package-info.nvim",
    event = "BufEnter package.json",
    config = conf.package_json,
  })
  use({
    "vuki656/package-info.nvim",
    event = "BufEnter package.json",
    opts = {
      colors = {
        up_to_date = "#3C4048",
        outdated = "#fc514e",
      },
      icons = {
        enable = true,
        style = {
          up_to_date = icons.ui.CheckSquare,
          outdated = icons.git.Remove,
        },
      },
      autostart = true,
      hide_up_to_date = true,
      hide_unstable_versions = true,
      package_manager = "npm",
    },
  })

  -- javascript react/typescript react
  use({ "ianks/vim-tsx", ft = "typescriptreact" })
  use({ "mxw/vim-jsx", ft = "javascriptreact" })

  -- rust
  use({ "simrat39/rust-tools.nvim", ft = "rust" })
  use({
    "Saecki/crates.nvim",
    config = function()
      require("crates").setup({
        null_ls = {
          enabled = true,
          name = "crates.nvim",
        },
      })
    end,
    ft = "toml",
  })

  -- java
  use({
    "mfussenegger/nvim-jdtls",
    ft = "java",
  })

  -- go
  use({
    "ray-x/go.nvim",
    dependencies = {
      "guihua.lua",
      "nvim-lspconfig",
      "nvim-treesitter",
    },
    config = conf.go,
    ft = { "go", "gomod" },
    build = ":lua require('go.install').update_all_sync()",
  })

  -- dart
  use({
    "akinsho/flutter-tools.nvim",
    config = conf.flutter_tools,
    ft = { "dart" },
  })

  -- cpp/c
  use({
    "p00f/clangd_extensions.nvim",
    config = conf.clangd_extensions,
    ft = { "cpp", "c" },
  })

  -- SQL/Databases
  use({
    "hbarral/vim-dadbod",
    cmd = {
      "DBUIToggle",
      "DBUI",
      "DBUIAddConnection",
      "DBUIFindBuffer",
      "DBUIRenameBuffer",
      "DBUILastQueryInfo",
    },
    dependencies = {
      "kristijanhusak/vim-dadbod-ui",
      "kristijanhusak/vim-dadbod-completion",
    },
  })
end
