require("nvim-treesitter.configs").setup({
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
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
  context_commentstring = { enable = true, enable_autocmd = false },
  incremental_selection = {
    enable = enable,
    keymaps = {
      init_selection = "gnn",
      scope_incremental = "gnn",
      node_incremental = "<TAB>",
      node_decremental = "<S-TAB>",
    },
  },
  textobjects = {
    lsp_interop = {
      enable = enable,
      peek_definition_code = { ["DF"] = "@function.outer", ["CF"] = "@class.outer" },
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = { ["]m"] = "@function.outer", ["]]"] = "@class.outer" },
      goto_next_end = { ["]M"] = "@function.outer", ["]["] = "@class.outer" },
      goto_previous_start = { ["[m"] = "@function.outer", ["[["] = "@class.outer" },
      goto_previous_end = { ["[M"] = "@function.outer", ["[]"] = "@class.outer" },
    },
    select = {
      enable = enable,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
    swap = {
      enable = enable,
      swap_next = { ["<leader>a"] = "@parameter.inner" },
      swap_previous = { ["<leader>A"] = "@parameter.inner" },
    },
  },
  ensure_installed = {},
  refactor = {
    highlight_definitions = { enable = enable },
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
  autotag = { enable = true },
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
  rainbow = {
    enable = true,
    extended_mode = true
  },
})
