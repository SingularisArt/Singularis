local cache = {}

local function refresh_cache(key)
    if cache[key] then cache[key].value = cache[key].fn() end
end

local function cache_get(key, compute_fn)
    local cached = cache[key]
    if cached then return cached.value end
    local value = compute_fn()
    cache[key] = {value = value, fn = compute_fn}
    return value
end

function SpellToggle()
    if vim.opt.spell:get() then
        vim.opt_local.spell = false
        vim.opt_local.spelllang = "en"
    else
        vim.opt_local.spell = true
        vim.opt_local.spelllang = {"en_us"}
    end
end

local function spell_status()
    local spellLang = vim.opt_local.spelllang:get()
    if type(spellLang) == "table" then
        spellLang = table.concat(spellLang, ", ")
    end
    return string.upper(spellLang)
end

local function git_branch()
    return cache_get("git_branch", function()
        if vim.g.loaded_fugitive then
            local branch = vim.fn.FugitiveHead()
            if branch ~= "" then
                if vim.api.nvim_win_get_width(0) <= 80 then
                    return " " .. string.upper(branch:sub(1, 2))
                end
                return " " .. string.upper(branch)
            end
        end
        return ""
    end)
end

local function update_status_for_file(file_path)
    -- Get number of lines added and deleted using git diff --numstat
    local diff_stats = vim.fn.system("git diff --numstat " ..
                                         vim.fn.shellescape(file_path))
    if vim.v.shell_error ~= 0 or diff_stats == "" then return "" end

    local added, deleted = diff_stats:match("(%d+)%s+(%d+)%s+%S+")
    added, deleted = tonumber(added), tonumber(deleted)
    local delta = math.min(added, deleted)

    local status = {
        changed = delta,
        added = added - delta,
        removed = deleted - delta
    }

    -- Format the status for display
    local status_txt = {}
    if status.added > 0 then table.insert(status_txt, "+" .. status.added) end
    if status.changed > 0 then
        table.insert(status_txt, "~" .. status.changed)
    end
    if status.removed > 0 then
        table.insert(status_txt, "-" .. status.removed)
    end

    if #status_txt > 1 then
        for i = 2, #status_txt do status_txt[i] = "," .. status_txt[i] end
    end

    local formatted_status = ""
    if #status_txt > 0 then
        formatted_status = string.format("[%s]", table.concat(status_txt))
    else
        formatted_status = ""
    end

    return formatted_status
end

local function status_for_file()
    return cache_get("file_status", function()
        local file_path = vim.api.nvim_buf_get_name(0)

        if file_path == "" then return "" end
        return update_status_for_file(file_path)
    end)
end

local function human_file_size()
    return cache_get("file_size", function()
        local file = vim.api.nvim_buf_get_name(0)
        if file == "" then return "" end

        local size = vim.fn.getfsize(file)
        local suffixes = {"B", "KB", "MB", "GB"}
        local i = 1
        while size > 1024 do
            size = size / 1024
            i = i + 1
        end

        return size <= 0 and "" or string.format("[%.0f%s]", size, suffixes[i])
    end)
end

local function smart_file_path()
    return cache_get("file_path", function()
        local buf_name = vim.api.nvim_buf_get_name(0)
        local is_wide = vim.api.nvim_win_get_width(0) > 80
        if buf_name == "" then return "[No Name]" end

        local file_dir = buf_name:sub(1, 5):find("term") and vim.env.PWD or
                             vim.fs.dirname(buf_name)
        file_dir = file_dir:gsub(vim.env.HOME, "~", 1)

        if not is_wide then file_dir = vim.fn.pathshorten(file_dir) end

        if buf_name:sub(1, 5):find("term") then
            return file_dir .. " "
        else
            return string.format("%s/%s ", file_dir, vim.fs.basename(buf_name))
        end
    end)
end

local function word_count()
    local words = vim.fn.wordcount()
    if words.visual_words ~= nil then
        return string.format("[%s]", words.visual_words)
    else
        return string.format("[%s]", words.words)
    end
end

local modes = setmetatable({
    ["n"] = {"NORMAL", "N"},
    ["no"] = {"N·OPERATOR", "N·P"},
    ["nov"] = {"O·PENDING", "O·P"},
    ["noV"] = {"O·PENDING", "O·P"},
    ["no\22"] = {"O·PENDING", "O·P"},
    ["niI"] = {"NORMAL", "N"},
    ["niR"] = {"NORMAL", "N"},
    ["niV"] = {"NORMAL", "N"},
    ["nt"] = {"NORMAL", "N"},
    ["ntT"] = {"NORMAL", "N"},
    ["v"] = {"VISUAL", "V"},
    ["V"] = {"V·LINE", "V·L"},
    ["\22"] = {"V·BLOCK", "V·B"},
    ["\22s"] = {"V·BLOCK", "V·B"},
    ["s"] = {"SELECT", "S"},
    ["S"] = {"S·LINE", "S·L"},
    ["\19"] = {"S·BLOCK", "S·B"},
    ["i"] = {"INSERT", "I"},
    ["ic"] = {"INSERT", "I"},
    ["ix"] = {"INSERT", "I"},
    ["R"] = {"REPLACE", "R"},
    ["Rv"] = {"V·REPLACE", "V·R"},
    ["Rc"] = {"REPLACE", "R"},
    ["Rx"] = {"REPLACE", "R"},
    ["Rvc"] = {"V·REPLACE", "V·R"},
    ["Rvx"] = {"V·REPLACE", "V·R"},
    ["c"] = {"COMMAND", "C"},
    ["cv"] = {"VIM·EX", "V·E"},
    ["ce"] = {"EX", "E"},
    ["r"] = {"PROMPT", "P"},
    ["rm"] = {"MORE", "M"},
    ["r?"] = {"CONFIRM", "C"},
    ["!"] = {"SHELL", "S"},
    ["t"] = {"TERMINAL", "T"}
}, {
    __index = function()
        return {"UNKNOWN", "U"} -- handle edge cases
    end
})

local function get_current_mode()
    local mode = modes[vim.api.nvim_get_mode().mode]
    if vim.api.nvim_win_get_width(0) <= 80 then
        return string.format("%s ", mode[2]) -- short name
    else
        return string.format("%s ", mode[1]) -- long name
    end
end

local function file_type()
    return cache_get("file_type", function()
        local buf_name = vim.api.nvim_buf_get_name(0)
        local width = vim.api.nvim_win_get_width(0)

        local ft = vim.bo.filetype
        if ft == "" then
            return "[None]"
        else
            if width > 80 then
                return string.format("[%s]", ft)
            else
                local ext = vim.fn.fnamemodify(buf_name, ":e")
                local shorter = (string.len(ft) < string.len(ext)) and ft or ext
                return string.format("[%s]", shorter)
            end
        end
    end)
end

---@diagnostic disable-next-line: lowercase-global
function status_line()
    return table.concat({
        get_current_mode(), -- get current mode
        spell_status(), -- display language and if spell is on
        git_branch(), -- branch name
        " %<", -- spacing
        smart_file_path(), -- smart full path filename
        "%h%m%r%w", -- help flag, modified, readonly, and preview
        "%=", -- right align
        status_for_file(), -- git status for file
        word_count(), -- word count
        "[%-3.(%l|%c]", -- line number, column number
        human_file_size(), -- file size
        file_type() -- file type
    })
end

vim.api.nvim_create_augroup("StatusLineCache", {})
vim.api.nvim_create_autocmd({"BufEnter"}, {
    pattern = "*",
    group = "StatusLineCache",
    callback = function()
        refresh_cache("git_branch") -- this should be another event
        refresh_cache("file_status")
        refresh_cache("file_size")
        refresh_cache("file_path")
        refresh_cache("file_type")
    end
})

vim.api.nvim_create_autocmd({"BufWritePost"}, {
    pattern = "*",
    group = "StatusLineCache",
    callback = function()
        refresh_cache("file_status")
        refresh_cache("file_size")
        refresh_cache("file_path")
    end
})

vim.api.nvim_create_autocmd({"WinResized"}, {
    pattern = "*",
    group = "StatusLineCache",
    callback = function()
        refresh_cache("git_branch")
        refresh_cache("file_path")
        refresh_cache("file_type")
    end
})

vim.opt.statusline = "%!luaeval('status_line()')"

vim.wo.fillchars = "eob:~" -- fillchars of windows
