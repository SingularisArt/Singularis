if vim.g.isInkscape then
  return function(_use) end
end

if vim.g.isLATEX then
  return function(use)
    use({
      "lervag/vimtex",
      config = function()
        vim.g.vimtex_view_method = "zathura"
        vim.g.vimtex_quickfix_enabled = 0
      end,
      ft = "tex",
    })
  end
end

local conf = require("modules.lang.config")
local ts = require("modules.lang.treesitter")

return function(use)
  -- treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    config = ts.treesitter,
  })

  -- use({
  --   "windwp/nvim-ts-autotag",
  --   after = "nvim-treesitter",
  --   config = function()
  --     require("nvim-ts-autotag").setup()
  --   end,
  --   ft = {
  --     "html",
  --     "javascript",
  --     "typescript",
  --     "javascript.jsx",
  --     "typescript.tsx",
  --   },
  -- })

  -- use({
  --   "nvim-treesitter/nvim-treesitter-refactor",
  --   config = ts.treesitter_ref,
  --   dependencies = {
  --     {
  --       "andymass/vim-matchup",
  --       setup = function()
  --         vim.g.matchup_matchparen_offscreen = { method = "popup" }
  --       end,
  --     },
  --   },
  -- })

  -- use({
  --   "nvim-treesitter/nvim-treesitter-textobjects",
  --   config = ts.treesitter_obj,
  -- })

  -- use({
  --   "RRethy/nvim-treesitter-textsubjects",
  --   config = ts.textsubjects,
  -- })

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

  use({ "JoosepAlviste/nvim-ts-context-commentstring" })

  -- -- logs
  -- use({ "mtdl9/vim-log-highlighting", ft = { "text", "txt", "log" } })

  -- markdown
  use({
    "iamcco/markdown-preview.nvim",
    config = conf.markdown_preview,
    cmd = "MarkdownPreviewToggle",
    ft = "markdown",
  })
  use({ "dhruvasagar/vim-table-mode", ft = "markdown" })
  use({ "mzlogin/vim-markdown-toc", ft = "markdown" })

  -- -- html/javascript react/typescript react
  -- use({
  --   "mattn/emmet-vim",
  --   ft = {
  --     "html",
  --     "javascript.jsx",
  --     "typescript.tsx",
  --   },
  -- })

  -- -- json/yaml
  -- use({ "b0o/SchemaStore.nvim", ft = { "json", "yaml" } })

  -- -- html
  -- use({
  --   "Valloric/MatchTagAlways",
  --   ft = {
  --     "html",
  --     "javascriptreact",
  --     "typescriptreact",
  --   },
  -- })
end
