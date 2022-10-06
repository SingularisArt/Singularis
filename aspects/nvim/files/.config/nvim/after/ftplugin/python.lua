SingularisArt.which_key.mappings["L"] = {
  name = "Language",
  j = {
    name = "Jupyter",
    i = { "<Cmd>MagmaInit<CR>", "Init Magma" },
    d = { "<Cmd>MagmaDeinit<CR>", "Deinit Magma" },
    e = { "<Cmd>MagmaEvaluateLine<CR>", "Evaluate Line" },
    r = { "<Cmd>MagmaReevaluateCell<CR>", "Re evaluate cell" },
    D = { "<Cmd>MagmaDelete<CR>", "Delete cell" },
    s = { "<Cmd>MagmaShowOutput<CR>", "Show Output" },
    R = { "<Cmd>MagmaRestart!<CR>", "Restart Magma" },
    S = { "<Cmd>MagmaSave<CR>", "Save" },
  },
  e = {
    name = "Virtual Environments",
    i = { "<cmd>lua require('swenv.api').pick_venv()<cr>", "Pick Env" },
    d = { "<cmd>lua require('swenv.api').get_current_venv()<cr>", "Show Env" },
  },
}

SingularisArt.which_key.vmappings["L"] = {
  name = "Language",
  j = {
    name = "Jupyter",
    e = { "<esc><cmd>MagmaEvaluateVisual<cr>", "Evaluate Highlighted Line" },
  },
}
