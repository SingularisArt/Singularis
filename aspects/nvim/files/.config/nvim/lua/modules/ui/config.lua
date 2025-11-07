local config = {}

function config.dressing_init()
  vim.ui.select = function(...)
    require("lazy").load({ plugins = { "dressing.nvim" } })
    return vim.ui.select(...)
  end
  vim.ui.input = function(...)
    require("lazy").load({ plugins = { "dressing.nvim" } })
    return vim.ui.input(...)
  end
end

function config.neoscroll()
  require("neoscroll").setup({
    mappings = { "<C-u>", "<C-d>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
    hide_cursor = true,
    stop_eof = true,
    use_local_scrolloff = false,
    respect_scrolloff = true,
    cursor_scrolls_alone = false,
  })
end

function config.ufo_init()
  local set_foldcolumn_for_file = vim.api.nvim_create_augroup("set_foldcolumn_for_file", {
    clear = true,
  })
  vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    group = set_foldcolumn_for_file,
    callback = function()
      if vim.bo.buftype == "" then
        vim.wo.foldcolumn = "1"
      else
        vim.wo.foldcolumn = "0"
      end
    end,
  })
  vim.api.nvim_create_autocmd("OptionSet", {
    group = set_foldcolumn_for_file,
    pattern = "buftype",
    callback = function()
      if vim.bo.buftype == "" then
        vim.wo.foldcolumn = "1"
      else
        vim.wo.foldcolumn = "0"
      end
    end,
  })
  vim.o.foldlevel = 99
  vim.o.foldlevelstart = 99
  vim.o.foldenable = true
end

function config.ufo()
  local ufo = require("ufo")
  ufo.setup(opts)

  vim.api.nvim_create_autocmd("LspAttach", {
    desc = "Setup Ufo `K` with LSP hover",
    callback = function(args)
      local bufnr = args.buf

      vim.keymap.set("n", "K", function()
        local winid = ufo.peekFoldedLinesUnderCursor()
        if not winid then
          vim.lsp.buf.hover()
        end
      end, { buffer = bufnr, desc = "LSP: Signature help" })
    end,
  })
end

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
      local status, inlayhints = pcall(require, "lsp-inlayhints")
      if status then
        inlayhints.toggle()
      end

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
      local status, inlayhints = pcall(require, "lsp-inlayhints")
      if status then
        inlayhints.toggle()
      end

      vim.g.cmp_active = true
      vim.cmd("LspStart")
    end,
  })
end

function config.goyo_init()
  vim.cmd([[
    function! s:goyo_enter()
      setlocal relativenumber number
      setlocal nofoldenable
      setlocal go-=r
    endfunction
    function! s:goyo_leave()
      setlocal go+=r
    endfunction

    autocmd! User GoyoEnter nested call <SID>goyo_enter()
    autocmd! User GoyoLeave nested call <SID>goyo_leave()
  ]])
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

  vim.api.nvim_set_keymap(
    "n",
    "n",
    [[<CMD>execute("normal! " . v:count1 . "n")<CR><CMD>lua require("hlslens").start()<CR>]],
    kopts
  )
  vim.api.nvim_set_keymap(
    "n",
    "N",
    [[<CMD>execute("normal! " . v:count1 . "N")<CR><CMD>lua require("hlslens").start()<CR>]],
    kopts
  )

  vim.api.nvim_set_keymap("n", "*", '*<CMD>lua require("hlslens").start()<CR>', kopts)
  vim.api.nvim_set_keymap("n", "#", '#<CMD>lua require("hlslens").start()<CR>', kopts)
  vim.api.nvim_set_keymap("n", "g*", 'g*<CMD>lua require("hlslens").start()<CR>', kopts)
  vim.api.nvim_set_keymap("n", "g#", 'g#<CMD>lua require("hlslens").start()<CR>', kopts)
end

return config
