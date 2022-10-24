local neogen = require("neogen")

neogen.setup({
  enabled = true,
  languages = {
    python = {
      template = {
        annotation_convention = "numpydoc",
      },
    },
  },
})
