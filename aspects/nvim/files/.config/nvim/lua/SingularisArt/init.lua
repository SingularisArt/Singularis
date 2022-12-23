if pcall(require, "impatient") then
  require("impatient")
end

require("SingularisArt.settings").load()
require("SingularisArt.mappings").load()
require("SingularisArt.plugins").load()

require("SingularisArt.lazy")
