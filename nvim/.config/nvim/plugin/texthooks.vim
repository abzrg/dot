" like emacs autofill mode
autocmd FileType text setlocal formatoptions+=t

" fix issue with comment
autocmd Filetype text set commentstring="%s

" notes are different from programming
autocmd Filetype text setlocal
            \ tabstop=2 shiftwidth=2
            \ signcolumn=no
            \ nonumber norelativenumber
