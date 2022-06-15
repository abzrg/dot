-- User settings
require('user/options')
require('user/mappings')
require('user/hooks')
require('user/junks')
require('user/plugins')
require('utils/statusline')

-- Functionality
vim.cmd('filetype indent plugin on')
vim.cmd('colo nord')
vim.cmd('hi Comment guifg=#717E98')
vim.cmd([[
    highlight FileName gui=bold guibg=#4C566A
]])
