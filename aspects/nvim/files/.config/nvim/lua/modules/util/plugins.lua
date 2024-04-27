if vim.g.isInkscape then
  return function(_use) end
end

return function(use)
  use({
    "ray-x/guihua.lua",
    build = "cd lua/fzy && make",
  })

  use({ "nvim-lua/plenary.nvim" })
  use({ "ray-x/guihua.lua" })
  use({ "wincent/pinnacle" })

  use({
    "Aityz/usage.nvim",
    config = function()
      require("usage").setup({
        mode = "float",
      })
    end,
    event = "VeryLazy",
  })
end
