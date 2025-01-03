fun s:wrapped_cc()
    let &colorcolumn = join(map(range(10), {i -> &columns * i + str2nr(&cc)}), ',')
endfun

augroup wrappedcc
    autocmd!
    autocmd OptionSet  colorcolumn  if &cc != '' && &cc !~ ','       | call s:wrapped_cc() | endif
    autocmd VimEnter   *            if &cc != '' && &cc !~ ','       | call s:wrapped_cc() | endif
    autocmd VimResized *            if len(matchlist(&cc, ',')) >= 4 | call s:wrapped_cc() | endif
augroup end
