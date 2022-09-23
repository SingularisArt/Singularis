local autoload = require("SingularisArt.autoload")
local SingularisArt = autoload("SingularisArt")

_G.SingularisArt = SingularisArt

if #vim.api.nvim_list_uis() == 0 then
  return
end

-- SingularisArt.plugins.load()

SingularisArt.settings.load()

SingularisArt.packadd.load()
SingularisArt.statusline.load()

SingularisArt.lsp.load()

SingularisArt.autocmds.load()
SingularisArt.augroup.load()

SingularisArt.color_scheme = "base16-bright"
SingularisArt.colorscheme.load()

SingularisArt.mappings.load()

return SingularisArt
