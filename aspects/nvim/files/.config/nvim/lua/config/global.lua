vim.g.use_nerd_icons = false

local global = {}
local home = os.getenv("HOME")
local path_sep = global.is_windows and "\\" or "/"
local os_name = vim.loop.os_uname().sysname

function global:load_variables()
  self.is_mac = os_name == "Darwin"
  self.is_linux = os_name == "Linux"
  self.is_windows = os_name == "Windows" or os_name == "Windows_NT"

  self.path_sep = global.is_windows and "\\" or "/"
  self.vim_path = vim.fn.stdpath("config")
  if self.is_windows then
    path_sep = "\\"
    home = os.getenv("HOMEDRIVE") or "C:"
    home = home .. (os.getenv("HOMEPATH") or "\\")
    if home == "C:\\" then
      local win_home = vim.fn.expand("$HOME")
      if win_home ~= "$HOME" then
        print("the windows environment variable HOMEDRIVE and HOMEPATH are not set, using $HOME instead")
        home = win_home
      end
    end
    self.home = home
  end

  self.cache_dir = home .. path_sep .. ".cache" .. path_sep .. "nvim" .. path_sep
  self.path_sep = path_sep
  self.home = home
  self.data_dir = vim.fn.stdpath("data")
  self.cache_dir = vim.fn.stdpath("cache")
  self.log_dir = self.cache_dir

  self.log_path = string.format("%s%s%s", self.log_dir, path_sep, "nvim_debug.log")
  self.which_key_vars = {
    options = {
      mode = "n",
      prefix = "<leader>",
      buffer = nil,
      silent = true,
      noremap = true,
      nowait = true,
    },
    voptions = {
      mode = "v",
      prefix = "<leader>",
      buffer = nil,
      silent = true,
      noremap = true,
      nowait = true,
    },
    mappings = {},
    vmappings = {},
  }

  self.opts = { noremap = true, silent = true }
  self.term_opts = { silent = true }
  self.keymap = function(mode, binding, action, opts, description)
    opts["desc"] = description

    vim.api.nvim_set_keymap(mode, binding, action, opts)
  end

  if vim.fn.has("mac") == 1 or vim.g.use_nerd_icons then
    self.icons = {
      kind = {
        Copilot = "",
        Text = "",
        Method = "m",
        Function = "",
        Constructor = "",
        Field = "",
        Variable = "",
        Class = "",
        Interface = "",
        Module = "",
        Property = "",
        Unit = "",
        Value = "",
        Enum = "",
        Keyword = "",
        Snippet = "",
        Color = "",
        File = "",
        Reference = "",
        Folder = "",
        EnumMember = "",
        Constant = "",
        Struct = "",
        Event = "",
        Operator = "",
        TypeParameter = "",
      },
      type = {
        Array = "",
        Number = "",
        String = "",
        Boolean = "蘒",
        Object = "",
      },
      documents = {
        File = "",
        Files = "",
        Folder = "",
        OpenFolder = "",
      },
      git = {
        Add = "",
        Mod = "",
        Remove = "",
        Ignore = "",
        Rename = "",
        Diff = "",
        Repo = "",
        Octoface = "",
      },
      ui = {
        ArrowClosed = "",
        ArrowOpen = "",
        CheckSquare = "",
        Lock = "",
        Circle = "",
        BigCircle = "",
        BigUnfilledCircle = "",
        Close = "",
        NewFile = "",
        Search = "",
        Lightbulb = "",
        Project = "",
        Dashboard = "",
        History = "",
        Comment = "",
        Bug = "",
        Code = "",
        Telescope = "",
        Gear = "",
        Package = "",
        List = "",
        SignIn = "",
        SignOut = "",
        Check = "",
        Fire = "",
        Note = "",
        BookMark = "",
        Pencil = "",
        ChevronRight = ">",
        Table = "",
        Calendar = "",
        CloudDownload = "",
      },
      diagnostics = {
        Error = "",
        Warn = "",
        Info = "",
        Hint = "",
        Debug = "",
        Trace = "",
      },
      misc = {
        Robot = "ﮧ",
        Squirrel = "",
        Tag = "",
        Watch = "",
        Smiley = "ﲃ",
        Package = "",
        CircuitBoard = "",
      },
    }
  else
    self.icons = {
      kind = {
        Copilot = "",
        Text = " ",
        Method = " ",
        Function = " ",
        Constructor = " ",
        Field = " ",
        Variable = " ",
        Class = " ",
        Interface = " ",
        Module = " ",
        Property = " ",
        Unit = " ",
        Value = " ",
        Enum = " ",
        Keyword = " ",
        Snippet = " ",
        Color = " ",
        File = " ",
        Reference = " ",
        Folder = " ",
        EnumMember = " ",
        Constant = " ",
        Struct = " ",
        Event = " ",
        Operator = " ",
        TypeParameter = " ",
        Misc = " ",
      },
      type = {
        Array = " ",
        Number = " ",
        String = " ",
        Boolean = " ",
        Object = " ",
      },
      documents = {
        File = " ",
        Files = " ",
        Folder = " ",
        OpenFolder = " ",
      },
      git = {
        Add = " ",
        Mod = " ",
        Remove = " ",
        Ignore = " ",
        Rename = " ",
        Diff = " ",
        Repo = " ",
        Octoface = " ",
      },
      ui = {
        ArrowClosed = "",
        ArrowOpen = "",
        CheckSquare = "",
        Lock = " ",
        Circle = " ",
        BigCircle = " ",
        BigUnfilledCircle = " ",
        Close = " ",
        NewFile = " ",
        Search = " ",
        Lightbulb = " ",
        Project = " ",
        Dashboard = " ",
        History = " ",
        Comment = " ",
        Bug = " ",
        Code = " ",
        Telescope = " ",
        Gear = " ",
        Package = " ",
        List = " ",
        SignIn = " ",
        SignOut = " ",
        NoteBook = " ",
        Check = " ",
        Fire = " ",
        Note = " ",
        BookMark = " ",
        Pencil = " ",
        ChevronRight = "",
        Table = " ",
        Calendar = " ",
        CloudDownload = " ",
      },
      diagnostics = {
        Error = " ",
        Warn = " ",
        Info = " ",
        Hint = " ",
        Debug = "",
        Trace = "✎",
      },
      misc = {
        Robot = " ",
        Squirrel = " ",
        Tag = " ",
        Watch = " ",
        Smiley = " ",
        Package = " ",
        CircuitBoard = " ",
      },
    }
  end
end

global:load_variables()

return global
