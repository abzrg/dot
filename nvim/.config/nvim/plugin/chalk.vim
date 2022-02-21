" Description: A plugin for managing marker folds (specially nested ones) easier

" Options:
let g:chalk_edit = 0        " Disable edit (replace mode after creating fold)
let g:chalk_align = 0       " Disable align
let g:chalk_char = ""       " The character used as padding when aligning markers


" Hooks:
" Files for which to add a space between the marker and the current text
au BufRead,BufNewFile *.txt let b:chalk_space_before = 0


" Mappings:
" Create fold at visual selection
vmap zf <Plug>Chalk
" Create fold at operator movement
nmap zf <Plug>Chalk
" Create fold for specified number of lines
nmap zF <Plug>ChalkRange

" Create single (opening) fold marker at current level or specified count
nmap Zf <Plug>SingleChalk
" Create single (opening) fold marker at next levelor specified count
nmap ZF <Plug>SingleChalkUp


" Increment current fold level
nmap =z <Plug>ChalkUp
" Decrement current fold level
nmap -z <Plug>ChalkDown
" Increment levels in selection
vmap =z <Plug>ChalkUp
" Decrement levels in selection
vmap -z <Plug>ChalkDown
