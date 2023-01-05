local M = {}

M.bootstrap_lazy = function()
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "--single-branch",
      "https://github.com/folke/lazy.nvim.git",
      lazypath,
    })
  end
  vim.opt.runtimepath:prepend(lazypath)
end

M.lazy_load = function(plugins)
  require("lazy").load({
    plugins = plugins,
  })
end

M.config = function(name)
  local status, package = pcall(require, "SingularisArt.plugins." .. name)
  if status then
    return package
  else
    return nil
  end
end

M.lazy_notify = function(msg, level)
  vim.notify(msg, level, { title = "Lazy" })
end

M.load_plugin = function(plugins)
  require("lazy").load({
    plugins = plugins,
  })
end

M.load_colorscheme = function()
  local colorschemes = {
    -- "base16-nvim",
    "horizon.nvim",
    "onedarker.nvim",
    "darkplus.nvim",
    -- "vim-colorschemes",
    "synthwave84.nvim",
    -- "zephyr-nvim",
    -- "aurora",
    "tokyonight.nvim",
    "github-nvim-theme",
    "sonokai",
    "gruvbox-material",
    -- "catppuccin",
    "starry.nvim",
    "everforest",
    -- "edge",
    "nightfox.nvim",
  }

  math.randomseed(os.time())
  local colorscheme = colorschemes[math.random(1, #colorschemes)]

  M.load_plugin(colorscheme)
end

return M
