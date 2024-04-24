if vim.g.isInkscape then
  return function(_use) end
end

return function(use)
  use({
    "jackMort/ChatGPT.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("chatgpt").setup({
        api_key_cmd = "pass show api/tokens/chatgpt.nvim"
      })
    end,
    cmd = {
      "ChatGPT",
      "ChatGPTActAs",
      "ChatGPTCompleteCode",
      "ChatGPTEditWithInstructions",
      "ChatGPTRun",
    },
  })

  -- For CMP
  -- use({
  --   "zbirenbaum/copilot.lua",
  --   config = function()
  --     require("copilot").setup({
  --       suggestion = { enabled = false },
  --       panel = { enabled = false },
  --     })
  --   end,
  --   event = "InsertEnter",
  -- })

  -- use({
  --   "github/copilot.vim",
  --   config = function()
  --     vim.g.copilot_no_tab_map = true
  --     vim.api.nvim_set_keymap("i", "<C-h>", "copilot#Accept('<CR>')", { silent = true, expr = true })

  --     vim.g.copilot_filetypes = {
  --       ["*"] = true,
  --     }
  --   end,
  --   event = "InsertEnter",
  -- })
end
