" Check if the foam environment is loaded, first
" note that in macos you must create a case-sensitive /Volumes/OpenFOAM/
" partition
if !empty($WM_PROJECT_DIR)

    " add the tag file
    set tags=$WM_PROJECT_DIR/tags


    " OpenFOAM specific hooks
    augroup OpenFOAM
    autocmd!


    " add projcet directory to path and set the make program to wmake when you
    " open a source file (settings are local to the buffer)
    autocmd BufEnter,BufReadPost,BufRead *.C setlocal path+=$WM_PROJECT_DIR/** makeprg=wmake
    autocmd BufEnter,BufReadPost,BufRead *.H setlocal path+=$WM_PROJECT_DIR/** makeprg=wmake


    " disable lsp diagnostics for OpenFOAM header files
    " buffer 0 means the current buffer
    " autocmd BufEnter,BufReadPost,BufRead,BufNewFile
    "             \ */OpenFOAM/**/*.H lua vim.diagnostic.disable(0)


    " make all files under src/ readonly
    "
    " the reason I have two autocmd is that I wanted to differentiate between
    " the user directory and the openfoam source code directory, so that the
    " files under user src/ directories are not in readonly mode
    autocmd BufEnter,BufReadPost,BufRead,BufNewFile
                \ */OpenFOAM/OpenFOAM-*/src/** setlocal readonly
    autocmd BufEnter,BufReadPost,BufRead,BufNewFile
                \ */OpenFOAM/foam-extend-*/src/** setlocal readonly


    " set the correct comment string for foam files
    autocmd FileType foam set commentstring=//%s



    " " switch between the header/source counterpart
    " function! EditCounterpart() abort
    "     let l:ext = expand('%:e')
    "     " OpenFOAM
    "     if ext ==# 'C'
    "         if filereadable(expand('%'))
    "             e %:r.H
    "         endif
    "     elseif ext ==# 'H'
    "         if filereadable(expand('%'))
    "             e %:r.C
    "         endif
    "     endif
    " endfunction
    " nnoremap <CR> :call EditCounterpart()<CR>


augroup END
endif
