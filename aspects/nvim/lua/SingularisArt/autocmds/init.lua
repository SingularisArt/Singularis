SingularisArt.autocmds = SingularisArt.autoload("SingularisArt.autocmds")

local augroup = SingularisArt.vim.augroup
local autocmd = SingularisArt.vim.autocmd

SingularisArt.autocmds.load = function()
  augroup("SingularisArtAutocmds", function()
    autocmd("BufEnter", "*", SingularisArt.autocmds.functions.buf_enter)
    autocmd("BufLeave", "?*", SingularisArt.autocmds.functions.buf_leave)
    autocmd("BufWinEnter", "?*", SingularisArt.autocmds.functions.buf_win_enter)
    autocmd("BufWritePost", "?*", SingularisArt.autocmds.functions.buf_write_post)
    autocmd("FocusGained", "*", SingularisArt.autocmds.functions.focus_gained)
    autocmd("FocusLost", "*", SingularisArt.autocmds.functions.focus_lost)
    autocmd("InsertEnter", "*", SingularisArt.autocmds.functions.insert_enter)
    autocmd("InsertLeave", "*", SingularisArt.autocmds.functions.insert_leave)
    autocmd("WinEnter", "*", SingularisArt.autocmds.functions.win_enter)
    autocmd("WinLeave", "*", SingularisArt.autocmds.functions.win_leave)
    autocmd("VimEnter", "*", SingularisArt.autocmds.functions.vim_enter)

    -- autocmd("BufEnter", "*", "TSBufEnable highlight")
    -- autocmd("BufEnter", "*", "IndentBlanklineToggle")
    -- autocmd("BufLeave", "*", "TSBufDisable highlight")
    -- autocmd("BufLeave", "*", "IndentBlanklineDisable")

    autocmd("BufWritePost", "*/spell/*.add", "silent! :mkspell! %")
    autocmd("InsertLeave", "*", "set nopaste")
    autocmd("VimResized", "*", 'execute "normal! \\<c-w>="')

    autocmd(
      "TextYankPost",
      "*",
      "silent! lua vim.highlight.on_yank {higroup='Substitute', on_visual=false, timeout=200}"
    )

    -- autocmd("BufWritePre", "<buffer>", vim.lsp.buf.format)
  end)
end

return SingularisArt.autocmds
