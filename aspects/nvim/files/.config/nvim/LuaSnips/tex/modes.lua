local scopes = require("lazyvim.snippets.latex").scopes
local ls = require("luasnip")
local s = ls.s

local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets(
  "tex", {
  s("dm", fmt([[
  \[
    {}
  \]
  ]], { i(1) }), { condition = scopes.text }),
})
