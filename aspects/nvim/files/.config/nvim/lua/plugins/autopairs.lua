local npairs = require("nvim-autopairs")
local Rule = require("nvim-autopairs.rule")

npairs.setup({
  disable_filetype = { "TelescopePrompt", "guihua", "guihua_rust", "clap_input" },
  autopairs = { enable = true },
  ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]], "%s+", ""),
  enable_check_bracket_line = false,
  html_break_line_filetype = { "html", "vue", "typescriptreact", "svelte", "javascriptreact" },
  check_ts = true,
  ts_config = {
    lua = { "string" },
    javascript = { "template_string" },
    java = false,
  },
  fast_wrap = {
    map = "<M-e>",
    chars = { "{", "[", "(", '"', "'", "`" },
    pattern = string.gsub([[ [%'%"%`%+%)%>%]%)%}%,%s] ]], "%s+", ""),
    end_key = "$",
    keys = "qwertyuiopzxcvbnmasdfghjkl",
    check_comma = true,
    hightlight = "Search",
  },
})

npairs.add_rules({
  Rule(" ", " "):with_pair(function(opts)
    local pair = opts.line:sub(opts.col - 1, opts.col)
    return vim.tbl_contains({ "()", "[]", "{}" }, pair)
  end),
  Rule("(", ")"):with_pair(function(opts)
    return opts.prev_char:match(".%)") ~= nil
  end):use_key(")"),
  Rule("{", "}"):with_pair(function(opts)
    return opts.prev_char:match(".%}") ~= nil
  end):use_key("}"),
  Rule("[", "]"):with_pair(function(opts)
    return opts.prev_char:match(".%]") ~= nil
  end):use_key("]"),
})
