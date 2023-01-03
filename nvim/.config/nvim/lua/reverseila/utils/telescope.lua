-- Check it is installed
local status_ok, telescope = pcall(require, "telescope")
if (not status_ok) then
  return
end

local builtin = require("telescope.builtin")
local utils = require("telescope.utils")

local extensions = require("telescope").extensions.file_browser


-- Module object
local M = {}


-- Find file: Shows hidden files, detects a git repos, and ignore special files
function M.project_files()
  -- If you're in home directory don't do anything
  local curr_dir = vim.api.nvim_exec("echo getcwd()", true)
  if curr_dir == os.getenv("HOME") then
    print("Running Telescope in HOME is expensive. Try using this feature in a samller workspace.")
    return
  end

  -- Check if you're in a git repo
  local _, ret = utils.get_os_command_output({ "git", "rev-parse", "--is-inside-work-tree" })

  -- Options for a git repository
  local gitopts = {}

  -- Options for a non-git folders
  local fileopts = {}

  gitopts.prompt_title = "Git Files"
  gitopts.show_untracked = false
  gitopts.file_ignore_patterns = {
    ".git/",
    ".cache/",
    "__pycache__/",
    ".pytest_cache/",
    "tags",
    "build/"
  }
  gitopts.layout_strategy = "vertical"

  fileopts.hidden = true
  fileopts.file_ignore_patterns = {
    "__pycache__",
    ".pytest_cache",
    ".vim/",
    ".local/",
    ".cache/",
    "Downloads/",
    "Movies/",
    ".git/",
    "Dropbox/.*",
    "Library/.*",
    ".rustup/.*",
    ".cargo/registry/",
    ".woff",
    ".woff2",
    ".ttf",
    ".otf",
    "tags",
    "build/"
  }
  fileopts.layout_strategy = "vertical"

  if ret == 0 then
    builtin.git_files(gitopts)
  else
    builtin.find_files(fileopts)
  end
end

-- Grep Notes
function M.grep_notes()
  -- Find note directory
  local notes_dir = os.getenv("NOTES_DIR")
  if notes_dir == nil then
    print("The env variable 'NOTES_DIR' is not set.")
    return
  end

  -- Set optsions
  local opts = {}
  opts.hidden = true
  opts.search_dirs = { notes_dir }
  opts.prompt_prefix = ">  "
  opts.prompt_title = "Grep Notes"
  opts.path_display = { "shorten" }

  builtin.live_grep(opts)
end

-- Find Note Files
function M.find_notes()
  -- Find note directory
  local notes_dir = os.getenv("NOTES_DIR")
  if notes_dir == nil then
    print("The env variable 'NOTES_DIR' is not set.")
    return
  end

  -- Set optsions
  local opts = {
    cwd = notes_dir,
    prompt_title = "Find Notes",
    path_display = { "shorten" },
    layout_strategy = "horizontal",
    layout_config = { preview_width = 0.65, width = 0.75 }
  }

  builtin.find_files(opts)
end

-- Browse Notes
function M.browse_notes()
  -- Find note directory
  local notes_dir = os.getenv("NOTES_DIR")
  if notes_dir == nil then
    print("The env variable 'NOTES_DIR' is not set.")
    return
  end

  extensions.file_browser {
    prompt_title = "Browse Notes",
    prompt_prefix = "> ",
    cwd = notes_dir,
    layout_strategy = "horizontal",
    layout_config = { preview_width = 0.65, width = 0.75 }
  }
end

-- Find Scripts Files
function M.find_scripts()
  -- Set options
  local opts = {
    follow = true, -- Follow symlink
    search_dirs = { "~/.local/scripts", "~/.local/bin/" },
    prompt_title = "Find Scripts",
    path_display = { "shorten" },
    layout_strategy = "horizontal",
    layout_config = { preview_width = 0.65, width = 0.75 }
  }

  builtin.find_files(opts)
end

-- Find Scripts Files
function M.find_dotfiles()
  -- Set options
  local opts = {
    hidden = true,
    follow = true, -- Follow symlink
    search_dirs = { "~/.dot" },
    prompt_title = "Find DotFiles",
    path_display = { "shorten" },
    layout_strategy = "vertical",
    -- layout_config = { preview_width = 0.65, width = 0.75 }
  }

  builtin.find_files(opts)
end

return M
