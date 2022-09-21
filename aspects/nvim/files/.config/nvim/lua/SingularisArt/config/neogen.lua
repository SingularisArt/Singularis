local M = {}

M.setup = function()
  local neogen = require("neogen")

  neogen.setup({
    enabled = true,
    languages = {
      python = {
        template = {
          annotation_convention = "google_docstrings",
        },
      },
    },
  })
end

return M
