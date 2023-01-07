return {
  -- measure startuptime
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 10
    end,
  },

  -- libraries used by other plugins
  "nvim-lua/plenary.nvim",
  "ray-x/guihua.lua",
}
