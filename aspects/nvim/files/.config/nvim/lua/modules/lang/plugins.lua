local conf = require("modules.lang.config")
local ts = require("modules.lang.treesitter")

return function(use)
  use({
    "nvim-treesitter/nvim-treesitter",
    config = ts.treesitter,
  })

  use({
    "windwp/nvim-ts-autotag",
    after = "nvim-treesitter",
    ft = {
      "html",
      "javascript",
      "typescript",
      "javascriptreact",
      "typescriptreact",
    },
  })

  use({
    "nvim-treesitter/nvim-treesitter-refactor",
    config = ts.treesitter_ref,
  })

  use({
    "nvim-treesitter/nvim-treesitter-textobjects",
    config = ts.treesitter_obj,
  })

  use({
    "RRethy/nvim-treesitter-textsubjects",
    config = ts.textsubjects,
  })

  use({
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup({
        enable = true,
        max_lines = 5,
        trim_scope = "outer",
        mode = "topline",
        patterns = {
          default = {
            "class",
            "function",
            "method",
            "for",
            "while",
            "if",
            "switch",
          },
        },
      })
    end,
  })

  use({
    "nvim-treesitter/playground",
    cmd = "TSPlaygroundToggle",
    config = conf.playground,
  })

  use({ "JoosepAlviste/nvim-ts-context-commentstring" })

  use({
    "yardnsm/vim-import-cost",
    ft = {
      "javascript",
    },
    cmd = "ImportCost",
  })

  use({
    "mfussenegger/nvim-treehopper",
    config = ts.tshopper,
  })

  use({
    "bennypowers/nvim-regexplainer",
    cmd = { "RegexplainerToggle", "RegexplainerShow" },
    config = conf.regexplainer,
  })

  use({
    "haringsrob/nvim_context_vt",
    event = { "CursorHold", "WinScrolled", "CursorMoved" },
    config = conf.context_vt,
  })

  use({
    "ThePrimeagen/refactoring.nvim",
    config = conf.refactor,
    cmd = "Refactor",
  })

  use({ "mtdl9/vim-log-highlighting", ft = { "text", "txt", "log" } })

  use({
    "gennaro-tedesco/nvim-jqx",
    cmd = { "JqxList", "JqxQuery" },
  })

  use({
    "m-demare/hlargs.nvim",
    config = function()
      require("hlargs").setup({
        disable = function()
          local excluded_filetype = {
            "TelescopePrompt",
            "guihua",
            "guihua_rust",
            "clap_input",
            "lua",
            "rust",
            "typescript",
            "typescriptreact",
            "javascript",
            "javascriptreact",
          }
          if vim.tbl_contains(excluded_filetype, vim.bo.filetype) then
            return true
          end

          local bufnr = vim.api.nvim_get_current_buf()
          local filetype = vim.fn.getbufvar(bufnr, "&filetype")
          if filetype == "" then
            return true
          end
          local parsers = require("nvim-treesitter.parsers")
          local buflang = parsers.ft_to_use(filetype)
          return vim.tbl_contains(excluded_filetype, buflang)
        end,
      })
    end,
  })

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
    config = conf.markdown_preview,
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
    config = conf.vimtex,
    ft = "tex",
  })
  use({
    "anufrievroman/vim-tex-kawaii",
    ft = "tex",
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
    config = conf.dadbod,
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
