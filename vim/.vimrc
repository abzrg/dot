syntax on
filetype plugin indent on
filetype detect

let mapleader = " "

" " -- color
" set notermguicolors
" " hi Visual ctermbg=13 ctermfg=darkgray
" " hi! link SpecialKey NonText
" set bg=light
" hi IncSearch      term=reverse cterm=reverse gui=reverse
" hi Search         term=reverse ctermfg=0 ctermbg=11 guifg=Black guibg=Yellow
" hi Visual         term=reverse ctermbg=242 guibg=DarkGrey
" hi Pmenu          ctermfg=gray ctermbg=black
" hi PmenuSel       ctermfg=blue ctermbg=yellow
" hi LineNr         ctermfg=darkgray


" set termguicolors
" colo gruber-darker
" hi Cursorline guibg=#282828
" hi CursorlineNr gui=None cterm=None
" hi LineNr guifg=#52494e

colo simple

" -- options
"syntax on
set clipboard=unnamed,unnamedplus
set backspace=2
set nocompatible
set ruler
" set rulerformat=%t%{FugitiveStatusline()}%=%y%r\ [%3l,%3c%V]\ [%P]
" set statusline=%t\ %y\ %m\ %r%=%{FugitiveStatusline()}%=\ [%3l,%3c%V]\ [%P]
set modeline
set modelines=4
set title
set hidden
set noshowcmd
set noshowmode
set autoread
set noswapfile
set nobackup
set mouse=a
set cursorline
set nowrap
set virtualedit=block
set spellcapcheck=""
set completeopt+=menuone
set completeopt+=noselect
set completeopt+=noinsert
set shortmess+=c   " Shut off completion messages
set belloff+=ctrlg " Add only if Vim beeps during completion

set nu rnu

" set fillchars=eob:\ ,fold:-,

set splitbelow splitright

set timeoutlen=1000
set ttimeoutlen=50

set incsearch
set ignorecase
set smartcase
set hlsearch
set laststatus=0

set tw=80

set autoindent
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab

set list
set listchars=tab:▸\ ,trail:•,nbsp:+

set tags=tags;$HOME
set tags+=.tags;$HOME

set wildignore+=*.git/*,*.tags,tags,*.o,*.class,**/.vim/pack/**,**/.vim/undo/**,*.egg-info/**,*venv/**,*dist/**,*build/*
set wildignorecase
set wildmenu
set wildmode=longest,list,full
set wildchar=9
set wildcharm=26

set scrolloff=3
" set sidescroll=1
set sidescrolloff=3

set path=**
set path-=./build/

set showbreak=↪\ 
set linebreak

" better and safer undo
set undofile
set undodir=~/.vim/undo

" fzf
set rtp+=/opt/homebrew/opt/fzf


" -- mapping

nnoremap <leader>e :e <C-d>
nnoremap <leader>f :find 

nnoremap j gj
nnoremap k gk

nnoremap Y y$

cnoremap <c-p> <up>
cnoremap <c-n> <down>

nnoremap <leader>v :e $MYVIMRC <bar> cd %:h<CR>
nnoremap <leader>s :source %<CR>

nnoremap <leader>k :bd<CR>

nnoremap v <C-v>
nnoremap <C-v> v

vnoremap > >gv
vnoremap < <gv

nnoremap <BS> :nohls<CR>

" reselect the pasted text
nnoremap gp `[v`]

" Remaps / search key to use standard regex instead of vim regex nnoremap / /\v
vnoremap / /\v

nnoremap cd :cd %:h <bar> pwd<CR>

map Q gq

nnoremap H 0
nnoremap L $

nnoremap c "_c
nnoremap C "_C

nnoremap <leader>; :

nnoremap <leader>o :setlocal spell! spelllang=en_us<CR>
nnoremap <leader>w :w<Cr>
nnoremap <leader>q :q!<Cr>

" Quick access to notes
nnoremap <leader>nn :edit  /Users/ali/Git/projects/notes/<C-d>
nnoremap <leader>ne :edit  /Users/ali/Git/projects/english/<C-d>

" Open recent files with go (if list is too long, and you found your file to
" visit, press q and enter the file number)
nnoremap go :bro ol<cr>

" -- hooks

" Disable auto insertion of comment and friend
augroup FormatOptions
au!
    autocmd BufNewFile,BufRead * setlocal formatoptions-=crot
augroup END


" Fix formatting options
augroup auto_comment
au!
    au FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o formatoptions-=t
augroup END


" Zap trailing whitespaces (Don't zap this file)
function! Zap_trailing_white_space() abort
let l:pos=getcurpos()
let l:search=@/
keepjumps %substitute/\s\+$//e
let @/=l:search
nohlsearch
call setpos('.', l:pos)
endfunction

nnoremap <silent> <leader>zz :call Zap_trailing_white_space()<CR>

" Disable annoying space behaviour (moving one character forward with delay)
nmap <silent> <SPACE> <NOP>
vmap <silent> <SPACE> <NOP>

" format code in insert mode
" inoremap <silent>  <C-o>gqq<C-o>A

nnoremap - :e %:h<CR>

nnoremap <leader>? :!$HOME/.local/bin/vimdic.sh\ <C-r><C-w><CR>g

nnoremap <leader>M :Make<cr>
nnoremap <leader>mm :set makeprg=

command -nargs=1 Vfind vsplit | find <args>
