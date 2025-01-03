syntax on
filetype plugin indent on
filetype detect

let mapleader = " "

" plugins
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'tpope/vim-sleuth'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'cohama/lexima.vim'
Plug 'farmergreg/vim-lastplace'
Plug 'tpope/vim-dispatch'
Plug 'airblade/vim-gitgutter'
Plug 'machakann/vim-highlightedyank'
Plug 'fatih/vim-go'
Plug 'lervag/vimtex'
Plug 'lifepillar/vim-mucomplete'
call plug#end()

" options
set termguicolors
set bg=dark
set mouse=a
set clipboard=unnamed,unnamedplus
set backspace=2
set nocompatible
set ruler
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
set breakindent
set virtualedit=block
set spellcapcheck=""
set completeopt+=menuone
set completeopt+=noselect
set shortmess+=c
set belloff+=ctrlg
set spelllang=en_gb
set updatetime=100
set nu rnu
set fillchars=eob:\ ,fold:-,
set splitbelow splitright
set timeout timeoutlen=300 ttimeoutlen=50
set incsearch
set ignorecase
set smartcase
set nohlsearch
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
set sidescrolloff=3
set path=**
set path-=./build/
set showbreak=↪\ 
set linebreak
set undofile
set undodir=~/.vim/undo
set grepprg=rg\ --vimgrep\ --smart-case\ --follow


" mapping
nnoremap j gj
nnoremap k gk

nnoremap Y y$

cnoremap <c-p> <up>
cnoremap <c-n> <down>

nnoremap <leader>e :e $MYVIMRC <bar> cd %:h<CR>
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

nnoremap <leader>o :setlocal spell!<CR>
nnoremap <leader>w :w<Cr>
nnoremap <leader>q :q!<Cr>

" Quick access to notes
nnoremap <leader>nn :edit  /Users/ali/Git/projects/notes/<C-d>
nnoremap <leader>ne :edit  /Users/ali/Git/projects/english/<C-d>

" Open recent files with go (if list is too long, and you found your file to
" visit, press q and enter the file number)
nnoremap go :bro ol<cr>

" hooks

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

nnoremap <leader>? :!$HOME/.local/bin/vimdic.sh <C-r><C-w><CR>g

nnoremap <leader>M :Make<cr>
nnoremap <leader>mm :set makeprg=

"set number relativenumber
" Auto toggle of line numbers https://jeffkreeftmeijer.com/vim-number/
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END

function! MyFoldText()
    let nl = v:foldend - v:foldstart + 1
    let comment = substitute(getline(v:foldstart),"^ *","",1)
    let linetext = substitute(getline(v:foldstart+1),"^ *","",1)
    let txt = '+  ' . linetext . comment . ' [' . nl . ']'
    return txt
endfunction
set foldtext=MyFoldText()


" Extend a previous match
nnoremap //   /<C-R>/
nnoremap ///  /<C-R>/\<BAR>
" Match angle brackets...
set matchpairs+=<:>,«:»,｢:｣

" Prevent Lexima from auto-pairing '(' before an alphabetical character
call lexima#add_rule({
      \ 'char': '(',
      \ 'at': '\v\w$',
      \ 'input': '('
      \ })
call lexima#add_rule({
      \ 'char': '{',
      \ 'at': '\v\w$',
      \ 'input': '{'
      \ })
call lexima#add_rule({
      \ 'char': '[',
      \ 'at': '\v\w$',
      \ 'input': '['
      \ })

