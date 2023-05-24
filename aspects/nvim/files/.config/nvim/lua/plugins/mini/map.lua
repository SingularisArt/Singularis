local map = require("mini.map")
local gen_integr = map.gen_integration
local encode_symbols = map.gen_encode_symbols.block("3x2")
-- Use dots in `st` terminal because it can render them as blocks
if vim.startswith(vim.fn.getenv("TERM"), "st") then encode_symbols = map.gen_encode_symbols.dot("4x2") end
map.setup({
  symbols = { encode = encode_symbols },
  integrations = { gen_integr.builtin_search(), gen_integr.gitsigns(), gen_integr.diagnostic() },
})
for _, key in ipairs({ "n", "N", "*" }) do
  vim.keymap.set("n", key, key .. "zv<Cmd>lua MiniMap.refresh({}, { lines = false, scrollbar = false })<CR>")
end
