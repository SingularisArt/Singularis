local ls = require("luasnip")

require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/LuaSnips/" })
require("luasnip").config.setup({ store_selection_keys = "<C-l>" })

vim.cmd([[command! LuaSnipEdit :lua require("luasnip.loaders.from_lua").edit_snippet_files()]])

-- Virtual Text
local types = require("luasnip.util.types")

ls.config.set_config {
  -- This tells LuaSnip to remember to keep around the last snippet. You can
  -- jump back into it even if you move outside of the selection.
  history = false,

  -- This one is cool cause if you have dynamic snippets, it updates as you
  -- type!
  updateevents = "TextChanged,TextChangedI",

  -- Enable autosnippets.
  enable_autosnippets = true,

  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { " « ", "Error" } },
      },
    },
  },
}
