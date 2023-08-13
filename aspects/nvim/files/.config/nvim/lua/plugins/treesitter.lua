return {
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "lua",
          "luadoc",
          "luap",
          "c",
          "cpp",
          "go",
          "gomod",
          "rust",
          "python",
        },
        ignore_install = { "latex", "markdown" },
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = true,
          use_languagetree = true,
          disable = function(_, buf)
            local max_filesize = 100 * 1024
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
        },
        indent = { enable = true },
        context_commentstring = {
          config = {
            javascript = {
              __default = "// %s",
              jsx_element = "{/* %s */}",
              jsx_fragment = "{/* %s */}",
              jsx_attribute = "// %s",
              comment = "// %s",
            },
            typescript = { __default = "// %s", __multiline = "/* %s */" },
          },
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn",
            scope_incremental = "gnn",
            node_incremental = "<TAB>",
            node_decremental = "<S-TAB>",
          },
        },
        textobjects = {
          lsp_interop = {
            enable = true,
            peek_definition_code = { ["DF"] = "@function.outer",["CF"] = "@class.outer" },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = { ["]m"] = "@function.outer",["]]"] = "@class.outer" },
            goto_next_end = { ["]M"] = "@function.outer",["]["] = "@class.outer" },
            goto_previous_start = { ["[m"] = "@function.outer",["[["] = "@class.outer" },
            goto_previous_end = { ["[M"] = "@function.outer",["[]"] = "@class.outer" },
          },
          select = {
            enable = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
            },
          },
          swap = {
            enable = true,
            swap_next = { ["<leader>a"] = "@parameter.inner" },
            swap_previous = { ["<leader>A"] = "@parameter.inner" },
          },
        },
        refactor = {
          highlight_definitions = { enable = true },
          highlight_current_scope = { enable = false },
          smart_rename = {
            enable = false,
          },
          navigation = {
            enable = false,
          },
        },
        matchup = {
          disable = { "ruby" },
        },
        autopairs = { enable = true },
        textsubjects = {
          enable = true,
          prev_selection = ",",
          keymaps = {
            [">"] = "textsubjects-smart",
            [";"] = "textsubjects-container-outer",
            ["i;"] = "textsubjects-container-inner",
          },
        },
        enable = true,
        max_lines = 2,
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
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "RRethy/nvim-treesitter-textsubjects",
      "nvim-treesitter/nvim-treesitter-refactor",
      "JoosepAlviste/nvim-ts-context-commentstring",
      "nvim-treesitter/nvim-treesitter-context",
    },
  },
}
