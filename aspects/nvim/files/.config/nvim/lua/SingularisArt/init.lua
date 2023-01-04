local function loadcore()
  -- vim.api.nvim_create_augroup("vimrc", {})

  -- Stop loading built in plugins
  -- vim.g.loaded_netrwPlugin = 1
  -- vim.g.loaded_netrwPlugin = 1
  -- vim.g.loaded_tutor_mode_plugin = 1
  -- vim.g.loaded_2html_plugin = 1
  -- vim.g.loaded_tarPlugin = 1
  -- vim.g.logipat = 1

  require("SingularisArt.plugins")

  require("SingularisArt.settings")
  require("SingularisArt.mappings")
  -- require("SingularisArt.lazy")
end

loadcore()
