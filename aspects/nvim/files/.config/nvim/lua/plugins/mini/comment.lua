local comment = require("mini.comment")

comment.setup({
  mappings = {
    comment = "<Leader>/",
    comment_line = "<Leader>/",
    -- textobject = "<Leader>/",
  },
  hooks = {
    pre = function()
      require("ts_context_commentstring.internal").update_commentstring({})
    end,
  },
})
