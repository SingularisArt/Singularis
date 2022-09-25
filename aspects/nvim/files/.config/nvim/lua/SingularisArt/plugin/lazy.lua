local lazy = function(plugin_info)
  local load = SingularisArt.plugin.load
  local autocmd = SingularisArt.vim.autocmd

  local plugin = ""
  local event = nil
  local pattern = ""
  local group = nil

  if type(plugin_info) == "table" then
    plugin = plugin_info["plugin"] or plugin_info[1]
    event = plugin_info["event"] or nil
    pattern = plugin_info["pattern"] or "*"
    group = plugin_info["group"] or nil
  elseif type(plugin_info) == "string" then
    plugin = plugin_info
  end

  if event ~= nil then
    vim.api.nvim_create_autocmd(event, {
      pattern = pattern,
      group = group,
      callback = function()
        vim.defer_fn(function()
          load(plugin_info)
        end, 0)
      end,
    })

    return
  end

  vim.defer_fn(function()
    load(plugin_info)
  end, 0)
end

return lazy
