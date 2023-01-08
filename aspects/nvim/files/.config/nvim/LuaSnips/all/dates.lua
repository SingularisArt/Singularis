local ls = require("luasnip")
-- local fmt = require("luasnip.extras.fmt").fmt
-- local rep = require("luasnip.extras").rep

local c, f, i, s = ls.choice_node, ls.function_node, ls.insert_node, ls.snippet

ls.add_snippets(
  "all", {
  s(
    "date",
    f(function()
      return os.date("%b %d %Y %a (%H:%M:%S)")
    end)
  ),
  s(
    "dtime",
    f(function()
      return os.date("%D - %H:%M")
    end)
  ),
})
