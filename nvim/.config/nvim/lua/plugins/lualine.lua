-- Eviline config for lualine
-- Author: shadmansaleh
-- Credit: glepnir
local lualine = require 'lualine'

---- [ Functions ] -------------------------------------------------------------

local function lsp_progress()
    local messages = vim.lsp.util.get_progress_messages()
    if #messages == 0 then
        return ""
    end
    local status = {}
    for _, msg in pairs(messages) do
        table.insert(status, (msg.percentage or 0) .. "%% " .. (msg.title or ""))
    end
    local spinners = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
    local ms = vim.loop.hrtime() / 1000000
    local frame = math.floor(ms / 120) % #spinners
    return table.concat(status, " | ") .. " " .. spinners[frame + 1]
end

local function diff_source()
    local gitsigns = vim.b.gitsigns_status_dict
    if gitsigns then
        return {
            added = gitsigns.added,
            modified = gitsigns.changed,
            removed = gitsigns.removed,
        }
    end
end

local function testing()
    if vim.g.testing_status == "running" then
        return " "
    end
    if vim.g.testing_status == "fail" then
        return ""
    end
    if vim.g.testing_status == "pass" then
        return " "
    end
    return nil
end

local function using_session()
    return (vim.g.using_persistence ~= nil)
end

local mode = function()
    local mod = vim.fn.mode()
    if mod == "n" or mod == "no" or mod == "nov" then
        return "-- Normal --"
    elseif mod == "i" or mod == "ic" or mod == "ix" then
        return "-- Insert --"
    elseif mod == "V" or mod == "" or mod == "s" or mod == "v" or mod == "vs" or mod == "Vs" or mod == "cv" then
        return "-- Visual --"
    elseif mod == "c" or mod == "ce" then
        return "-- Commmand --"
    elseif mod == "r" or mod == "rm" or mod == "r?" then
        return "-- Normal --"
    elseif mod == "R" or mod == "Rc" or mod == "Rv" or mod == "Rv" then
        return "-- Replace --"
    elseif mod == "S" or mod == "s" or mod == "" then
        return "-- Select --"
    end
    return "-- Normal --"
end

local default_colors = {
    bg = "#d4d4d4",
    bg_alt = "#242424",
    -- bg = "#68217a",
    -- bg_alt = "#68217a",
    -- bg = "#005577",
    -- bg_alt = "#327ac6",
    -- bg = "#007acc",
    -- bg_alt = "#007acc",
    fg = "#1a1a1a",
    -- fg = "#d4d4d4",
    fg_alt = "#888888",
    yellow = "#dcdcaa",
    yellow_orange = "#d7ba7d",
    cyan = "#4ec9b0",
    light_blue = "#9cdcfe",
    green = "#6a9955",
    orange = "#ce9178",
    violet = "#c586c0",
    magenta = "#d16d9e",
    blue = "#569cd6",
    red = "#d16969",
    git = { change = "#0c7d9d", add = "#587c0c", delete = "#94151b", conflict = "#bb7a61" },
}

local colors = default_colors

-- Color table for highlights
local mode_color = {
    n = colors.fg,
    i = colors.fg,
    v = colors.fg,
    [""] = colors.fg,
    V = colors.fg,
    c = colors.fg,
    no = colors.fg,
    s = colors.fg,
    S = colors.fg,
    [""] = colors.fg,
    ic = colors.fg,
    R = colors.fg,
    Rv = colors.fg,
    cv = colors.fg,
    ce = colors.fg,
    r = colors.fg,
    rm = colors.fg,
    ["r?"] = colors.fg,
    ["!"] = colors.fg,
    t = colors.fg,
}

local conditions = {
    buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand "%:t") ~= 1
    end,
    hide_in_width = function()
        return vim.fn.winwidth(0) > 80
    end,
    hide_in_width_lsp = function()
        return vim.fn.winwidth(0) > 60
    end,
    hide_small = function()
        return vim.fn.winwidth(0) > 150
    end,
    check_git_workspace = function()
        local filepath = vim.fn.expand "%:p:h"
        local gitdir = vim.fn.finddir(".git", filepath .. ";")
        return gitdir and #gitdir > 0 and #gitdir < #filepath
    end,
}

-- Config
local config = {
    options = {
        -- Disable sections and component separators
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        icons_enabled = true,
        theme = {
            -- We are going to use lualine_c an lualine_x as left and
            -- right section. Both are highlighted by c theme .  So we
            -- are just setting default looks o statusline
            normal = { c = { fg = colors.fg, bg = colors.bg } },
            inactive = { c = { fg = colors.fg, bg = colors.bg_alt } },
        },
        disabled_filetypes = { "dashboard", "NvimTree", "Outline", "alpha" },
    },
    sections = {
        -- these are to remove the defaults
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        -- These will be filled later
        lualine_c = {},
        lualine_x = {}
    },
    inactive_sections = {
        -- these are to remove the defaults
        lualine_a = {},
        lualine_v = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {
            {
                function()
                    vim.api.nvim_command(
                    "hi! LualineModeInactive guifg=" .. mode_color[vim.fn.mode()] .. " guibg=" .. colors.bg_alt
                    )
                    return ""
                end,
                color = "LualineModeInactive",
                padding = { left = 0, right = 0 },
                -- left_padding = 1,
            },
            {
                "filename",
                cond = conditions.buffer_not_empty,
                color = { fg = colors.fg_alt, gui = "italic" },
                padding = { left = 3, right = 3}
            },
        },
        lualine_x = {}
    }
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
    table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x ot right section
local function ins_right(component)
    table.insert(config.sections.lualine_x, component)
end



---- [ Components ] -----------------------------------------------------------

-- Git
ins_left {
    function()
        return "  "
    end,
    cond = conditions.check_git_workspace,
    color = { fg = colors.fg },
    padding = 0,
}

ins_left {
    "b:gitsigns_head",
    cond = conditions.check_git_workspace,
    color = { fg = colors.fg },
    padding = 0,
}

-- File name
ins_left {
    "filename",
    cond = conditions.buffer_not_empty,
    padding = { left = 3, right = 3 },
    color = { fg = colors.fg, gui = "bold" },
}

-- Padding
ins_left {
    function()
        return ""
    end,
    padding = 0,
}

-- Diagnostics
local ok, _ = pcall(require, "vim.diagnostic")
if ok then
    ins_left {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        symbols = { error = " ", warn = " ", info = " ", hint = " " },
        sections = { "error", "warn" },
        -- sections = {'error', 'warn', 'info', 'hint'},
        -- cond = conditions.hide_in_width,
        colored = false,
        always_visible = true,
        padding = { left = 2, right = 2 },
    }
else
    ins_left {
        "diagnostics",
        sources = { "nvim_lsp" },
        sections = { "error", "warn" },
        -- sections = {'error', 'warn', 'info', 'hint'},
        symbols = { error = " ", warn = " ", info = " ", hint = " " },
        -- cond = conditions.hide_in_width,
        colored = false,
        always_visible = true,
        padding = { left = 2, right = 2 },
    }
end

-- Mode
ins_left {
    -- mode component
    function()
        -- auto change color according to neovims mode
        vim.api.nvim_command("hi! LualineMode guifg=" .. mode_color[vim.fn.mode()] .. " guibg=" .. colors.bg)
        return mode()
    end,
    color = "LualineMode",
    padding = { left = 0, right = 0 },
    -- left_padding = 1,
}

ins_left {
    provider = function()
        return testing()
    end,
    enabled = function()
        return testing() ~= nil
    end,
    hl = {
        fg = colors.fg,
    },
    left_sep = " ",
    right_sep = {
        str = " |",
        hl = { fg = colors.fg },
    },
}

ins_left {
    provider = function()
        if vim.g.using_persistence then
            return "  |"
        elseif vim.g.using_persistence == false then
            return "  |"
        end
    end,
    enabled = function()
        return using_session()
    end,
    hl = {
        fg = colors.fg,
    },
}

-- Lsp progress
ins_left {
    lsp_progress,
    cond = conditions.hide_small,
}

-- Insert mid section. You can make any number of sections in neovim :)
-- for lualine it's any number greater then 2
ins_left {
    function()
        return "%="
    end,
}

-- Read-only | Modifiable
ins_right {
    function()
        if not vim.bo.readonly or not vim.bo.modifiable then
            return ""
        end
        return "" -- """
    end,
    color = { fg = colors.fg },
}

-- Diff
ins_right {
    "diff",
    source = diff_source,
    symbols = { added = "  ", modified = "柳", removed = " " },
    diff_color = {
        added = { fg = colors.fg },
        modified = { fg = colors.fg },
        removed = { fg = colors.fg },
    },
    color = {},
    cond = conditions.hide_in_width,
    -- cond = nil,
}

-- Lsp server name
ins_right {
    function()
        local msg = ''
        local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
        local clients = vim.lsp.get_active_clients()
        if next(clients) == nil then
            return msg
        end
        for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                return "[" .. client.name .. "]"
            end
        end
        return msg
    end,
    icon = '',
    color = { },
}

-- ins_right {
--     function()
--         return "Spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth") .. " "
--     end,
--     cond = conditions.hide_in_width,
--     color = { fg = colors.fg, bg = colors.bg },
-- }

-- Location
ins_right {
    "location",
    left_padding = 2,
    right_padding = 2,
    color = { fg = colors.fg, gui = "bold" },
}

ins_right {
    'progress',
    left_padding = 2,
    right_padding = 2,
    color = { fg = colors.fg, gui = 'bold' }
}

-- Filetype
ins_right {
    "filetype",
    cond = conditions.hide_in_width,
    color = { fg = colors.fg, bg = colors.bg },
    icon = "",
}

-- Now don't forget to initialize lualine
lualine.setup(config)
