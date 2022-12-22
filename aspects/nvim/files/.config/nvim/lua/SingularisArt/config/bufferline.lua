require("bufferline").setup({
  options = {
    view = "multiwindow",
    numbers = "none", -- function(opts) return string.format('%s·%s', opts.raise(opts.id), opts.lower(opts.ordinal)) end,
    close_command = "bdelete! %d",
    right_mouse_command = "bdelete! %d",
    left_mouse_command = "buffer %d",
    -- mappings = true,
    max_name_length = 14,
    max_prefix_length = 10,
    tab_size = 16,
    truncate_names = false,
    indicator = { style = "underline" },
    diagnostics = "nvim_lsp",
    show_buffer_icons = true,
    show_buffer_close_icons = false,
    show_tab_indicators = true,
    diagnostics_upeate_in_insert = false,
    diagnostics_indicator = function(count, level)
      local icon = level:match("error") and "" or "" -- "" or ""
      return "" .. icon .. count
    end,
    -- can also be a table containing 2 custom separators
    separator_style = "thin",
    enforce_regular_tabs = false,
    always_show_bufferline = false,
    sort_by = "directory",
  },
  highlights = {
    buffer_selected = {
      bold = true,
      italic = true,
    },
  },
})
vim.api.nvim_set_hl(0, "BufferLineBufferSelected", { default = true, fg = "#ffffff", bold = true, underline = true })
vim.api.nvim_set_hl(0, "BufferLineInfoSelected", { default = true, fg = "#ffffff", bold = true, underline = true })
