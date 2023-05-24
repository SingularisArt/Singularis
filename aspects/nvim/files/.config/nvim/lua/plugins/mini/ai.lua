local ai = require("mini.ai")
ai.setup({
  custom_textobjects = {
    F = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
  },
})
