local tex = {}

-- Math Mode.
tex.math = function()
  return vim.call("vimtex#syntax#in_mathzone") == 1
end

-- Inline Math Mode.
tex.inline_math = function()
  return vim.call("vimtex#syntax#in", { "texMathZoneTI" }) == 1
end

-- Display Math Mode.
tex.display_math = function()
  return vim.call("vimtex#syntax#in", { "texMathZoneX" }) == 0 and math()
end

-- Text Mode.
tex.text = function()
  return vim.call("vimtex#syntax#in_mathzone") == 0
end

-- Comment Mode.
tex.comment = function()
  return vim.call("vimtex#syntax#in_comment") == 1
end

-- Specific Environment.
tex.env = function(name)
  local x, y = vim.call("vimtex#env#is_inside", { name })
  return x ~= 0 and y ~= 0
end

return tex
