local augroup = function(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- setup sql completion
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("last_loc"),
  pattern = "*.sql",
  command = "autocmd FileType sql setlocal omnifunc=vim_dadbod_completion#omni",
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("last_loc"),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "qf",
    "help",
    "man",
    "notify",
    "lspinfo",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "PlenaryTestPopup",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<CMD>close<CR>", { buffer = event.buf, silent = true })
  end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("wrap_spell"),
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = augroup("highlight-yank"),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = augroup("CommitMSG"),
  pattern = { "/tmp/*", "COMMIT_EDITMSG", "MERGE_MSG", "*.tmp", "*.bak" },
  callback = function()
    vim.opt_local.undofile = false
  end,
})

vim.api.nvim_create_autocmd({ "BufWritePost", "FileWritePost" }, {
  group = augroup("Vim"),
  pattern = "*.vim",
  command = [[ if &l:autoread > 0 | source <afile> | echo "source " . bufname("%") | endif]],
})

vim.api.nvim_create_autocmd("BufReadPre", {
  group = augroup("Syntax"),
  command = [[ if getfsize(expand('%')) > 1000000 | ownsyntax off | endif ]],
})
