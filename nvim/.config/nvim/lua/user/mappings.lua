local keymap = vim.api.nvim_set_keymap
local cmd = vim.cmd

-- Leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

-- Temporarily remove annoying highlighted search item
keymap('n', '<BS>', ':nohl<CR>', {noremap = true})

-- Netrw
-- keymap('n', '<leader>e', ':30Lexplore<CR>', {silent = true}) -- file manager toggle

-- Compiler (mnemonics: m == make)
keymap('n', '<leader>m', ':make!<CR>', {noremap = true})

-- More Convinience!
keymap('n', '<leader>q', ':q!<cr>', {noremap = true})
keymap('n', '<leader>w', ':w<cr>', {noremap = true})
keymap('v', '<M-q>', '<esc>:q!<cr>', {noremap = true})
keymap('n', ';', ':', {noremap = true})
keymap('v', ';', ':', {noremap = true})

-- Insert Current Time/Date (TODO)
cmd([[ inoremap <M-t> <C-r>=strftime('%b %d, %Y (%a)')<cr> ]])
cmd([[ inoremap <M-T> <C-r>=strftime('%D')<cr> ]])

-- Open a terminal in a tab
keymap('n', ',t', ':tabnew <bar> term<CR>i', {noremap = true})

-- Escape terminal mode easier
keymap(
    't', ',<Esc>', '<C-\\><C-n>', {silent = true, noremap = true})

-- Type lang<C-u> for shebang line
keymap('i', '<C-l>',
    '<Esc>:exe ".!which <cWORD>" <bar> s/^/#!/ <bar> filetype detect <bar> nohlsearch <cr>o',
    {noremap = true, silent = true})

-- -- New tab like in browsers
-- keymap('n', '<C-t>', ':tabnew<cr>', {noremap = true})

-- Maintain the cursor position when yanking a visual selection
-- source: https://youtu.be/434tljD-5C8
keymap('v', 'y', 'myy`y', {noremap = true})
keymap('v', 'Y', 'myY`y', {noremap = true})

-- Open the current file in the default program (useful for html files)
-- source: https://youtu.be/434tljD-5C8
keymap('n', '<leader>x', ':!xdg-open %<CR><CR>', {noremap = true})

-- Indent the whole file from where you are
keymap('n', '<M-i>', [[m`gg=G``zz]], {noremap = true})

-- Notes
keymap('n', '<leader>nn', ':edit ~/Documents/notes/<C-d>', {noremap = true})

-- Delete current buffer
keymap('n', '<leader>k', ':bd<CR>', {noremap = true})

-- Make script executable
keymap('n', '<leader>\\',
    ':silent! exe \'!chmod 755 %\' <bar> redraw <bar> echomsg "Converted to an executable"<cr>',
    {silent = true, noremap = true})

-- toggle last buffer
cmd([[ nnoremap ''  :b#<cr>zz ]])

-- Shift-Tab in visual mode to number lines... (source: Damian Conway)
cmd([[xnoremap <S-TAB> :s/\%V/0<C-V><TAB>/<CR>gvg<C-A>gv:retab<ESC>gvI<C-G>u<ESC>gv/ <CR>:s/\%V /./<CR>:nohl<CR>]])

-- Add *** as **/* on command-line... (source: Darmian Conway)
cmd([[cnoremap *** **/*]])

-- Open the current directory
keymap('n', '-', ':e %:h<CR>', {noremap = true})
cmd([[ cabbr <expr> %% expand('%:p:h') ]])

-- CD = Change to directory of the current file
keymap('n', 'cd', ':cd %:p:h<CR>:pwd<CR>', {noremap = true})

-- Easier navigaton between buffers
keymap('n', '<M-b>', ':bp<CR>', {noremap = true})
keymap('n', '<M-n>', ':bn<CR>', {noremap = true})

cmd([[nnoremap <Leader>b :buffers<CR>:buffer<Space>]])

-- Edit and source this file from anywhere
keymap('n', '<leader>e', ':e $MYVIMRC <bar> cd %:p:h<CR>:pwd<CR>', {noremap = true})

-- Source current vim script
keymap('n', '<leader>s', ':source %<CR>', {noremap = true})

-- Sometimes I want to undo without having the cursor moved to have some context
keymap('n', '<leader>u', 'u<C-o>', {noremap = true})

-- Jumplist
keymap('n', '<C-o>', '<C-o>zz', {noremap = true, silent = true})
keymap('n', '<C-i>', '<C-i>zz', {noremap = true, silent = true})

-- Switch quickly between the .h and corresponding .c/.cpp file
keymap('n', '<M-Tab>', ':e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>', {noremap = true, silent = true})

-- Add space bellow or above without leaving normal mode
keymap('n', '[<space>', ':<c-u>put!=repeat([\'\'],v:count)<bar>\']+1<cr>', {silent = true, noremap = true})
keymap('n', ']<space>', ':<c-u>put =repeat([\'\'],v:count)<bar>\'[-1<cr>', {silent = true, noremap = true})

-- Better vertical line-by-line navigation
keymap('n', 'j', 'gj', {silent=true})
keymap('n', 'k', 'gk', {silent=true})

-- Fix the behavior of `Y`, to be similar to behavior of `C` and `D`
keymap('n', 'Y', 'y$', {})

-- Make the behaviour of arrow key and C-n/p the same
keymap('c', '<C-n>', 'wildmenumode() ? "\\<c-n>" : "\\<down>"', {noremap = true, expr = true})
keymap('c', '<C-p>', 'wildmenumode() ? "\\<c-p>" : "\\<up>"', {noremap = true, expr = true})

-- Use somewhat unused H and L key for going to the begining/end of the line
keymap('n', 'H', '0', {noremap = true})
keymap('n', 'L', '$', {noremap = true})

-- Keep it centered + make n and N's direction absolute -- source: https://superuser.com/a/1430972 + primeagen
keymap('n', 'n', '(v:searchforward ? \'nzzzv\' : \'Nzzzv\')', {expr = true, noremap = true})
keymap('n', 'N', '(v:searchforward ? \'Nzzzv\' : \'nzzzv\')', {expr = true, noremap = true})
keymap('n', 'J', 'mzJ`z', {noremap = true})

-- Quick Fix List mappings + Centered
keymap('n', '<right>', ':cnext<CR>zzzv', {noremap = true})
keymap('n', '<left>', ':cprevious<CR>zzzv', {noremap = true})
keymap('n', '<down>', ':cnf<CR>zzzv', {noremap = true})
keymap('n', '<up>', ':cpf<CR>zzzv', {noremap = true})
keymap('n', '<A-q>', ':Copen<CR>', {noremap = true})

-- Center vertical navigation
keymap('n', '<C-d>', '<C-d>zz', {noremap = true})
keymap('n', '<C-u>', '<C-u>zz', {noremap = true})
keymap('n', '<C-f>', '<C-f>zz', {noremap = true})
keymap('n', '<C-b>', '<C-b>zz', {noremap = true})

-- C style comment with pressing Ctrl-/
keymap('i', '<C-_>', '/**/<Left><Left>', {noremap = true})

-- Use the far more useful visual block selection
keymap('n', 'v', '<C-v>', {noremap = true})
keymap('n', '<C-v>', 'v', {noremap = true})
keymap('x', 'v', '<C-V>', {noremap = true})
keymap('x', '<C-V>', 'v', {noremap = true})
-- Make BS/DEL work as expected in visual modes (i.e. delete the selected text)...
keymap('x', '<BS>', 'x', {})
-- Make vaa select the entire file...
keymap('x', 'aa', 'VGo1G', {})

-- Comment (C-style) visually selected area
-- ref: https://vi.stackexchange.com/a/18170/30665
keymap('x', '#', 's/* <c-r>" */<esc>', {noremap = true})

-- Easily surround stuff in visual mode
keymap('v', '*', 'S*', {})
keymap('v', '_', 'S_', {})
keymap('v', '\'', 'S\'', {})
keymap('v', '"', 'S"', {})
keymap('v', '`', 'S`', {})
keymap('v', '(', 'S(', {})
keymap('v', '[', 'S[', {})
keymap('x', '``', ':s/\\V\\v(.*)/```\\r\\1\\r```/ | nohl<CR>', {}) -- add markdown's codeblock triple backtics

-- Undo break points (What is this?)
keymap('i', ',', ',<C-g>U', {noremap = true})
keymap('i', '.', '.<C-g>U', {noremap = true})
keymap('i', '!', '!<C-g>U', {noremap = true})
keymap('i', '?', '?<C-g>U', {noremap = true})

-- Moving text
keymap('v', 'J', ':m \'>+1<CR>gv=gv', {noremap = true})
keymap('v', 'K', ':m \'<-2<CR>gv=gv', {noremap = true})
keymap('i', '<A-C-j>', '<esc>:m .+1<CR>==a', {noremap = true})
keymap('i', '<A-C-k>', '<esc>:m .-2<CR>==a', {noremap = true})
keymap('n', '<A-C-k>', ':m .-2<CR>==', {noremap = true})
keymap('n', '<A-C-j>', ':m .+1<CR>==', {noremap = true})

-- Duplicate code
keymap('x', 'g<A-S-j>', ':t\'> <Bar> norm \'[O<Esc>', {noremap = true})
keymap('x', 'g<A-S-k>', ':t\'> <Bar> norm \'[O<Esc>', {noremap = true})
keymap('x', '<A-S-j>', ':t\'> <Bar> norm \'[<CR>', {noremap = true})
keymap('x', '<A-S-k>', ':t\'> <Bar> norm \'[<CR>', {noremap = true})

keymap('n', 'g<A-S-j>', ':t\'> <Bar> norm \'[O<Esc>', {noremap = true})
keymap('n', 'g<A-S-k>', ':t\'> <Bar> norm \'[O<Esc>', {noremap = true})
keymap('n', '<A-S-j>', ':t\'> <Bar> norm \'[<CR>', {noremap = true})
keymap('n', '<A-S-k>', ':t\'> <Bar> norm \'[<CR>', {noremap = true})

-- Search and replace with dot
keymap('n', 'cn', '*``cgn', {noremap = true})
keymap('n', 'cN', '*``cgN', {noremap = true})

-- Access to the meaning of the word via sdcv
keymap('n', ',w', 'yiw <bar> :!vimdic.sh<CR>g', {})

-- Easier regex search
-- keymap('n', '/', '/\\v', {noremap = true})

-- mark position before search (Get back where you were with 's)
keymap('n', '/', 'mszv/\\v', {noremap = true})

-- Throw away in to the black hole! (now, c does'nt put text into yank register)
keymap('n', 'c', '"_c', {noremap = true})
keymap('n', 'C', '"_C', {noremap = true})

-- Stay in visual mode after indenting the selected area
keymap('v', '<', '<gv', {})
keymap('v', '>', '>gv', {})

-- Perform dot commands over visual blocks:
keymap('v', '.', ':normal .<CR>', {noremap = true})

-- Spell-check set to <leader>o, 'o' for 'orthography':
keymap('n', '<leader>o',
                        ':setlocal spell! spelllang=en_us<CR>', {noremap=true, silent=true})

-- Save file as sudo on files that require root permission
if vim.fn.has('nvim') == 1 then
  cmd(
      [[ cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit! ]])
else
  cmd(
      [[ cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit! ]])
end

-- Search & Replace (\<\> is word boundary)
-- keymap('n', 'S', 'yiw:%s///g<Left><Left><Left><C-r>"<Right>',
--                         {noremap = true})
keymap('n', 'S', ':%s///g<Left><Left><Left><C-r><C-w><Right>', {noremap = true})

-- Search in visually selected area
keymap('v', '/', '<Esc>/\\%V', {noremap = true})

-- Get rid of accidental jump to ex mode and easily wrap text
keymap('', 'Q', 'gq', {})

-- Check shell scripts with shell check
keymap('', ',s', ':!clear && shellcheck -x %<CR>', {})

-- Compile document, be it groff/LaTeX/markdown/etc.
keymap('', ',c', ':w! \\| !compiler "<c-r>%"<CR>', {})

-- Open corresponding .pdf/.html or preview
keymap('', ',p', ':!opout <c-r>%<CR><CR>', {})

-- Toggle numbering
cmd([[

function! ToggleNumber()
  if &number == '1' && &relativenumber == '1'
    set rnu! nu!
    echo "Number and relative number disabled"
  elseif &number == '1' && &relativenumber == '0'
    set nu!
    echo "Number disabled"
  else
    set nu! rnu!
    echo "Number and relative number enabled"
  endif
endfunction
nnoremap <F9> :call ToggleNumber()<CR>

]])

-- Toggle syntax highlighting
cmd([[

map <silent> <F7> :if exists("g:syntax_on") \| syntax off <CR> else \| syntax enable \| endif <CR>

]])

-- Zap trailing whitespaces
--     source: wincent
cmd([[

function! Zap_trailing_white_space() abort
let l:pos=getcurpos()
let l:search=@/
keepjumps %substitute/\s\+$//e
let @/=l:search
nohlsearch
call setpos('.', l:pos)
endfunction

nnoremap <silent> <leader>zz :call Zap_trailing_white_space()<CR>

]])
