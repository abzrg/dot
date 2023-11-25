--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '


-- Disable rtp plugins

local vim = vim
local g = vim.g

g.loaded_gzip = 1
g.loaded_zip = 1
g.loaded_zipPlugin = 1
g.loaded_tar = 1
g.loaded_tarPlugin = 1

g.loaded_getscript = 1
g.loaded_getscriptPlugin = 1
g.loaded_vimball = 1
g.loaded_vimballPlugin = 1
g.loaded_2html_plugin = 1

-- g.loaded_matchit = 1
-- g.loaded_matchparen = 1
-- g.loaded_logiPat = 1
-- g.loaded_rrhelper = 1

g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
g.loaded_netrwSettings = 1
g.loaded_netrwFileHandlers = 1
g.loaded_netrw_gitignore = 1

-- Load configs

require('config/lazy')
require('config/options')
require('config/keymaps')
require('config/autocmds')
