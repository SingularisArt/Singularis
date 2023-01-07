return {
  -- measure startuptime
  {
    "dstein64/vim-startuptime",
    config = function()
      vim.g.startuptime_tries = 10
    end,
    cmd = "StartupTime",
  },

  -- libraries used by other plugins
  "nvim-lua/plenary.nvim",
  "ray-x/guihua.lua",
}
