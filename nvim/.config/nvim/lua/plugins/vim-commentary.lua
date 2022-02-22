-- Fix commentary for C and JSON files
vim.cmd([[ autocmd FileType  cpp setlocal commentstring=//\ %s ]])
vim.cmd([[ autocmd FileType    c setlocal commentstring=//\ %s ]])
vim.cmd([[ autocmd FileType foam setlocal commentstring=//\ %s ]])
vim.cmd([[ autocmd FileType json setlocal commentstring=//\ %s ]])
vim.cmd([[ autocmd FileType  sql setlocal commentstring=--\ %s ]])
vim.cmd([[ autocmd FileType xdefaults setlocal commentstring=!\ %s ]])
