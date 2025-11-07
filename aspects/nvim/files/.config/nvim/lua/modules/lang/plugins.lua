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
      keys = {
        { "<Leader>Lh", "<CMD>call OpenSync()<CR>", desc = "Search Headers" },
        { "<Leader>Lm", "<CMD>VimtexContextMenu<CR>", desc = "Open Context Menu" },
        { "<Leader>Lu", "<CMD>VimtexCountLetters<CR>", desc = "Count Letters" },
        { "<Leader>Lw", "<CMD>VimtexCountWords<CR>", desc = "Count Words" },
        { "<Leader>Ld", "<CMD>VimtexDocPackage<CR>", desc = "Open Doc for package" },
        { "<Leader>Le", "<CMD>VimtexErrors<CR>", desc = "Look at the errors" },
        { "<Leader>Ls", "<CMD>VimtexStatus<CR>", desc = "Look at the status" },
        { "<Leader>La", "<CMD>VimtexToggleMain<CR>", desc = "Toggle Main" },
        { "<Leader>Lv", "<CMD>VimtexView<CR>", desc = "View pdf" },
        { "<Leader>Li", "<CMD>VimtexInfo<CR>", desc = "Vimtex Info" },
        { "<Leader>Lt", "<CMD>VimtexTocToggle<CR>", desc = "Toggle TOC" },
        { "<Leader>Lll", "<CMD>VimtexClean<CR>", desc = "Clean Project" },
        { "<Leader>Llc", "<CMD>VimtexClean<CR>", desc = "Clean Cache" },
        { "<Leader>Lcc", "<CMD>VimtexCompile<CR>", desc = "Compile Project" },
        { "<Leader>Lco", "<CMD>VimtexCompileOutput<CR>", desc = "Compile Project and Show Output", },
        { "<Leader>Lcs", "<CMD>VimtexCompileSS<CR>", desc = "Compile project super fast" },
        { "<Leader>Lce", "<CMD>VimtexCompileSelected<CR>", desc = "Compile Selected" },
        { "<Leader>Lrr", "<CMD>VimtexReload<CR>", desc = "Reload" },
        { "<Leader>Lrs", "<CMD>VimtexReloadState<CR>", desc = "Reload State" },
        { "<Leader>Lop", "<CMD>VimtexStop<CR>", desc = "Stop" },
        { "<Leader>Loa", "<CMD>VimtexStopAll<CR>", desc = "Stop All" },
      },
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
