if vim.g.isInkscape then
  return function(_use) end
end

local snacks = {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    animate = { enabled = false },
    bigfile = { enabled = true },
    dashboard = { enabled = false },
    dim = { enabled = false },
    explorer = { enabled = true },
    gitbrowse = { enabled = true },
    image = { enabled = false },
    indent = { enabled = false },
    input = { enabled = true },
    layout = { enabled = true },
    lazygit = { enabled = true },
    notifier = { enabled = true },
    picker = { enabled = true },
    profiler = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scratch = { enabled = true },
    scroll = { enabled = false },
    statuscolumn = { enabled = false },
    terminal = { enabled = false },
    toggle = { enabled = true },
    win = { enabled = true },
    words = { enabled = true },
    zen = { enabled = true },
  },
  keys = {
    -- Top Pickers & Explorer
    { "<leader>n<space>", function() require("snacks").picker.smart() end, desc = "Smart Find Files" },
    { "<leader>nb", function() require("snacks").picker.buffers() end, desc = "Buffers" },
    { "<leader>n/", function() require("snacks").picker.grep() end, desc = "Grep" },
    { "<leader>n:", function() require("snacks").picker.command_history() end, desc = "Command History" },
    { "<leader>nn", function() require("snacks").picker.notifications() end, desc = "Notification History" },
    { "<leader>e", function() require("snacks").explorer() end, desc = "File Explorer" },

    -- Find
    { "<leader>nc", function() require("snacks").picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
    { "<leader>nf", function() require("snacks").picker.files() end, desc = "Find Files" },
    { "<leader>ng", function() require("snacks").picker.git_files() end, desc = "Find Git Files" },
    { "<leader>np", function() require("snacks").picker.projects() end, desc = "Projects" },
    { "<leader>nr", function() require("snacks").picker.recent() end, desc = "Recent" },

    -- Git
    { "<leader>gb", function() require("snacks").picker.git_branches() end, desc = "Git Branches" },
    { "<leader>gl", function() require("snacks").picker.git_log() end, desc = "Git Log" },
    { "<leader>gL", function() require("snacks").picker.git_log_line() end, desc = "Git Log Line" },
    { "<leader>gs", function() require("snacks").picker.git_status() end, desc = "Git Status" },
    { "<leader>gS", function() require("snacks").picker.git_stash() end, desc = "Git Stash" },
    { "<leader>gd", function() require("snacks").picker.git_diff() end, desc = "Git Diff (Hunks)" },
    { "<leader>gf", function() require("snacks").picker.git_log_file() end, desc = "Git Log File" },

    -- Grep
    { "<leader>sb", function() require("snacks").picker.lines() end, desc = "Buffer Lines" },
    { "<leader>sB", function() require("snacks").picker.grep_buffers() end, desc = "Grep Open Buffers" },
    { "<leader>sg", function() require("snacks").picker.grep() end, desc = "Grep" },
    { "<leader>sw", function() require("snacks").picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },

    -- Search
    { '<leader>s"', function() require("snacks").picker.registers() end, desc = "Registers" },
    { "<leader>sb", function() require("snacks").picker.lines() end, desc = "Buffer Lines" },
    { "<leader>sc", function() require("snacks").picker.command_history() end, desc = "Command History" },
    { "<leader>sd", function() require("snacks").picker.diagnostics() end, desc = "Diagnostics" },
    { "<leader>sD", function() require("snacks").picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
    { "<leader>sh", function() require("snacks").picker.help() end, desc = "Help Pages" },
    { "<leader>sj", function() require("snacks").picker.jumps() end, desc = "Jumps" },
    { "<leader>sq", function() require("snacks").picker.qflist() end, desc = "Quickfix List" },
    { "<leader>su", function() require("snacks").picker.undo() end, desc = "Undo History" },

    -- LSP
    { "gd", function() require("snacks").picker.lsp_definitions() end, desc = "Goto Definition" },
    { "gD", function() require("snacks").picker.lsp_declarations() end, desc = "Goto Declaration" },
    { "gr", function() require("snacks").picker.lsp_references() end, nowait = true, desc = "References" },
    { "gI", function() require("snacks").picker.lsp_implementations() end, desc = "Goto Implementation" },
    { "gy", function() require("snacks").picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
    { "<leader>ss", function() require("snacks").picker.lsp_symbols() end, desc = "LSP Symbols" },
    { "<leader>sS", function() require("snacks").picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },

    -- Other
    { "<leader>.", function() require("snacks").scratch() end, desc = "Toggle Scratch Buffer" },
    { "<leader>S", function() require("snacks").scratch.select() end, desc = "Select Scratch Buffer" },
    { "<leader>n", function() require("snacks").notifier.show_history() end, desc = "Notification History" },
    { "<leader>cR", function() require("snacks").rename.rename_file() end, desc = "Rename File" },
    { "<leader>gg", function() require("snacks").lazygit() end, desc = "Lazygit" },
    { "<leader>un", function() require("snacks").notifier.hide() end, desc = "Dismiss All Notifications" },
    {
      "<leader>N",
      desc = "Neovim News",
      function()
        require("snacks").win({
          file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
          width = 0.6,
          height = 0.6,
          wo = {
            spell = false,
            wrap = false,
            signcolumn = "yes",
            statuscolumn = " ",
            conceallevel = 3,
          },
        })
      end
    },
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        _G.dd = function(...)
          require("snacks").debug.inspect(...)
        end
        _G.bt = function()
          require("snacks").debug.backtrace()
        end
        vim.print = _G.dd

        require("snacks").toggle.option("spell", { name = "Spelling" }):map("<leader>us")
        require("snacks").toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
        require("snacks").toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
        require("snacks").toggle.diagnostics():map("<leader>ud")
        require("snacks").toggle.line_number():map("<leader>ul")
        require("snacks").toggle
          .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
          :map("<leader>uc")
        require("snacks").toggle.treesitter():map("<leader>uT")
        require("snacks").toggle.inlay_hints():map("<leader>uh")
      end,
    })
  end,
}

if vim.g.isLATEX then
  return function(use)
    use({
      "lervag/vimtex",
      config = function()
        vim.g.vimtex_view_method = "zathura"
        vim.g.vimtex_quickfix_enabled = 0
      end,
      ft = "tex",
    })
  end
end

local conf = require("modules.lang.config")
local ts = require("modules.lang.treesitter")

return function(use)
  use(snacks)

  -- treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    config = ts.treesitter,
  })

  use({
    "windwp/nvim-ts-autotag",
    after = "nvim-treesitter",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
    ft = {
      "html",
      "javascript",
      "typescript",
      "javascript.jsx",
      "typescript.tsx",
    },
  })

  use({
    "nvim-treesitter/nvim-treesitter-refactor",
    config = ts.treesitter_ref,
    dependencies = {
      {
        "andymass/vim-matchup",
        setup = function()
          vim.g.matchup_matchparen_offscreen = { method = "popup" }
        end,
      },
    },
  })

  use({
    "nvim-treesitter/nvim-treesitter-textobjects",
    config = ts.treesitter_obj,
  })

  use({
    "RRethy/nvim-treesitter-textsubjects",
    config = ts.textsubjects,
  })

  use({
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup({
        enable = true,
        max_lines = 5,
        trim_scope = "outer",
        mode = "topline",
        patterns = {
          default = {
            "class",
            "function",
            "method",
            "for",
            "while",
            "if",
            "switch",
          },
        },
      })
    end,
  })

  use({ "JoosepAlviste/nvim-ts-context-commentstring" })

  -- logs
  use({ "mtdl9/vim-log-highlighting", ft = { "text", "txt", "log" } })

  -- markdown
  use({
    "iamcco/markdown-preview.nvim",
    config = conf.markdown_preview,
    cmd = "MarkdownPreviewToggle",
    ft = "markdown",
  })
  use({ "dhruvasagar/vim-table-mode", ft = "markdown" })

  -- html/javascript react/typescript react
  use({
    "mattn/emmet-vim",
    ft = {
      "html",
      "javascript.jsx",
      "typescript.tsx",
    },
  })

  -- json/yaml
  use({ "b0o/SchemaStore.nvim", ft = { "json", "yaml" } })

  -- html
  use({
    "Valloric/MatchTagAlways",
    ft = {
      "html",
      "javascriptreact",
      "typescriptreact",
    },
  })
end
