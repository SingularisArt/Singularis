-- Source plugin and its configuration immediately
-- @param plugin String with name of plugin as subdirectory in 'pack'
local packadd = function(plugin, --[[optional]]plugin_name)
  plugin_name = plugin_name or plugin

  -- Add plugin
  vim.cmd(string.format([[packadd %s]], plugin))

  -- Try execute its configuration
  -- NOTE: configuration file should have the same name as plugin directory
  pcall(require, "SingularisArt.config." .. plugin_name)
end

return packadd
