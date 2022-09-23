-- Defer plugin source right after Vim is loaded
--
-- This reduces time before a fully functional start screen is shown. Use this
-- for plugins that are not directly related to startup process.
--
-- @param plugin String with name of plugin as subdirectory in 'pack'
local packadd_defer = function(plugin, --[[optional]]plugin_name)
  local packadd = SingularisArt.util.packadd

  plugin_name = plugin_name or plugin

  vim.defer_fn(function() packadd(plugin, plugin_name) end, 0)
end

return packadd_defer
