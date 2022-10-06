local autoload = require("SingularisArt.autoload")
local SingularisArt = autoload("SingularisArt")

_G.SingularisArt = SingularisArt

SingularisArt.which_key = {
  mappings = {},
  vmappings = {},
}

if #vim.api.nvim_list_uis() == 0 then
  return
end

return SingularisArt
