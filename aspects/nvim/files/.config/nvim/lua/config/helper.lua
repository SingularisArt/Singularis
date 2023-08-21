_G = _G or {}
local fn = vim.fn

local global = require("config.global")

local function exists(file)
  local ok, _, code = os.rename(file, file)
  if not ok then
    if code == 13 then
      return true
    end
  end
  return ok
end
local helper = {
  init = function()
    _G.compare_to_clipboard = function()
      local ftype = vim.api.nvim_eval("&filetype")
      vim.cmd(string.format(
        [[
          vsplit
          enew
          normal! P
          setlocal buftype=nowrite
          set filetype=%s
          diffthis
          bprevious
          execute "normal! \<C-w>\<C-w>"
          diffthis
        ]],
        ftype
      ))
    end

    _G.Snake = function(s)
      if s == nil then
        s = vim.fn.expand("<cword>")
      end
      local n = s:gsub("%f[^%l]%u", "_%1")
        :gsub("%f[^%a]%d", "_%1")
        :gsub("%f[^%d]%a", "_%1")
        :gsub("(%u)(%u%l)", "%1_%2")
        :lower()
      vim.fn.setreg("s", n)
      vim.cmd([[exe "norm! ciw\<C-R>s"]])
    end

    _G.Camel = function()
      local s
      if s == nil then
        s = vim.fn.expand("<cword>")
      end
      local n = string.gsub(s, "_%a+", function(word)
        local first = string.sub(word, 2, 2)
        local rest = string.sub(word, 3)
        return string.upper(first) .. rest
      end)
      vim.fn.setreg("s", n)
      vim.cmd([[exe "norm! ciw\<C-R>s"]])
    end

    _G.Format = function(json)
      vim.cmd([[w]])
      vim.cmd([[nohl]])

      if json then
        vim.cmd([[Jsonfmt]])
      end
    end
  end,
  path_sep = package.config:sub(1, 1) == "\\" and "\\" or "/",
  get_config_path = function()
    return fn.stdpath("config")
  end,
  get_data_path = function()
    return global.data_dir
  end,
  isdir = function(path)
    return exists(path .. "/")
  end,
}

_G.use_nulls = function()
  return true
end

_G.use_efm = function()
  return false
end

_G.plugin_folder = function()
  if Plugin_folder then
    return Plugin_folder
  end
  local host = os.getenv("HOST_NAME")
  if host and host:lower():find("SingularisArt") then
    Plugin_folder = [[~/Documents/dev-plugins]]
  else
    Plugin_folder = [[~/Documents/dev-plugins]]
  end
  return Plugin_folder
end

return helper
