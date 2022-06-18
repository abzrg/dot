function! Pylint() abort
    setlocal makeprg=pylint\ --output-format=parseable\ %
    if exists(":Make")
        :w | Make
    else
        :w | make
    endif
endfunction

augroup PyLint
    autocmd!
    autocmd BufEnter,BufRead,BufReadPre,BufWinEnter,FileType python
                \ nnoremap <buffer> <silent> <leader>l :call Pylint()<CR>
augroup END
