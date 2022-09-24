-- Source plugin and its configuration immediately
-- @param plugin String with name of plugin as subdirectory in 'pack'
local load = function(plugin, --[[optional]] plugin_name)
  plugin_name = plugin_name or plugin

  if vim.v.vim_did_enter == 1 then
    -- Modifies 'runtimepath' _and_ sources files.
    vim.cmd('packadd ' .. plugin)
  else
    -- Just modifies 'runtimepath'; Vim will source the files later as part of
    -- |load-plugins| process.
    vim.cmd('packadd! ' .. plugin)
  end

  if type(plugin_name) == "string" then
    -- Try execute its configuration
    -- NOTE: configuration file should have the same name as plugin directory
    pcall(require, "SingularisArt.config." .. plugin_name)
  elseif type(plugin_name) == "function" then
    plugin_name()
  end
end

return load
