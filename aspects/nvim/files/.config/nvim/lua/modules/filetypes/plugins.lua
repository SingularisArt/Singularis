return function(use)
  use({
    "mzlogin/vim-markdown-toc",
    cmd = {
      "GenTocGFM",
      "GenTocRedcarpet",
      "GenTocGitLab",
      "GenTocMarked",
    },
    ft = "markdown",
  })
  use({
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
  })
  use({
    "antonk52/markdowny.nvim",
    config = function()
      require("markdowny").setup()
    end,
    ft = "markdown",
  })
  use({ "dhruvasagar/vim-table-mode", ft = "markdown" })
  use({
    "ellisonleao/glow.nvim",
    cmd = "Glow",
    config = true,
    ft = "markdown",
  })

  use({
    "lervag/vimtex",
    config = function()
      vim.g.vimtex_view_method = "zathura"
      vim.g.latex_view_general_viewer = "zathura"
      vim.g.vimtex_compiler_progname = "nvr"
      vim.g.vimtex_quickfix_enabled = 0
    end,
    ft = "tex",
  })
  use({ "KeitaNakamura/tex-conceal.vim", ft = "tex" })

  use({
    "mtdl9/vim-log-highlighting",
    ft = {
      "text",
      "txt",
      "log",
    },
  })

  -- python
  use({
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
  })

  -- javascript/typescript
  use({
    "mattn/emmet-vim",
    ft = {
      "html",
      "javascriptreact",
      "typescriptreact",
    },
  })
  use({
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
  })
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
  })

  -- javascript react/typescript react
  use({ "ianks/vim-tsx", ft = "typescriptreact" })
  use({ "mxw/vim-jsx", ft = "javascriptreact" })

  -- html
  use({ "turbio/bracey.vim", ft = "html" })
  use({
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
  })

  -- r
  use({ "jalvesaq/Nvim-R", ft = { "r", "rmd" } })
  use({ "jalvesaq/R-Vim-runtime", ft = { "r", "rmd" } })
  use({ "jalvesaq/colorout", ft = { "r", "rmd" } })

  -- sql
  use({
    "hbarral/vim-dadbod",
    config = function()
      local function db_completion()
        require("cmp").setup.buffer({ sources = { { name = "vim-dadbod-completion" } } })
      end

      vim.g.db_ui_save_location = vim.fn.stdpath("config") .. require("plenary.path").path.sep .. "db_ui"

      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "sql",
        },
        command = [[setlocal omnifunc=vim_dadbod_completion#omni]],
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "sql",
          "mysql",
          "plsql",
        },
        callback = function()
          vim.schedule(db_completion)
        end,
      })
    end,
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
