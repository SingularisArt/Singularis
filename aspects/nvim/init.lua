require("SingularisArt")

SingularisArt.plugins.load()

if #vim.api.nvim_list_uis() == 0 then
  return
end

SingularisArt.lsp.load()

SingularisArt.statusline.load()
SingularisArt.settings.load()

SingularisArt.autocmds.load()
SingularisArt.augroup.load()

SingularisArt.color_scheme = "base16-bright"
SingularisArt.colorscheme.load()

SingularisArt.mappings.load()
