SingularisArt.which_key.mappings["L"] = {
  name = "Language",
  p = { "<cmd>MarkdownPreview<CR>", "View Markdown" },
  t = {
    name = "Table",
    t = { "<cmd>TableModeToggle<CR>", "Enable/Disable Table Mode" },
    n = { "<Leader>ti", "Get cell info" },
    f = {
      name = "Formula",
      a = { "<cmd>TableAddFormula<CR>", "Add formula" },
      e = { "<Leader>tfe", "Evaluate formula on current row" },
    },
    d = {
      name = "Delete",
      r = { "<Leader>tdr", "Delete row" },
      c = { "<Leader>tdc", "Delete column" },
    },
    i = {
      name = "Insert",
      c = { "<Leader>tic", "Insert column" },
    },
  },
}
