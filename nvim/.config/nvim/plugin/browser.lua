vim.cmd([[
" -- remove trailing white spaces

function! Tidy() abort
    let _s=@/
    silent! %s/\s\+$//e
    " Suppress the 'Hit enter to continue' message
    redraw!
    let @/=_s
    nohl
endfunction


" -- Browse using w3m and friends

function! Browse() abort
    " -- check the content of the system clipboard
    let s:clipboardUrl = ""


    " -- check for the system clipboard manager (only works for mac and linux for now)

        if has('mac')
            let s:clipboardCmd = 'pbpaste'
        elseif has('linux')
            let s:clipboardCmd = 'xclip -sel clip -o'
        endif


    " -- Prompt the user for a website

        " change the color highlighting of the prompt string
        echoh Question

        " prepopulate the prompt with the content of the clipboard
        let s:url = input('url> ', system(s:clipboardCmd))

        " strip leading/trailing whitespace from url
        " src: https://stackoverflow.com/a/53250594/13041067
        let s:url = trim(s:url)

        " If user didn't provide any url then exit
        if empty(s:url) != 0
            return
        endif

        " clear syntax highlighting of the prompt for next usages
        echoh None


    " -- Grab the output of curl and put into a variable
        let s:content = system('w3m -dump -cols 80 ' . "'" . s:url . "'" . ' 2>/dev/null')


    " -- After downloading text, create a new scratch buffer in a new tab

        if &buftype ==# '' || &buftype ==# 'nofile'
            enew
        else
            tabnew
        endif

        setlocal
                    \ bufhidden=wipe
                    \ nobuflisted
                    \ nolist
                    \ noswapfile
                    \ norelativenumber
                    \ nonumber
                    \ signcolumn=no
                    \ noshowmode

        " to quit this window only press q
        nnoremap <buffer><silent> q :bd<CR>


    " -- dump the final content in the buffer

        silent! -1 put =s:content


    " -- set the title for the buffer

        " get the title from a page using curl and grep
            " src: https://unix.stackexchange.com/a/103282/419393
        " convert html entities to text
            " src:https://stackoverflow.com/a/6141383/13041067
        let s:title = system("curl " . "'" . s:url . "'" .
                    \ " -so - | ggrep -iPo '(?<=<title>)(.*)(?=</title>)'" .
                    \ " | w3m -dump -T text/html" )
        call execute('file ' . s:title, 'silent!')


    " -- make this buffer Readonly

        setlocal readonly nomodifiable nomodified


    call Tidy()


    " -- Immediately go to the top of the buffer

        norm gg


    " go to zen mode
        " ZenMode

endfunction

command! Browse :call Browse()
command! Br :call Browse()
nnoremap <leader>B :Br<CR>
]])
