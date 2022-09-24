local load = function(plugin_info)
  local plugin = ""
  local config = nil

  if type(plugin_info) == "table" then
    plugin = plugin_info["plugin"] or plugin_info[1]
    config = plugin_info["config"] or nil
  elseif type(plugin_info) == "string" then
    plugin = plugin_info
  end

  if vim.v.vim_did_enter == 1 then
    -- Modifies 'runtimepath' _and_ sources files.
    vim.cmd('packadd ' .. plugin)
  else
    -- Just modifies 'runtimepath'; Vim will source the files later as part of
    -- |load-plugins| process.
    vim.cmd('packadd! ' .. plugin)
  end

  if type(config) == "string" then
    -- Try execute its configuration
    -- NOTE: configuration file should have the same name as plugin directory
    pcall(require, "SingularisArt.config." .. config)
  elseif type(config) == "function" then
    config()
  else
    return
  end
end

return load
