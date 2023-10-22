return function(use)
  use({
    "ray-x/guihua.lua",
    build = "cd lua/fzy && make"
  })

  use({ "nvim-lua/plenary.nvim" })
  use({ "ray-x/guihua.lua" })
  use({ "wincent/pinnacle" })
end
