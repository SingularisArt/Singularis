local cache_dir = require("config.global").cache_dir

local createdir = function()
  local data_dir = {
    cache_dir .. "backup",
    cache_dir .. "session",
    cache_dir .. "swap",
    cache_dir .. "tags",
    cache_dir .. "undo",
  }

  if vim.fn.isdirectory(cache_dir) == 0 then
    os.execute("mkdir -p " .. cache_dir)
    for _, v in pairs(data_dir) do
      if vim.fn.isdirectory(v) == 0 then
        os.execute("mkdir -p " .. v)
      end
    end
  end
end

local disable_distribution_plugins = function()
  vim.g.loaded_gzip = 1
  vim.g.loaded_tar = 1
  vim.g.loaded_tarPlugin = 1
  vim.g.loaded_zip = 1
  vim.g.loaded_zipPlugin = 1
  vim.g.loaded_getscript = 1
  vim.g.loaded_getscriptPlugin = 1
  vim.g.loaded_vimball = 1
  vim.g.loaded_vimballPlugin = 1
  vim.g.loaded_matchit = 1
  vim.g.loaded_matchparen = 1
  vim.g.loaded_2html_plugin = 1
  vim.g.loaded_logiPat = 1
  vim.g.loaded_rrhelper = 1
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1
  vim.g.loaded_netrwSettings = 1
  vim.g.loaded_netrwFileHandlers = 1
end

local load_core = function()
  require("config.helper").init()

  createdir()
  disable_distribution_plugins()

  -- override default colorscheme
  vim.api.nvim_set_hl(0, "StatusLine", { bg = "None" })
  vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "None" })
  vim.api.nvim_set_hl(0, "Normal", { bg = "None" })
  vim.api.nvim_set_hl(0, "Pmenu", { bg = "None" })
  vim.api.nvim_set_hl(0, "SignColumn", { bg = "None" })
  vim.api.nvim_set_hl(0, "FoldColumn", { bg = "None" })

  require("config.options").general()
  require("config.autocmds")
  require("config.keymaps")
  require("config.lazy_nvim"):boot_strap()

  vim.defer_fn(function()
    require("config.lazy")
  end, 5)
end

load_core()
