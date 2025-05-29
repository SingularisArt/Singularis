if vim.g.isInkscape then
  return function(_use) end
end

local conf = require("modules.git.config")

return function(use)
  use({
    "rhysd/git-messenger.vim",
    cmd = "GitMessenger",
    keys = {
      { "<Leader>gm", function() vim.cmd.GitMessenger() end, desc = "View message (GIT)" },
    },
  })

  use({
    "sindrets/diffview.nvim",
    cmd = {
      "DiffviewOpen",
      "DiffviewFileHistory",
    },
    keys = {
      { "<Leader>gD", "<CMD>DiffviewOpen<CR>", desc = "Git Diff (GIT)" },
      { "<Leader>gc", "<CMD>DiffviewClose<CR>", desc = "Git Diff Close (GIT)" },
      { "<Leader>gh", "<CMD>DiffviewFileHistory<CR>", desc = "Git History (GIT)" },
    },
  })

  use({ "NeogitOrg/neogit", cmd = "Neogit" })

  use({
    "lewis6991/gitsigns.nvim",
    config = conf.gitsigns,
    keys = {
      { "<Leader>gd", "<CMD>Gitsigns diffthis HEAD<CR>", desc = "Git Diff (GIT)" },
      { "<Leader>gj", function() require("gitsigns").next_hunk() end, desc = "Next Hunk (GIT)" },
      { "<Leader>gk", function() require("gitsigns").prev_hunk() end, desc = "Prev Hunk (GIT)" },
      { "<Leader>gl", function() require("gitsigns").blame_line() end, desc = "Blame (GIT)" },
      { "<Leader>gp", function() require("gitsigns").preview_hunk() end, desc = "Preview Hunk (GIT)" },
      { "<Leader>gr", function() require("gitsigns").reset_hunk() end, desc = "Reset Hunk (GIT)" },
      { "<Leader>gR", function() require("gitsigns").reset_buffer() end, desc = "Reset Buffer (GIT)" },
      { "<Leader>gs", function() require("gitsigns").stage_hunk() end, desc = "Stage Hunk (GIT)" },
      { "<Leader>gu", function() require("gitsigns").undo_stage_hunk() end, desc = "Undo Stage Hunk (GIT)" },
    },
  })
end
