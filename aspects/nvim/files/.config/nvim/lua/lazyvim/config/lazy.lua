local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
  "folke/lazy.nvim",

  require("lazyvim.plugins.util"),
  require("lazyvim.plugins.coding"),
  require("lazyvim.plugins.treesitter"),
  require("lazyvim.plugins.colorscheme"),
  require("lazyvim.plugins.debugging"),
  require("lazyvim.plugins.editor"),
  require("lazyvim.plugins.filetypes"),
  require("lazyvim.plugins.git"),
  require("lazyvim.plugins.ui"),
  require("lazyvim.plugins.lsp"),
}, {
  ------------------------------------------------------------------------------
  -- when I use `spec`, instead of manually loading all the plugins like above,
  -- for some reason, my entire neovim config becomes painfully slow, even tho
  -- the loading time is under 50 milliseconds with about 100 plugins. so much
  -- so, if I have a youtube video open and I open up neovim, the youtube video
  -- freezes for a couple of seconds. So, I've got no clue what lazy.nvim is
  -- doing, so I'll just stick with manually loading them, since that loads the
  -- 100+ plugins in under 45 milliseconds, according to startuptime-vim.
  ------------------------------------------------------------------------------
  -- spec = { "lazyvim.plugins" },
  defaults = { lazy = true },
  install = {},
  checker = { enabled = false },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "zip",
        "zipPlugin",
        "tar",
        "tarPlugin",
        "getscript",
        "getscriptPlugin",
        "vimball",
        "vimballPlugin",
        "2html_plugin",
        "matchit",
        "matchparen",
        "logiPat",
        "rrhelper",
        "netrw",
        "netrwPlugin",
        "netrwSettings",
        "tutor_mode_plugin",
        "getscript",
        "getscriptPlugin",
        "2html_plugin",
        "tohtml",
        "tutor",
      },
    },
  },
})

local function load(name)
  local Util = require("lazy.core.util")
  -- always load lazyvim, then user file
  for _, mod in ipairs({ "lazyvim.config." .. name, "config." .. name }) do
    Util.try(function()
      require(mod)
    end, {
      msg = "Failed loading " .. mod,
      on_error = function(msg)
        local modpath = require("lazy.core.cache").find(mod)
        if modpath then
          Util.error(msg)
        end
      end,
    })
  end
end

load("options")
load("autocmds")
load("keymaps")
