set tabstop=4
set shiftwidth=4
set expandtab

nnoremap <silent> ;z :echomsg "look up <cword> in cppreference.com"
            \ <bar> sleep 500m
            \ <bar> silent! !cref <cword><CR>
