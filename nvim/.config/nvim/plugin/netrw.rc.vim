let g:netrw_http_cmd = "brave"
let g:netrw_browsex_viewer = "xdg-open"
let g:netrw_banner         = 0
let g:netrw_liststyle      = 3
let g:netrw_browse_split   = 4
let g:netrw_fastbrowse     = 1
let g:netrw_altv           = 1
let g:netrw_silent         = 1
let g:netrw_sort_by        = 'name'
let g:netrw_sort_direction = 'normal'
let g:netrw_winsize = 25

" Don't show dotfiles by default (press gh to toggle dot file hiding)
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'

" Inherit custom wildignore
let g:netrw_list_hide = &wildignore

" Close netrw if its the last window
aug netrw_close
  au!
  au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&filetype") == "netrw"|q|endif
aug END

" Toggle netrw
let g:NetrwIsOpen=0
function! ToggleNetrw()
    if g:NetrwIsOpen
        let i = bufnr("$")
        while (i >= 1)
            if (getbufvar(i, "&filetype") == "netrw")
                silent exe "bwipeout " . i
            endif
            let i-=1
        endwhile
        let g:NetrwIsOpen=0
    else
        let g:NetrwIsOpen=1
        silent Lexplore
    endif
endfunction
" noremap <silent> <leader>f :call ToggleNetrw()<CR>
