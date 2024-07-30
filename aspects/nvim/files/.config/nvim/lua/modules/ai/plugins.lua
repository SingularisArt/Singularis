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
        api_key_cmd = "~/.local/bin/get-password api/tokens/chatgpt.nvim",
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

  use({
    "github/copilot.vim",
    config = function()
      vim.g.copilot_no_tab_map = true
      vim.api.nvim_set_keymap("i", "<C-h>", "copilot#Accept('<CR>')", { silent = true, expr = true })

      vim.g.copilot_filetypes = {
        ["*"] = true,
      }
    end,
    event = "InsertEnter",
  })
end
