return function(use)
  use({
    "nathom/filetype.nvim",
    config = function()
      vim.g.did_load_filetypes = 1
    end,
  })

  use({
    "ray-x/guihua.lua",
    build = "cd lua/fzy && make"
  })

  use({ "nvim-lua/plenary.nvim" })
  use({ "ray-x/guihua.lua" })
  use({ "wincent/pinnacle" })
end
