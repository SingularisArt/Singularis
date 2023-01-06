return {
  -- markdown
  {
    "mzlogin/vim-markdown-toc",
    ft = "markdown",
  },
  {
    "dhruvasagar/vim-table-mode",
    ft = "markdown",
  },
  {
    "iamcco/markdown-preview.nvim",
    config = function()
      vim.g.mkdp_markdown_css = os.getenv("HOME") .. "/.config/nvim/misc/static/markdown-preview.css"
      vim.g.mkdp_highlight_css = os.getenv("HOME") .. "/.cache/wal/colors.css"
      vim.g.vim_markdown_conceal = 1
      vim.g.vim_markdown_math = 1
      vim.g.vim_markdown_conceal_code_blocks = 0
      vim.g.vim_markdown_strikethrough = 1
    end,
    ft = "markdown",
  },

  -- latex
  {
    "lervag/vimtex",
    config = function()
      vim.g.vimtex_view_method = "zathura"
      vim.g.latex_view_general_viewer = "zathura"
      vim.g.vimtex_compiler_progname = "nvr"
      vim.g.vimtex_quickfix_enabled = 0
    end,
    lazy = false,
  },
  { "KeitaNakamura/tex-conceal.vim", ft = "tex" },

  -- log
  {
    "mtdl9/vim-log-highlighting",
    ft = {
      "text",
      "txt",
      "log",
    },
  },

  -- python
  {
    "dccsillag/magma-nvim",
    config = function()
      vim.g.magma_image_provider = "ueberzug"
      vim.g.magma_automatically_open_output = false
      vim.g.magma_wrap_output = false
      vim.g.magma_output_window_borders = true
      vim.g.magma_cell_highlight_group = "CursorLine"
      vim.g.magma_save_path = vim.fn.stdpath("config") .. "/misc/magma"
    end,
    ft = "python",
  },
  {
    "AckslD/swenv.nvim",
    ft = "python",
  },

  -- rust
  {
    "simrat39/rust-tools.nvim",
    config = function()
      require("rust-tools").setup({
        server = {
          on_attach = function(c, b)
            require("navigator.lspclient.mapping").setup({ client = c, bufnr = b })
          end,
        },
      })
    end,
    ft = "rust",
  },
  {
    "Saecki/crates.nvim",
    ft = "rust",
  },

  -- java
  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
  },

  -- go
  {
    "ray-x/go.nvim",
    ft = "go",
  },

  -- lua
  {
    "folke/neodev.nvim",
    ft = "lua",
  },

  -- sql
  {
    "kkharji/sqlite.lua",
    ft = "sqlite",
  },

  -- C/C++
  {
    "p00f/clangd_extensions.nvim",
    config = function()
      require("clangd_extensions").setup()
    end,
    ft = {
      "c",
      "cpp",
      "objc",
      "objcpp",
      "h",
      "hpp",
    },
  },

  -- html
  {
    "Valloric/MatchTagAlways",
    ft = "html",
  },
  {
    "turbio/bracey.vim",
    ft = "html",
  },
  {
    "mattn/emmet-vim",
    ft = "html",
  },

  -- neorg
  {
    "nvim-neorg/neorg",
    config = function()
      require("neorg").setup({
        load = {
          ["core.defaults"] = {},
          ["core.norg.concealer"] = {},
          ["core.norg.dirman"] = {
            config = { workspaces = { my_workspace = "~/neorg" } },
          },
          ["core.keybinds"] = {
            config = {
              default_keybinds = true,
              neorg_leader = "<Leader>o",
            },
          },
          ["core.norg.completion"] = { config = { engine = "nvim-cmp" } },
          ["core.integrations.telescope"] = {},
        },
      })
      local neorg_callbacks = require("neorg.callbacks")

      neorg_callbacks.on_event("core.keybinds.events.enable_keybinds", function(_, keybinds)
        keybinds.map_event_to_mode("norg", {
          n = {
            { "<C-s>", "core.integrations.telescope.find_linkable" },
          },

          i = {
            { "<C-l>", "core.integrations.telescope.insert_link" },
          },
        }, { silent = true, noremap = true })
      end)
    end,
    dependencies = {
      { "nvim-neorg/neorg-telescope", ft = "norg" }
    },
    ft = "norg",
  },
  {
    "akinsho/org-bullets.nvim",
    config = function()
      require("org-bullets").setup()
    end,
  },
  {
    "lukas-reineke/headlines.nvim",
    ft = {
      "org",
      "norg",
      "markdown",
      "yaml",
    },
    config = function()
      require("headlines").setup({
        markdown = {
          headline_highlights = { "Headline1", "Headline2", "Headline3" },
        },
        org = {
          headline_highlights = false,
        },
        norg = { codeblock_highlight = false },
      })
    end,
  },

  -- json/yaml
  "b0o/SchemaStore.nvim",
}
