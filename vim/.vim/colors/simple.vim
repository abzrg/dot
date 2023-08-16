set termguicolors
set background=dark
highlight clear
if exists("syntax_on")
    syntax reset
endif

set termguicolors
" let colors_name = "comment"


" First set Normal to regular white on black text colors:
hi Normal     guifg=#c8cacd guibg=#202124 gui=None
hi Normal     guifg=#c8cacd guibg=#171717 gui=None
" hi Normal     guifg=#c8cacd

" Syntax highlighting (other color-groups using default, see :help group-name):
hi Comment    gui=NONE guifg=#666666
hi Constant   gui=NONE guifg=#c8cacd
hi Identifier gui=NONE guifg=#c8cacd
hi Function   gui=NONE guifg=#c8cacd
hi Statement  gui=NONE guifg=#c8cacd
hi PreProc    gui=NONE guifg=#c8cacd
hi Type       gui=NONE guifg=#c8cacd
hi Special    gui=NONE guifg=#c8cacd
hi Delimiter  gui=NONE guifg=#c8cacd

hi LineNr     gui=None guifg=#555555
hi NonText    gui=None guifg=#555555

hi cursorlineNr cterm=None gui=none guibg=#111111 guifg=#f1bf42 
hi Cursorline   gui=None cterm=None  guibg=#1e1e1e
hi Cursorcolumn   gui=None cterm=None  guibg=#282828

hi SpecialKey   gui=None guifg=#555555

hi Visual       gui=None guibg=#343538
hi IncSearch    gui=none    guibg=black guifg=#D85140
hi Search      gui=none cterm=none guibg=#f1bf42 guifg=black

hi Pmenu        cterm=none gui=none  guifg=#c8cacd guibg=#272727
hi PmenuSel     cterm=none gui=none  guifg=#171717 guibg=#f1bf42
