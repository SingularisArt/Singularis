return {
  -- mini.nvim
  {
    "echasnovski/mini.nvim",
    config = function()
      -- require("plugins.mini.statusline")
      require("plugins.mini.ai")
      require("plugins.mini.map")
      require("plugins.mini.comment")

      -- require("mini.indentscope").setup()
      -- require("mini.animate").setup()
      require("mini.pairs").setup()
      require("mini.tabline").setup()
      require("mini.align").setup()
      require("mini.bracketed").setup()
      require("mini.bufremove").setup()
      require("mini.cursorword").setup()
      require("mini.doc").setup()
      -- require("mini.jump").setup()
      -- require("mini.jump2d").setup()
      require("mini.splitjoin").setup()
      require("mini.surround").setup({ search_method = "cover_or_next" })
      require("mini.trailspace").setup()
      require("mini.move").setup({ options = { reindent_linewise = false } })
    end,
    event = "VeryLazy",
  },
}
