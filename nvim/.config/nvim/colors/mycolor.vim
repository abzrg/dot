" Vim color file
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last Change:	2001 Jul 23

" This is the default color scheme.  It doesn't define the Normal
" highlighting, it uses whatever the colors used to be.

" Set 'background' back to the default.  The value can't always be estimated
" and is then guessed.
hi clear Normal
set bg&

" Remove all existing highlighting and set the defaults.
hi clear

" Load the syntax highlighting defaults, if it's enabled.
if exists("syntax_on")
  syntax reset
endif

let colors_name = "default"


" TODO 1
" Define a variale for focus mode
" Then do a checking for that and colorize

" TODO 2
" Define colors in  variables
" Look into other themes

" TODO 3
" align words

" TODO 4
" tell tmux to read colors from here

" TODO 5
" simplity the .Xresources


highlight Normal guibg=#181818 guifg=#e4e4ef
highlight LineNr gui=none guifg=#79797D
highlight StatusLineNC gui=italic guifg=#79797D guibg=#252525
highlight StatusLine gui=none guifg=white guibg=#2e2e2e
highlight Visual    gui=None    guibg=#484848
highlight CursorLine  gui=none guibg=#252525
highlight Comment gui=none guifg=#CC8C3C
highlight Search gui=none guibg=#ccA500 guifg=#22272E
highlight IncSearch gui=none guibg=#F47067 guifg=#22272E
highlight Pmenu gui=none guibg=#202124
highlight SignColumn gui=none guibg=none
highlight ColorColumn guibg=#252525
highlight NonText gui=none guifg=#79797D
highlight statement guifg=#FFDD33
highlight Type guifg=#73C936

" vim: sw=2


" #2E3436
" #a40000
" #4E9A06
" #C4A000
" #3465A4
" #75507B
" #ce5c00
" #babdb9
" #555753
" #EF2929
" #8AE234
" #FCE94F
" #729FCF
" #AD7FA8
" #fcaf3e
" #EEEEEC
