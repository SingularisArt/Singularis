---Defer plugin source right after Vim is loaded
---
---This reduces time before a fully functional start screen is shown. Use this
---for plugins that are not directly related to startup process.
---
---@param plugin string with name of plugin as subdirectory in 'pack'
---@param plugin_name string name of the config file of plugin
local lazy = function(plugin, --[[optional]] plugin_name)
  local load = SingularisArt.plugin.load

  plugin_name = plugin_name or plugin

  vim.defer_fn(function() load(plugin, plugin_name) end, 0)
end

return lazy
