setlocal spell
setlocal tabstop=2
setlocal shiftwidth=2

let g:markdown_fenced_languages = [
\   'html',
\   'bash=sh',
\   'tex',
\   'cpp',
\   'c',
\   'python'
\]

" Syntax highlight is synchronized in 50 lines. It may cause collapsed
" highlighting at large fenced code block. In the case, please set larger value
" in your vimrc:
let g:markdown_minlines = 100
" Note that setting too large value may cause bad performance on highlighting.
