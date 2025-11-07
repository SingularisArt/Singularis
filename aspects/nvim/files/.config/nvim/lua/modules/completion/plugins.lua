local latexPlugins = {
  "SirVer/ultisnips",
  after = "nvim-cmp",
  config = function()
    -- vim.g.UltiSnipsRemoveSelectModeMappings = 0
    vim.g.UltiSnipsExpandTrigger = "<tab>"
    vim.g.UltiSnipsEditSplit = "tabdo"
    vim.g.UltiSnipsSnippetDirectories = {
      "~/.config/nvim/UltiSnips",
      "UltiSnips",
    }
  end,
  event = "InsertEnter",
}

if vim.g.isInkscape then
  return function(use)
    use(latexPlugins)
  end
end

local conf = require("modules.completion.config")

return function(use)
  use({
    "hrsh7th/nvim-cmp",
    config = conf.cmp,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "kdheepak/cmp-latex-symbols",
      "quangnguyen30192/cmp-nvim-ultisnips",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-calc",
      "hrsh7th/cmp-path",
      "f3fora/cmp-spell",
      "octaltree/cmp-look",
    },
    event = "InsertEnter",
  })

  use(latexPlugins)

  -- use({
  --   "windwp/nvim-autopairs",
  --   opts = {
  --     fast_wrap = {},
  --     disable_filetype = { "TelescopePrompt", "vim" },
  --   },
  --   config = conf.autopairs,
  --   event = "InsertEnter",
  -- })
end
