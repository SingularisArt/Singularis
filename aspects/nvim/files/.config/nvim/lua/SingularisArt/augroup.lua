local augroups = {}

local augroup = SingularisArt.vim.augroup
local autocmd = SingularisArt.vim.autocmd

augroups.load = function()
  augroup("Statusline", function()
    autocmd(
      "BufWinEnter,BufWritePost,FileWritePost,TextChanged,TextChangedI,WinEnter",
      "*",
      SingularisArt.statusline.check_modified
    )
    autocmd("ColorScheme", "*", SingularisArt.statusline.update_highlight)
  end)
end

return augroups
