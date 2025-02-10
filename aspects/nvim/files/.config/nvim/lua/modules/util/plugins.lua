if vim.g.isInkscape then
  return function(_use) end
end

return function(use)
  use({ "nvim-lua/plenary.nvim" })
  use({ "ray-x/guihua.lua" })
  use({ "wincent/pinnacle" })
end
