return {
  -- markdown
  {
    "mzlogin/vim-markdown-toc",
    cmd = {
      "GenTocGFM",
      "GenTocRedcarpet",
      "GenTocGitLab",
      "GenTocMarked",
    },
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
    cmd = "MarkdownPreviewToggle",
    ft = "markdown",
  },
  {
    "antonk52/markdowny.nvim",
    config = function()
      require("markdowny").setup()
    end,
    ft = "markdown",
  },
  { "dhruvasagar/vim-table-mode", ft = "markdown" },

  -- latex
  {
    "lervag/vimtex",
    config = function()
      vim.g.vimtex_view_method = "zathura"
      vim.g.latex_view_general_viewer = "zathura"
      vim.g.vimtex_compiler_progname = "nvr"
      vim.g.vimtex_quickfix_enabled = 0
    end,
    ft = "tex",
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

  -- rust
  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
  },
  {
    "Saecki/crates.nvim",
    config = function()
      local null_ls = require("null-ls")

      require("crates").setup {
        null_ls = {
          enabled = true,
          name = "crates.nvim",
        },
      }
    end,
    ft = "toml",
  },

  -- java
  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
  },

  -- go
  {
    "ray-x/go.nvim",
    dependencies = {
      "guihua.lua",
      "nvim-lspconfig",
      "nvim-treesitter",
    },
    config = function()
      require("go").setup()
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ":lua require('go.install').update_all_sync()"
  },

  -- python
  {
    "dccsillag/magma-nvim",
    config = function()
      vim.g.magma_image_provider = "kitty"
      vim.g.magma_automatically_open_output = true
      vim.g.magma_wrap_output = false
      vim.g.magma_output_window_borders = false
      vim.g.magma_cell_highlight_group = "CursorLine"
      vim.g.magma_save_path = vim.fn.stdpath("data") .. "/magma"
    end,
    ft = "python",
  },

  -- javascript/typescript
  {
    "mattn/emmet-vim",
    ft = {
      "html",
      "javascriptreact",
      "typescriptreact",
    },
  },
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-treesitter.configs").setup({
        autotag = {
          enable = true,
        },
      })
    end,
    ft = {
      "html",
      "javascriptreact",
      "typescriptreact",
    },
  },
  {
    "dmmulroy/tsc.nvim",
    cmd = { "TSC" },
    config = true,
  },
  {
    "pmizio/typescript-tools.nvim",
    event = { "BufReadPre", "BufNewFile" },
    ft = { "typescript", "typescriptreact" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "neovim/nvim-lspconfig",
    },
  },
  {
    "vuki656/package-info.nvim",
    event = "BufEnter package.json",
    config = function()
      local icons = require("config.global").icons
      require("package-info").setup({
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
      })
    end,
  },
  {
    "dnlhc/glance.nvim",
    config = function()
      local filter = require("util").filter
      local filterReactDTS = require("util").filter_react_dts

      require("glance").setup({
        hooks = {
          before_open = function(results, open, jump, method)
            if #results == 1 then
              jump(results[1])
            elseif method == "definitions" then
              results = filter(results, filterReactDTS)
              open(results)
            else
              open(results)
            end
          end,
        },
      })
    end,
    cmd = { "Glance" },
    -- keys = {
    --   { "gd", "<CMD>Glance definitions<CR>",      desc = "LSP Definition" },
    --   { "gr", "<CMD>Glance references<CR>",       desc = "LSP References" },
    --   { "gm", "<CMD>Glance implementations<CR>",  desc = "LSP Implementations" },
    --   { "gy", "<CMD>Glance type_definitions<CR>", desc = "LSP Type Definitions" },
    -- },
  },

  -- javascript react/typescript react
  { "ianks/vim-tsx", ft = "typescriptreact" },
  { "mxw/vim-jsx", ft = "javascriptreact" },

  -- html
  { "turbio/bracey.vim", ft = "html" },
  {
    "Valloric/MatchTagAlways",
    config = function()
      vim.cmd([[
      let g:mta_filetypes = {
      \ "html" : 1,
      \ "javascriptreact" : 1,
      \ "typescriptreact" : 1,
      \}
      ]])
    end,
    ft = {
      "html",
      "javascriptreact",
      "typescriptreact",
    },
  },

  -- json/yaml
  { "b0o/SchemaStore.nvim", ft = { "json", "yaml" } },

  -- r
  { "jalvesaq/Nvim-R", ft = { "r", "rmd" } },
  { "jalvesaq/R-Vim-runtime", ft = { "r", "rmd" } },
  { "jalvesaq/colorout", ft = { "r", "rmd" } },

 -- dart
  { "dart-lang/dart-vim-plugin", ft = { "dart" } },

  -- C++/C
  { "p00f/clangd_extensions.nvim", ft = { "cpp", "c" } },

  -- sql
  -- {
  --   "hbarral/vim-dadbod",
  --   config = function()
  --     local function db_completion()
  --       require("cmp").setup.buffer({ sources = { { name = "vim-dadbod-completion" } } })
  --     end
  --
  --     vim.g.db_ui_save_location = vim.fn.stdpath("config") .. require("plenary.path").path.sep .. "db_ui"
  --
  --     vim.api.nvim_create_autocmd("FileType", {
  --       pattern = {
  --         "sql",
  --       },
  --       command = [[setlocal omnifunc=vim_dadbod_completion#omni]],
  --     })
  --
  --     vim.api.nvim_create_autocmd("FileType", {
  --       pattern = {
  --         "sql",
  --         "mysql",
  --         "plsql",
  --       },
  --       callback = function()
  --         vim.schedule(db_completion)
  --       end,
  --     })
  --   end,
  --   cmd = {
  --     "DBUIToggle",
  --     "DBUI",
  --     "DBUIAddConnection",
  --     "DBUIFindBuffer",
  --     "DBUIRenameBuffer",
  --     "DBUILastQueryInfo",
  --   },
  --   dependencies = {
  --     "kristijanhusak/vim-dadbod-ui",
  --     "kristijanhusak/vim-dadbod-completion",
  --   },
  -- },
}
