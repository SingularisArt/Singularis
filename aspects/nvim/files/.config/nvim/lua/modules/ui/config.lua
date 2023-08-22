local config = {}

function config.zen_mode()
  require("zen-mode").setup({
    window = {
      backdrop = 1,
      height = 0.9,

      width = 80,
      options = {
        signcolumn = "no",
        number = false,
        relativenumber = false,
        cursorline = true,
        cursorcolumn = false,
        foldcolumn = "0",
        list = false,
      },
    },
    plugins = {
      gitsigns = { enabled = false },
      tmux = { enabled = false },
      twilight = { enabled = false },
    },
    on_open = function()
      require("lsp-inlayhints").toggle()
      vim.g.cmp_active = false
      vim.cmd("LspStop")
      local status_ok, _ = pcall(vim.api.nvim_set_option_value, "winbar", nil, { scope = "local" })
      if not status_ok then
        return
      end
      if vim.fn.exists("#" .. "_winbar") == 1 then
        vim.cmd("au! " .. "_winbar")
      end
    end,
    on_close = function()
      require("lsp-inlayhints").toggle()
      vim.g.cmp_active = true
      vim.cmd("LspStart")
    end,
  })
end

function config.hlslens()
  require("hlslens").setup()
  vim.cmd([[
        hi default link HlSearchNear IncSearch
        hi default link HlSearchLens WildMenu
        hi default link HlSearchLensNear IncSearch
        hi default link HlSearchFloat IncSearch
        ]])

  local kopts = { noremap = true, silent = true }

  vim.api.nvim_set_keymap("n", "n",
    [[<CMD>execute("normal! " . v:count1 . "n")<CR><CMD>lua require("hlslens").start()<CR>]], kopts)
  vim.api.nvim_set_keymap("n", "N",
    [[<CMD>execute("normal! " . v:count1 . "N")<CR><CMD>lua require("hlslens").start()<CR>]], kopts)

  vim.api.nvim_set_keymap("n", "*", "*<CMD>lua require(\"hlslens\").start()<CR>", kopts)
  vim.api.nvim_set_keymap("n", "#", "#<CMD>lua require(\"hlslens\").start()<CR>", kopts)
  vim.api.nvim_set_keymap("n", "g*", "g*<CMD>lua require(\"hlslens\").start()<CR>", kopts)
  vim.api.nvim_set_keymap("n", "g#", "g#<CMD>lua require(\"hlslens\").start()<CR>", kopts)
end

return config
