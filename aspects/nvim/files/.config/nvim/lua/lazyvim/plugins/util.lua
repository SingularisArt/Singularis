return {
  -- measure startuptime
  {
    "dstein64/vim-startuptime",
    config = function()
      vim.g.startuptime_tries = 10
    end,
    cmd = "StartupTime",
  },

  {
    "nathom/filetype.nvim",
    config = function()
      vim.g.did_load_filetypes = 1
    end,
  },

  -- libraries used by other plugins
  "nvim-lua/plenary.nvim",
  "ray-x/guihua.lua",
}
