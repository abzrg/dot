augroup clap_on_enter_exit
    autocmd!
    autocmd User ClapOnEnter call s:clap_on_enter()
    autocmd User ClapOnExit call s:clap_on_exit()
augroup END

function! s:clap_on_enter() abort
    if exists('g:loaded_mucomplete')
        MUcompleteAutoOff
        let s:mucomplete_disabled = 1
    endif
endfunction

function! s:clap_on_exit() abort
    if exists('s:mucomplete_disabled')
        MUcompleteAutoOn
        unlet s:mucomplete_disabled
    endif
endfunction
