local builtin = require("telescope.builtin")
local utils = require("telescope.utils")
local extensions = require('telescope').extensions.file_browser

local M = {}

function M.old_files()
    local fileopts = {}
    fileopts.file_ignore_patterns = {
        "splash.txt"
    }
    builtin.oldfiles(fileopts)
end

-- Repo File Finder
function M.project_files()
    -- If you're in home directory don't do anything
    local curr_dir = vim.api.nvim_exec("echo getcwd()", true)
    if curr_dir == os.getenv("HOME") then
        vim.api.nvim_command("Files")
        return
    end

    local _, ret = utils.get_os_command_output({"git", "rev-parse", "--is-inside-work-tree"})
    local gitopts = {}
    local fileopts = {}

    gitopts.prompt_title = "Git Files"
    -- gitopts.prompt_prefix = "  "
    gitopts.show_untracked = false

    fileopts.hidden = true
    fileopts.file_ignore_patterns = {
        ".vim/",
        ".local/",
        ".cache/",
        "Downloads/",
        ".git/",
        "Dropbox/.*",
        "Library/.*",
        ".rustup/.*",
        "Movies/",
        ".cargo/registry/",
        ".woff",
        ".woff2",
        ".ttf",
        ".otf"
    }

    if ret == 0 then
        builtin.git_files(gitopts)
    else
        builtin.find_files(fileopts)
    end
end

-- Grep Notes
function M.grep_notes()
    local opts = {}
    opts.hidden = true
    -- opts.file_ignore_patterns = { 'thesaurus/'}
    opts.search_dirs = {
        "~/Documents/notes/"
    }
    opts.prompt_prefix = ">  "
    opts.prompt_title = " Grep Notes"
    opts.path_display = {"shorten"}
    builtin.live_grep(opts)
end

-- Find Note Files
function M.find_notes()
    local opts = {
        cwd = "~/Documents/notes",
        prompt_title = "Find Notes",
        path_display = {"shorten"},
        layout_strategy = "horizontal",
        layout_config = {preview_width = 0.65, width = 0.75}
    }
    builtin.find_files(opts)
end

-- Browse Notes
function M.browse_notes()
    extensions.file_browser {
        prompt_title = "Browse Notes",
        prompt_prefix = "> ",
        cwd = "~/Documents/notes/",
        layout_strategy = "horizontal",
        layout_config = {preview_width = 0.65, width = 0.75}
    }
end

-- Find Scripts Files
function M.find_scripts()
    local opts = {
        search_dirs = {"~/.local/scripts", "~/.local/bin/"},
        prompt_title = "Find Scripts",
        path_display = {"shorten"},
        layout_strategy = "horizontal",
        layout_config = {preview_width = 0.65, width = 0.75}
    }
    builtin.find_files(opts)
end

-- Neovim config files
function M.find_nvim_config()
    local opts = {
        cwd = "~/.config/nvim",
        prompt_title = "Find NVim Config",
        -- path_display = {"shorten"},
        layout_strategy = "horizontal",
        layout_config = {preview_width = 0.65, width = 0.75}
    }
    builtin.find_files(opts)
end

-- Grep neovim config
function M.grep_nvim_config()
    local opts = {}
    opts.hidden = true
    opts.file_ignore_patterns = {"moby-words.txt"}
    opts.search_dirs = {
        "~/.config/nvim"
    }
    opts.prompt_prefix = "> "
    opts.prompt_title = " Grep NVim config"
    opts.path_display = {"shorten"}
    builtin.live_grep(opts)
end

-- All dot files
function M.find_dot_files()
    local opts = {
        cwd = "~/.dot/",
        prompt_title = "Find Dot Files",
        path_display = {"shorten"},
        layout_strategy = "horizontal",
        layout_config = {preview_width = 0.65, width = 0.75},
        hidden = true
    }
    builtin.find_files(opts)
end

return M
