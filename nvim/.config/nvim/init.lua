-- User settings
require('user/mappings')
require('user/plugins')
require('user/hooks')
require('user/junks')
require('user/options')

-- functionality
vim.cmd('filetype indent plugin on')
vim.cmd('syntax on')
vim.cmd('colo codedark')
vim.cmd('hi Normal guibg=none')
vim.cmd('hi EndOfBuffer guibg=#222222')
vim.cmd('hi statusline guibg=#cccccc guifg=#000000')
vim.cmd('hi LineNr guibg=#222222')

-- Fix formatting problem
vim.api.nvim_exec(
    'autocmd Filetype * setlocal formatoptions-=c formatoptions-=o formatoptions+=l formatoptions+=j', false)
