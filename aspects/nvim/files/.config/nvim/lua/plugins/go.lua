require("go").setup({
  fillstruct = "gopls",
  log_path = vim.fn.expand("$HOME") .. "/tmp/gonvim.log",
  lsp_codelens = false, -- use navigator
  dap_debug = true,
  goimport = "gopls",
  dap_debug_vt = "true",

  dap_debug_gui = true,
  test_runner = "go", -- richgo, go test, richgo, dlv, ginkgo
  -- run_in_floaterm = true, -- set to true to run in float window.
  lsp_document_formatting = false,
  luasnip = true,
  -- lsp_on_attach = require("navigator.lspclient.attach").on_attach,
  -- lsp_cfg = true,
  -- test_efm = true, -- errorfomat for quickfix, default mix mode, set to true will be efm only
})

vim.cmd("augroup go")
vim.cmd("autocmd!")
vim.cmd("autocmd FileType go nmap <leader>gb  :GoBuild")
--  Show by default 4 spaces for a tab')
vim.cmd("autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4")
--  :GoBuild and :GoTestCompile')
-- vim.cmd('autocmd FileType go nmap <leader><leader>gb :<C-u>call <SID>build_go_files()<CR>')
--  :GoTest')
vim.cmd("autocmd FileType go nmap <leader>gt  GoTest")
--  :GoRun

vim.cmd("autocmd FileType go nmap <Leader><Leader>l GoLint")
vim.cmd("autocmd FileType go nmap <Leader>gc :lua require('go.comment').gen()")

vim.cmd("au FileType go command! Gtn :TestNearest -v -tags=integration")
vim.cmd("au FileType go command! Gts :TestSuite -v -tags=integration")
vim.cmd("augroup END")
