" Vim color file
" Name: DarkTango iMproved
" Maintainer: Carlo Baldassi <carlobaldassi@gmail.com>
" Version: 0.1
" Notes: based on DarkTango.vim by Panos Laganakos <panos.laganakos@gmail.com>

"if &t_Co != 256 && ! has("gui_running")
  "echomsg ""
  "echomsg "err: please use GUI or a 256-color terminal (so that t_Co=256 could be set)"
  "echomsg ""
  "finish
"endif

set background=dark
if version > 580
	" no guarantees for version 5.8 and below, but this makes it stop
	" complaining
	hi clear
	if exists("syntax_on")
		syntax reset
	endif
endif

let g:colors_name="darktango"

" Default Colors
hi Normal	guibg=#171a1b guifg=#d3d7cf

" {{{ Syntax
hi Comment		guifg=#555753 gui=italic
hi Title		guifg=#eeeeec
hi Underlined		guifg=#8040d0 gui=none
hi Statement		guifg=#888a85
hi Type			guifg=#ce5c00
hi PreProc		guifg=#aeaeec 
hi Constant		guifg=#babd80
hi Identifier		guifg=#ce5c00 
hi Special		guifg=#c07066
hi Ignore		guifg=#f57900
hi Todo			guibg=#ce5c00 guifg=#eeeeec gui=italic
hi String		guifg=#996032
hi SpecialChar		guifg=#ce5c00
hi SpecialKey		guifg=#ce5c00
hi Error		guibg=#500000 guifg=#000000

" this isn't really syntax highlighting
hi MatchParen		guibg=#2f2f2f guifg=#171a1b gui=bold
" }}}

" {{{ Cursor, current line & column
hi Cursor		guibg=#babdb6 guifg=#2e3436
hi CursorIM		guibg=#babd60 guifg=#2e3436
hi CursorColumn		guibg=#212628
hi CursorLine		guibg=#212628
" }}}

" {{{ Window elements & folds
hi StatusLine		guibg=#555753 guifg=#eeeeec gui=none
hi StatusLineNC		guibg=#555753 guifg=#272334 gui=none
hi VertSplit		guibg=#555753 guifg=#2e3436 gui=none
hi Folded		guibg=#171a1b guifg=#605046
hi FoldColumn		guibg=#171a1b guifg=#605046
hi SignColumn		guibg=#171a1b guifg=#605046
hi LineNr		guibg=#171a1b guifg=#605046
hi WildMenu		guibg=#fce94f guifg=#000000
hi Directory		guifg=#abb8c8

hi NonText		guibg=#131516 guifg=#555753
" }}}

" {{{ Messages
hi ErrorMsg		guibg=#ffee00 guifg=#000000 gui=bold
hi WarningMsg		guifg=#f98678
hi ModeMsg		guifg=#ce5c00
hi MoreMsg		guifg=#ce5c00
hi Question		guifg=#aabbcc
" }}}

" {{{ Visual mode
hi Visual		guibg=#fcaf3e guifg=#ce5c00 
hi VisualNOS		guibg=#f0a000 guifg=#555753
" }}}

" {{{ Search
"hi Search		guibg=#fce94f guifg=#a08000
"hi Search		guibg=#554f1b guifg=#a08000
hi Search		guibg=#333333 guifg=#a08000
"hi IncSearch		guibg=#c4a000 guifg=#fce94f gui=none
hi IncSearch		guibg=#816900 guifg=#fce94f gui=none
" }}}

" {{{ Diff mode
hi DiffAdd		guibg=#171a3b
hi DiffChange		guibg=#371a3b
hi DiffDelete		guibg=#272a2b guifg=#000000
hi DiffText		guibg=#502020
" }}}

" {{{ Spell
hi SpellBad		gui=undercurl guisp=#c04020
hi SpellCap		gui=undercurl guisp=#2040c0
hi SpellLocal		gui=undercurl guisp=#40c020
hi SpellRare		gui=undercurl guisp=#a0a020
" }}}

" {{{ Popup Menu
hi Pmenu		guibg=#babdb6 guifg=#555753
hi PmenuSel		guibg=#eeeeec guifg=#2e3436
hi PmenuSbar		guibg=#555753 guifg=#eeac00
hi PmenuThumb		guibg=#555753 guifg=#eeac00
" }}}

" {{{ Graphical elements
"hi Menu
"hi Scrollbar  guibg=grey30 guifg=tan
"hi Tooltip

"hi TabLine
"hi TabLineFill
"hi TabLineSel
" }}}


"  {{{ Terminal
" TODO
" }}}

"vim: sw=4
