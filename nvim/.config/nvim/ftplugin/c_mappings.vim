augroup ClangFormat
au!
    autocmd BufEnter,BufWritePost,BufWritePre,FileType c
                \ nnoremap <silent> == :w <bar>silent! !clang-format -style=file -i %<CR>
augroup END
