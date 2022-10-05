local color = {}

color.apply_colorscheme = function()
  local status_ok, _ = pcall(vim.cmd, "colorscheme " .. SingularisArt.color_scheme)
  if not status_ok then
    return
  end
end

color.highlight_lsp = function()
  vim.cmd([[
    hi LspReferenceText gui=bold guibg=#353d46
    hi LspReferenceRead gui=bold guibg=#353d46
    hi LspReferenceWrite gui=bold guibg=#353d46

    hi def link IlluminatedWordText Visual
    hi def link IlluminatedWordRead Visual
    hi def link IlluminatedWordWrite Visual
  ]])
end

color.edit_colors = function()
  local pinnacle = require("wincent.pinnacle")

  vim.cmd("highlight Comment " .. pinnacle.italicize("Comment"):gsub("cterm", "gui"))

  -- Grey, just like we used to get with https://github.com/Yggdroot/indentLine
  vim.cmd("highlight clear Conceal")
  vim.cmd("highlight Conceal ctermfg=239 guifg=Grey30")

  vim.cmd([[
    highlight clear NonText
    highlight link NonText Conceal
    highlight clear CursorLineNr
  ]])
  vim.cmd("highlight CursorLineNr " .. pinnacle.extract_highlight("DiffText"):gsub("cterm", "gui"))
  vim.cmd([[
    highlight clear Pmenu
    highlight link Pmenu Visual

    " See :help 'pb'.
    highlight PmenuSel blend=0

    highlight clear DiffDelete
    highlight link DiffDelete Conceal
    highlight clear VertSplit
    highlight link VertSplit LineNr

    " Resolve clashes with ColorColumn.
    " Instead of linking to Normal (which has a higher priority, link to nothing).
    highlight link vimUserFunc NONE
  ]])

  -- For Git commits, suppress the background of these groups:
  for _, group in ipairs({ "DiffAdded", "DiffFile", "DiffNewFile", "DiffLine", "DiffRemoved" }) do
    local highlight = pinnacle.dump(group)
    highlight["bg"] = nil
    vim.cmd("highlight! clear " .. group)
    vim.cmd("highlight! " .. group .. " " .. pinnacle.highlight(highlight):gsub("cterm", "gui"))
  end

  -- More subtle highlighting during merge conflict resolution.
  vim.cmd([[
    highlight clear DiffAdd
    highlight clear DiffChange
    highlight clear DiffText
  ]])

  vim.cmd("highlight User8 " .. pinnacle.italicize("ModeMsg"):gsub("cterm", "gui"))

  vim.cmd("highlight DiagnosticError " .. pinnacle.decorate("italic,underline", "ModeMsg"):gsub("cterm", "gui"))

  vim.cmd("highlight DiagnosticHint " .. pinnacle.decorate("bold,italic,underline", "Type"):gsub("cterm", "gui"))

  vim.cmd("highlight DiagnosticSignHint " .. pinnacle
    .highlight({
      bg = pinnacle.extract_bg("ColorColumn"),
      fg = pinnacle.extract_fg("Type"),
    })
    :gsub("cterm", "gui"))

  vim.cmd("highlight DiagnosticSignError " .. pinnacle
    .highlight({
      bg = pinnacle.extract_bg("ColorColumn"),
      fg = pinnacle.extract_fg("ErrorMsg"),
    })
    :gsub("cterm", "gui"))

  vim.cmd("highlight DiagnosticSignInformation " .. pinnacle
    .highlight({
      bg = pinnacle.extract_bg("ColorColumn"),
      fg = pinnacle.extract_fg("DiagnosticHint"),
    })
    :gsub("cterm", "gui"))

  vim.cmd("highlight DiagnosticSignWarning " .. pinnacle
    .highlight({
      bg = pinnacle.extract_bg("ColorColumn"),
      fg = pinnacle.extract_fg("DiagnosticHint"),
    })
    :gsub("cterm", "gui"))
end

color.load = function()
  SingularisArt.colorscheme.apply_colorscheme("base16-bright")
  SingularisArt.colorscheme.highlight_lsp()
  SingularisArt.colorscheme.edit_colors()
end

return color
