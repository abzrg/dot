-- User settings
require('user/options')
require('user/mappings')
require('user/hooks')
require('user/junks')
require('user/plugins')
require('utils/statusline')

-- Functionality
vim.cmd('filetype indent plugin on')
vim.cmd('colo codedark')
vim.cmd('hi Normal guibg=None')

