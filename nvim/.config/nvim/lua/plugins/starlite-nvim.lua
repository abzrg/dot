vim.cmd([[
nnoremap <silent> * :lua require'starlite'.star()<cr>
nnoremap <silent> g* :lua require'starlite'.g_star()<cr>
nnoremap <silent> # :lua require'starlite'.hash()<cr>
nnoremap <silent> g# :lua require'starlite'.g_hash()<cr>
]])
