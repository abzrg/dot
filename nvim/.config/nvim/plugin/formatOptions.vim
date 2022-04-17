" Fix formatting problem

" For files that have no filetype associated with them
set formatoptions-=c
set formatoptions-=o
set formatoptions+=l
set formatoptions+=j
set formatoptions-=t

" For files that you edit and filetype mechanism kicks in and change stuff
autocmd Filetype * setlocal
            \ formatoptions-=c
            \ formatoptions-=o
            \ formatoptions+=l
            \ formatoptions+=j
            \ formatoptions-=t

autocmd FileType gitcommit setlocal formatoptions+=t
