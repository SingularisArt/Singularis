local windline = require("windline")
local fn = vim.fn
local api = vim.api
local helper = require("windline.helpers")
local b_components = require("windline.components.basic")
local state = _G.WindLine.state

state.disable_title_update = false

local function set_title(str)
  local branches = {}
  local dir = vim.fn.getcwd()
  local home = vim.env.HOME
  if dir == home then
    return "NVIM"
  end
  local titlestring = ""
  local _, i = dir:find(home .. "/", 1, true)
  if i then
    dir = dir:sub(i + 1)
  end
  local branch
  if dir and not branch then
    branch = branches[dir]
  end
  if branch then
    titlestring = titlestring .. dir
    titlestring = titlestring .. " - " .. branch
    branches[dir] = branch
  end
  titlestring = titlestring .. " " .. str
  vim.opt.titlestring = titlestring
  return titlestring
end

local lsp_comps = require("windline.components.lsp")
local git_comps = require("windline.components.git")
local HSL = require("wlanimation.utils")
local sep = helper.separators
local git_rev_components = require("windline.components.git_rev")
local home = require("config.global").home
local hover_info

local hl_list = {
  NormalBg = { "NormalFg", "NormalBg" },
  White = { "black", "white" },
  Normal = { "NormalFg", "NormalBg" },
  Inactive = { "InactiveFg", "InactiveBg" },
  Active = { "ActiveFg", "ActiveBg" },
}
local basic = {}

local breakpoint_width = 100
local medium_width = 80
local large_width = 100
basic.divider = { b_components.divider, "" }
basic.bg = { " ", "StatusLine" }

local colors_mode = {
  Normal = { "red", "black" },
  Insert = { "green", "black" },
  Visual = { "yellow", "black" },
  Replace = { "blue_light", "black" },
  Command = { "magenta", "black" },
}
local running = 1

local split = function(str, pat)
  local t = {}
  local fpat = "(.-)" .. pat
  local last_end = 1
  local s, e, cap = str:find(fpat, 1)
  while s do
    if s ~= 1 or cap ~= "" then
      table.insert(t, cap)
    end
    last_end = e + 1
    s, e, cap = str:find(fpat, last_end)
  end
  if last_end <= #str then
    cap = str:sub(last_end)
    table.insert(t, cap)
  end
  return t
end

local split_path = function(str)
  return split(str, "[\\/]+")
end

local winwidth = function()
  return vim.api.nvim_call_function("winwidth", { 0 })
end

local lsp_label1, lsp_label2 = "", ""
local treesitter_context = require("modules.lang.treesitter").context
local ts = ""

local current_function = function(width)
  if width < 50 then
    return ""
  end

  width = width
  if width < 80 and #lsp_label1 > 50 then
    if not state.disable_title_update and running % 5 == 1 then
      set_title(lsp_label1)
    end
    return ""
  end
  if width < 140 then
    width = math.max((80 - #lsp_label1 - #lsp_label2) * 0.5, 20)
  end
  if width >= 140 then
    width = math.max(width / 3, 30)
  end
  if width > 200 then
    width = math.max(width / 2, 60)
  end
  if running % 5 == 1 and not state.disable_title_update then
    ts = treesitter_context(400)
  end

  if ts and string.len(ts) < 3 then
    return " "
  end

  ts = string.gsub(ts, "[\n\r]+", " ")
  local path = fn.fnamemodify(fn.expand("%"), ":~:.")
  local title = path
  if ts and #ts > 1 then
    title = title .. " -> " .. ts
  end

  if not state.disable_title_update and running % 5 == 1 then
    set_title(title)
  end
  running = running + 1
  return string.sub(" " .. ts, 1, width)
end

local function split_lines(value)
  return vim.split(value, "\n", true)
end

local on_hover = function()
  local params = vim.lsp.util.make_position_params()
  local clients = vim.lsp.buf_get_clients()
  local hoverProvider = false
  for _, client in ipairs(clients) do
    if client.server_capabilities.hoverProvider == true and client.name ~= "null-ls" then
      hoverProvider = true
    end
  end
  if hoverProvider == false then
    return ""
  end
  vim.lsp.buf_request(0, "textDocument/hover", params, function(_, result, ctx, config)
    config = config or {}
    config.focus_id = ctx.method
    if
      not (result and result.contents and result.contents.value and #result.contents.value > 0)
    then
      hover_info = nil
      return
    end
    local cnt_kind = result.contents.kind
    local val = result.contents.value
    val = split_lines(val)
    if cnt_kind == "markdown" then
      table.remove(val, #val)
      table.remove(val, 1)
    end
    for idx, value in ipairs(val) do
      val[idx] = vim.fn.trim(value)
      if val[idx]:find("^```") then
        val[idx] = val[idx]:gsub("^```", "")
      end
    end
    val = vim.fn.join(val, " ")
    if #val > 1 then
      hover_info = val
    end
  end)
end

local should_show = function()
  local ft = vim.api.nvim_buf_get_option(0, "filetype")
  if vim.tbl_contains({}, ft) or winwidth() < 100 then
    return false
  end
  return true
end

local function getEntryFromEnd(table, entry)
  local count = (table and #table or false)
  if count then
    return table[count - entry]
  end
  return nil
end

local TrimmedDirectory = function(dir)
  local _, index = string.find(dir, home, 1)
  if index ~= nil and index ~= string.len(dir) then
    dir = string.gsub(dir, home, "~")
  end
  local pa = split_path(dir)
  local p1 = getEntryFromEnd(pa, 1)
  if p1 then
    p1, _ = string.gsub(p1, "github%-", "g")
    p1, _ = string.gsub(p1, "bitbucket%-", "b")
  end
  local p2 = getEntryFromEnd(pa, 2)
  if p2 then
    p2, _ = string.gsub(p2, "mtribes%-", "m")
    p2, _ = string.gsub(p2, "bitbucket%-", "b")
  end
  local p3 = getEntryFromEnd(pa, 3)
  if p3 then
    p3, _ = string.gsub(p3, "mtribes%-", "m")
    p3, _ = string.gsub(p3, "bitbucket%-", "b")
  end

  local pc = ""
  if p3 ~= nil then
    pc = string.sub(p3, 0, 4) .. "/" .. string.sub(p2, 0, 4) .. "/" .. string.sub(p1, 0, 5)
  elseif p2 ~= nil then
    pc = string.sub(p2, 0, 5) .. "/" .. string.sub(p1, 0, 6)
  else
    pc = ""
  end
  pc = " " .. pc
  return pc
end

local mode = function()
  local mod = vim.fn.mode()
  if mod == "n" or mod == "no" or mod == "nov" then
    return { " ", state.mode[2] }
  elseif mod == "i" or mod == "ic" or mod == "ix" then
    return { "", state.mode[2] }
  elseif mod == "V" or mod == "v" or mod == "vs" or mod == "Vs" or mod == "cv" then
    return { " ", state.mode[2] }
  elseif mod == "c" or mod == "ce" then
    return { " ", state.mode[2] }
  elseif mod == "r" or mod == "rm" or mod == "r?" then
    return { mod .. "  ", state.mode[2] }
  elseif mod == "s" then
    return { mod .. " ", state.mode[2] }
  elseif mod == "R" or mod == "Rc" or mod == "Rv" or mod == "Rv" then
    return { mod .. " ", state.mode[2] }
  end

  return { mod .. " ", state.mode[2] }
end

basic.vi_mode = {
  name = "vi_mode",
  hl_colors = colors_mode,
  text = function()
    return { mode() }
  end,
}

basic.square_mode = {
  hl_colors = colors_mode,
  text = function()
    return { { "▊", state.mode[2] } }
  end,
}

basic.lsp_diagnos = {
  name = "diagnostic",
  hl_colors = {
    red = { "red", "NormalBg" },
    yellow = { "yellow_b", "NormalBg" },
    blue = { "blue", "NormalBg" },
  },
  width = breakpoint_width,
  text = function()
    if lsp_comps.check_lsp() then
      return {
        { " ", "red" },
        { lsp_comps.lsp_error({ format = " %s", show_zero = true }), "red" },
        { lsp_comps.lsp_warning({ format = "  %s", show_zero = true }), "yellow" },
        { lsp_comps.lsp_hint({ format = "  %s", show_zero = true }), "blue" },
      }
    end
    return ""
  end,
}

vim.g.tmp_job_state = "loading"
local loading = require("wlanimation.components.loading").create_loading()
basic.job_spinner = {
  name = "job_spinner",
  hl_colors = {
    yellow = { "yellow", "black_light" },
    red = { "red", "black_light" },
  },
  text = function()
    return loading(vim.g.tmp_job_state == "loading")
  end,
}

local function get_offset()
  return "󰃕:" .. fn.line2byte(fn.line(".")) + fn.col(".") - 1
end

local function scrollbar_instance(scrollbar_chars)
  local current_line = vim.fn.line(".")
  local total_lines = vim.fn.line("$")
  local default_chars = {
    "__",
    "▁▁",
    "▂▂",
    "▃▃",
    "▄▄",
    "▅▅",
    "▆▆",
    "▇▇",
    "██",
  }
  local chars = scrollbar_chars or default_chars
  local index = 1

  if current_line == 1 then
    index = 1
  elseif current_line == total_lines then
    index = #chars
  else
    local line_no_fraction = vim.fn.floor(current_line) / vim.fn.floor(total_lines)
    index = vim.fn.float2nr(line_no_fraction * #chars)
    if index == 0 then
      index = 1
    end
  end
  return chars[index]
end

basic.file = {
  name = "file",
  hl_colors = {
    default = hl_list.NormalBg,
    white = { "white", "NormalBg" },
    magenta = { "magenta", "NormalBg" },
  },
  text = function(_, _, width, _)
    if width < breakpoint_width then
      return {
        { b_components.cache_file_size(), "default" },
        { " ", "" },
        { b_components.cache_file_icon({ default = "" }), "default" },
        { " ", "" },
        { b_components.cache_file_name("[No Name]", ""), "magenta" },
        { b_components.file_modified(" "), "magenta" },
      }
    else
      return {
        { b_components.cache_file_size(), "default" },
        { " ", "" },
        { b_components.cache_file_name("[No Name]", ""), "magenta" },
        { " ", "" },
        { b_components.file_modified(" "), "magenta" },
      }
    end
  end,
}

basic.folder = {
  name = "folder",
  hl_colors = {
    default = hl_list.NormalBg,
    white = { "white", "black" },
    blue = { "blue", "NormalBg" },
  },
  text = function(_)
    if should_show() then
      return {
        { " ", "default" },
        {
          TrimmedDirectory(vim.api.nvim_call_function("getcwd", {}) .. "/" .. vim.fn.expand("%p")),
          "blue",
        },
        { " ", "default" },
      }
    end
  end,
}

basic.file_right = {
  hl_colors = {
    default = hl_list.NormalBg,
    white = { "NormalFg", "NormalBg" },
    magenta = { "magenta", "NormalBg" },
  },
  text = function(_, _, width, _)
    if width < breakpoint_width then
      return {
        { b_components.line_col_lua, "white" },
        { b_components.progress_lua, "" },
        { " ", "" },
      }
    else
      return { { b_components.line_col_lua, "white" } }
    end
  end,
}

basic.offset = {
  hl_colors = {
    default = hl_list.NormalBg,
    white = { "white", "NormalBg" },
  },
  text = function(_, _, width, _)
    if width > breakpoint_width then
      return {
        { get_offset(), "white" },
      }
    end
  end,
}

basic.scrollbar_right = {
  hl_colors = {
    default = hl_list.NormalBg,
    white = { "NormalFg", "NormalBg" },
    blue = { "blue", "NormalBg" },
  },
  text = function(_, _, width, is_float)
    if width > breakpoint_width or is_float then
      return {
        { b_components.progress_lua, "" },
        { " ", "" },
        { scrollbar_instance(), "blue" },
      }
    end
  end,
}

basic.git = {
  name = "git",
  hl_colors = {
    green = { "green", "NormalBg" },
    red = { "red", "NormalBg" },
    blue = { "blue", "NormalBg" },
  },
  width = breakpoint_width / 2,
  text = function()
    if git_comps.is_git() then
      return {
        { " ", "" },
        { git_comps.diff_added({ format = " %s", show_zero = true }), "green" },
        { git_comps.diff_removed({ format = "  %s", show_zero = true }), "red" },
        { git_comps.diff_changed({ format = "  %s", show_zero = true }), "blue" },
      }
    end
    return ""
  end,
}

basic.git_branch = {
  name = "git_branch",
  hl_colors = hl_list.NormalBg,
  width = medium_width,
  text = function(bufnr)
    if git_comps.is_git(bufnr) then
      return {
        { git_comps.git_branch(), hl_list.NormalBg, large_width },
        {
          git_rev_components.git_rev(),
          hl_list.default,
          large_width,
        },
        { " ", "" },
      }
    end
    return ""
  end,
}

local quickfix = {
  filetypes = { "qf", "Trouble" },
  active = {
    { "🚦 Quickfix ", { "white", "black" } },
    { helper.separators.slant_right, { "black", "black_light" } },
    {
      function()
        return vim.fn.getqflist({ title = 0 }).title
      end,
      { "cyan", "black_light" },
    },
    { " Total : %L ", { "cyan", "black_light" } },
    { helper.separators.slant_right, { "black_light", "InactiveBg" } },
    { " ", { "InactiveFg", "InactiveBg" } },
    basic.divider,
    { helper.separators.slant_right, { "InactiveBg", "black" } },
    { "🧛 ", { "white", "black" } },
  },

  always_active = true,
}

local explorer = {
  filetypes = { "fern", "NvimTree", "neo-tree", "lir" },
  active = {
    { "  ", { "white", "NormalBg" } },
    { helper.separators.slant_right, { "black", "NormalBg" } },
    { b_components.divider, "" },
    { b_components.file_name(""), { "white", "NormalBg" } },
  },
  always_active = true,
  show_last_status = true,
}
local default = {
  filetypes = { "default" },
  active = {
    basic.square_mode,
    basic.vi_mode,
    basic.git_branch,
    basic.file,
    { "%S", { "green", "NormalBg" } },
    basic.lsp_diagnos,
    basic.divider,
    { sep.slant_right, { "green_light", "blue_light" } },
    basic.file_right,
    basic.offset,
    basic.scrollbar_right,
    { lsp_comps.lsp_name(), { "magenta", "NormalBg" }, breakpoint_width },
    basic.git,
    basic.folder,
    basic.job_spinner,
    { " ", hl_list.NormalBg },
    basic.square_mode,
  },
  inactive = {
    { b_components.full_file_name, hl_list.Inactive },
    basic.file_name_inactive,
    basic.divider,
    basic.divider,
    { b_components.line_col_lua, hl_list.Inactive },
    { b_components.progress_lua, hl_list.Inactive },
  },
}

windline.setup({
  colors_name = function(colors)
    local mod = function(c, value)
      return HSL.rgb_to_hsl(c):shade(value):to_rgb()
    end

    local normalFg, normalBg = require("windline.themes").get_hl_color("StatusLine")

    colors.NormalFg = normalFg or colors.white
    colors.NormalBg = normalBg or mod(colors.white, 0.9)
    colors.FilenameFg = colors.white_light
    colors.FilenameBg = colors.NormalFg

    colors.gray = "#fefefe"
    colors.magenta_a = colors.magenta
    colors.magenta_b = mod(colors.magenta, 0.2)
    colors.magenta_c = mod(colors.magenta, 0.1)

    colors.yellow_a = colors.yellow
    colors.yellow_b = mod(colors.yellow, 0.2)
    colors.yellow_c = mod(colors.yellow, 0.1)

    colors.blue_a = colors.blue
    colors.blue_b = mod(colors.blue, 0.2)
    colors.blue_c = mod(colors.blue, 0.1)

    colors.green_a = mod(colors.green, 0.3)
    colors.green_b = mod(colors.green, 0.2)
    colors.green_c = mod(colors.green, 0.1)

    colors.red_a = colors.red
    colors.red_b = mod(colors.red, 0.2)
    colors.red_c = mod(colors.red, 0.1)
    return colors
  end,
  statuslines = { default, quickfix, explorer },
})

vim.api.nvim_command(
  "autocmd CursorHoldI,CursorHold <buffer> lua require('modules.ui.eviline').on_hover()"
)

local group = api.nvim_create_augroup("windline", {})
api.nvim_create_autocmd({ "BufEnter", "WinEnter", "FocusGained" }, {
  group = group,
  callback = function()
    state.disable_title_update = false
  end,
})

api.nvim_create_autocmd({ "VimLeave", "WinLeave" }, {
  group = group,
  callback = function(_)
    state.disable_title_update = true
  end,
})

return {
  on_hover = on_hover,
}
