local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local c, i, s = ls.choice_node, ls.insert_node, ls.snippet

ls.add_snippets(
  "lua", {
  s({ trig = "local", name = "Generate Local Variable" }, fmt([[local {} = {}]], { i(1), i(2) })),
  s(
    { trig = "req", name = "Assign Variable to Module" },
    fmt([[local {} = require("{}")]], {
      f(function(import_name)
        local parts = vim.split(import_name[1][1], ".", true)
        return parts[#parts] or ""
      end, { 1 }),
      i(1),
    })
  ),
  s(
    { trig = "M", name = "Module" },
    fmt([[
      local {} = {{}}

      {}

      return {}
      ]], {
      i(1, "M"), i(2), rep(1)
    })
  ),
  s(
    { trig = "f", name = "Function" },
    fmt([[
      {}function {}({})
        {}
      end
      ]], {
      c(1, { t "local ", t "" }), i(2, "NAME"), i(3), i(4)
    })
  ),
  s(
    { trig = "if", name = "If" },
    fmt([[
    if {} then
      {}
    end
    ]], { i(1, "true"), i(2) })
  ),
  s(
    { trig = "ife", name = "If/Else" },
    fmt([[
    if {} then
      {}
    else
      {}
    end
    ]], {
      i(1, "true"), i(2), i(3),
    })
  ),
  s(
    { trig = "ifee", name = "If/Else If/Else" },
    fmt([[
    if {} then
      {}
    elseif {} then
      {}
    else
      {}
    end
    ]], {
      i(1, "true"), i(2), i(3, "true"), i(4), i(5),
    })
  ),
  s(
    { trig = "ef", name = "Elseif" },
    fmt([[
    elseif {} then
    ]], { i(1, "true") })
  ),
})
