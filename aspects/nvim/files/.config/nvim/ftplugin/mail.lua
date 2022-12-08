vim.opt.wrap = true
vim.opt.tw = 0
vim.opt.spell = true
vim.opt.spell = true
vim.opt.omnifunc = "v:lua.SinularisArt.MailComplete()"

local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

keymap("n", "<C-H>", ":call SendMail()<CR>", opts)
keymap("n", "<leader>f", "gg/From:<CR>:nohlsearch<CR>4lC: ", opts)
keymap("n", "<leader>t", "gg/To:<CR>:nohlsearch<CR>2lC: ", opts)
keymap("n", "<leader>c", "gg/Cc:<CR>:nohlsearch<CR>2lC: ", opts)
keymap("n", "<leader>b", "gg/Bcc:<CR>:nohlsearch<CR>3lC: ", opts)
keymap("n", "<leader>s", "gg/Subject:<CR>:nohlsearch<CR>7lC: ", opts)

vim.cmd([[
setl omnifunc=mailcomplete#Complete
autocmd TermOpen * setl nonumber norelativenumber laststatus=0

function! s:new_mail()
  let l:path = system('mktemp --tmpdir XXXXXXXXXX.eml')
  execute 'e' l:path

  startinsert

  0r $HOME/.config/nvim/skeletons/mail.eml | w | $
endfunction

command! Mail call s:new_mail()

function! s:OnExit(job_id, code, event) dict
  if a:code == 0
    execute 'bd!' s:bufnr
    if len(getbufinfo({'buflisted': 1})) == 1
      quit
    endif
  else
    execute 'echo "Failed to send email"'
  endif
endfunction

function! SendMail()
  let l:message_file = expand('%')
  if l:message_file != ''
    update
  else
    let l:message_file = system('mktemp')
    execute 'w!' l:message_file
  endif
  enew
  call termopen('VISUAL=true PINENTRY_USER_DATA=spawn-xterm neomutt ' .
        \ "-e 'set postpone=no sidebar_visible=no assumed_charset=utf-8' " .
        \ "-H " . l:message_file, {'on_exit': function('s:OnExit')})
  let s:bufnr = bufnr('%')
  startinsert
endfunction
]])
