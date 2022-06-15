nnoremap <silent> == :w <bar>silent! !clang-format -style=file '~/.clang-format' -i %<CR>
