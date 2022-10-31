SingularisArt.autocmds = SingularisArt.autoload("SingularisArt.autocmds")

local augroup = SingularisArt.vim.augroup
local autocmd = SingularisArt.vim.autocmd

SingularisArt.autocmds.load = function()
  augroup("SingularisArtAutocmds", function()
    autocmd("BufWritePost", "*/spell/*.add", "silent! :mkspell! %")
    autocmd("InsertLeave", "*", "set nopaste")
    autocmd("VimResized", "*", "execute 'normal! \\<c-w>='")
    -- autocmd("BufReadPost", "*", "normal `0")

    autocmd(
      "TextYankPost",
      "*",
      "silent! lua vim.highlight.on_yank {higroup='Substitute', on_visual=false, timeout=200}"
    )
  end)
end

return SingularisArt.autocmds
