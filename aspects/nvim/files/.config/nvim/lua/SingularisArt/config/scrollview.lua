if vim.wo.diff then
  return
end
local w = vim.api.nvim_call_function("winwidth", { 0 })
if w < 70 then
  return
end

vim.g.scrollview_column = 1
