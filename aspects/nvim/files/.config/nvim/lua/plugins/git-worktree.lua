local function git_worktree(arg)
  if arg == "create" then
    require("telescope").extensions.git_worktree.create_git_worktree()
  else
    require("telescope").extensions.git_worktree.git_worktrees()
  end
end

require("git-worktree").setup({})
vim.api.nvim_create_user_command("Worktree", "lua require'modules.tools.config'.worktree()(<f-args>)", {
  nargs = "*",
  complete = function()
    return { "create" }
  end,
})

local Worktree = require("git-worktree")
Worktree.on_tree_change(function(op, metadata)
  if op == Worktree.Operations.Switch then
    print("Switched from " .. metadata.prev_path .. " to " .. metadata.path)
  end

  if op == Worktree.Operations.Create then
    print("Create worktree " .. metadata.path)
  end

  if op == Worktree.Operations.Delete then
    print("Delete worktree " .. metadata.path)
  end
end)
return { git_worktree = git_worktree }
