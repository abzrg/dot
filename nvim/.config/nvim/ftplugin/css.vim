setlocal tabstop=2
setlocal shiftwidth=2
" setlocal expandtab

" Folding based on the syntax (from treesitter)
setlocal foldmethod=expr
setlocal foldexpr=nvim_treesitter#foldexpr()
