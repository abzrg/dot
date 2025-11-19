syntax match WordListWord "\v\zs^[a-zA-Z][a-zA-z\(\)/'\.\- ]*\ze:"
highlight! link WordListWord String

" 1.\s
" (1)
syntax match WordListNumbering "\v(\([0-9]+\)|\s?[0-9]+\.\s)"

"syntax match WordListDefinition "\v\{\!?\=\_.{-}}"
" https://stackoverflow.com/a/33653151
syntax region WordListDefinition start=/\v\{\!?\=/ end=/\v}/
highlight WordListDefinition gui=italic guifg=gray

syntax match WordListPronunciation "\v\/\D{-}\/" contains=@NoSpell
"highlight! link WordListPronunciation gui=italic guifg=#cc6666

" noun, verb, adj,...
syntax match WordListType "\v\c(\((phrase|adj|adv|v|(n|n,?\s*C?,?U?|n,sing)|pv|(in)?formal)\))"
highlight! link WordListType ErrorMsg

" date
syntax match WordListDate "\v^--- .*$"
highlight WordListDate guifg=gray guibg=#222232

" TODO define highlight group for adj/adv/n/,... as keywords
