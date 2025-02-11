if vim.g.isInkscape then
  return function(_use) end
end

local conf = require("modules.git.config")

return function(use)
  use({ "rhysd/git-messenger.vim", cmd = "GitMessenger" })

  use({
    "sindrets/diffview.nvim",
    cmd = {
      "DiffviewOpen",
      "DiffviewFileHistory",
    },
  })

  use({ "NeogitOrg/neogit", cmd = "Neogit" })

  use({
    "lewis6991/gitsigns.nvim",
    config = conf.gitsigns,
  })
end
