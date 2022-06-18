augroup ClangFormat
au!
    autocmd BufEnter,BufWritePost,BufWritePre,FileType cpp
                \ nnoremap <silent> <leader>= :w <bar>silent! !clang-format -style=file -i %<CR>
augroup END
