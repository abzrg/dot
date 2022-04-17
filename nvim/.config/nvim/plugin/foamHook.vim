" Check if the foam environment is loaded, first
" note that in macos you must create a case-sensitive /Volumes/OpenFOAM/
" partition
if !empty($WM_PROJECT_DIR)

    " add the tag file
    set tags+=$WM_PROJECT_DIR/tags


    " OpenFOAM specific hooks
    augroup OpenFOAM
    autocmd!


    " add projcet directory to path when you open a source file
    autocmd BufEnter,BufReadPost,BufRead *.C setlocal path+=$WM_PROJECT_DIR/**
    autocmd BufEnter,BufReadPost,BufRead *.H setlocal path+=$WM_PROJECT_DIR/**


    " disable lsp diagnostics for OpenFOAM source code
    autocmd BufEnter,BufReadPost,BufRead,BufNewFile
                \ */OpenFOAM/** lua vim.diagnostic.disable()


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

    augroup END
endif

