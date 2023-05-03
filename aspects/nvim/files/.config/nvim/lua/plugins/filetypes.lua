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
    config = function()
      require("crates").setup()
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
    ft = { "go", "gomod" },
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
      vim.g.magma_save_path = vim.fn.stdpath "data" .. "/magma"
    end,
    ft = "python",
  },

  -- c/c++
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
  { "Valloric/MatchTagAlways",       ft = "html" },
  { "turbio/bracey.vim",             ft = "html" },
  { "mattn/emmet-vim",               ft = "html" },

  -- json/yaml
  { "b0o/SchemaStore.nvim",          ft = { "json", "yaml" } },

  -- r
  { "jalvesaq/Nvim-R",               ft = { "r", "rmd" } },
  { "jalvesaq/R-Vim-runtime",        ft = { "r", "rmd" } },
  { "jalvesaq/colorout",             ft = { "r", "rmd" } },

  -- typescript
  { "ianks/vim-tsx",                 ft = "typescriptreact" },
  { "leafgarland/typescript-vim",    ft = "typescriptreact" },
}
