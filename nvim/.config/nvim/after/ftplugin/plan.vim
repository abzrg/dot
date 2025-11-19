setlocal nonu nornu
setlocal signcolumn=no

" Almost like markdown
nnoremap <silent><buffer> [[ m':call search('^---.*', "bW")<CR>
nnoremap <silent><buffer> ]] m':call search('^---.*', "W")<CR>

setlocal colorcolumn=0
setlocal nospell
"setlocal  fo=lcnjtq

nnoremap <silent><buffer> <Tab> :call search('^+ ', "W") <bar> norm zz <cr>
nnoremap <silent><buffer> <S-Tab> :call search('^+ ', "bW") <bar> norm zz <cr>

""syntax match PlanDone "\v^\* .*"
""hi link PlanDone DiffAdd
"hi PlanDone guifg=#b5cea8
"
""syntax match PlanTodo "\v^\+ .*"
""hi link PlanTodo DiffDelete
"hi PlanTodo guifg=#ce9178
"
""syntax match PlanTag extend containedin=PlanTodo,PlanDone "\v \zs\&[a-zA-Z_0-9]+\ze"
""hi link PlanTag DiffChange
"hi PlanTag guifg=#c586c0
"
""syntax match PlanLog "^  .*$"
"hi link PlanLog NonText
"
"hi link PlanDate Title
