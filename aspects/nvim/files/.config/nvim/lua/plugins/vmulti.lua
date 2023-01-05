vim.g.VM_mouse_mappings = 1
vim.g.VM_silent_exit = 0
vim.g.VM_show_warnings = 1
vim.g.VM_default_mappings = 1

vim.cmd([[
  let g:VM_maps = {}
  let g:VM_maps['Select All'] = '<C-M-n>'
  let g:VM_maps["Add Cursor Down"] = '<M-Down>'
  let g:VM_maps["Add Cursor Up"] = "<M-Up>"
  let g:VM_maps["Mouse Cursor"] = "<M-LeftMouse>"
  let g:VM_maps["Mouse Word"] = "<M-RightMouse>"
  let g:VM_maps["Add Cursor At Pos"] = '<M-i>'
]])
