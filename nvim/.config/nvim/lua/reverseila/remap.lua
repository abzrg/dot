-- [ Helper functions ] --------------------------------------
local nmap = require("reverseila.utils.keymap").nmap
local vmap = require("reverseila.utils.keymap").vmap
local xmap = require("reverseila.utils.keymap").xmap
local imap = require("reverseila.utils.keymap").imap
local cmap = require("reverseila.utils.keymap").cmap

local nnoremap = require("reverseila.utils.keymap").nnoremap
local vnoremap = require("reverseila.utils.keymap").vnoremap
local xnoremap = require("reverseila.utils.keymap").xnoremap
local inoremap = require("reverseila.utils.keymap").inoremap
local cnoremap = require("reverseila.utils.keymap").cnoremap

local cmd = vim.cmd


-- [ Leader key ] -----------------------------------------

vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'


-- [ Bindings ] --------------------------------------------

-- Temporarily remove annoying highlighted search item
nnoremap('<BS>', '<cmd>nohl<CR>')

-- Exit vim without using :
nnoremap("<leader>q", "<cmd>q!<cr>")
nnoremap("<leader>w", "<cmd>w<cr>")

-- Maintain the cursor position when yanking a visual selection
--   source: https://youtu.be/434tljD-5C8
vnoremap("y", "myy`y")
vnoremap("Y", "myY`y")

-- Create new notes (Only if the env NOTES_DIR is set)
local notes_dir = os.getenv("NOTES_DIR")
if notes_dir == nil then
    nnoremap('<leader>nn', '', {callback = function()
        print("The env variable 'NOTES_DIR' is not set.")
    end})
else
    nnoremap('<leader>nn', ":edit " .. notes_dir .. "/<C-d>")
end

-- Delete the current buffer
nnoremap('<leader>k', '<cmd>bd<CR>')

-- Add *** as **/* on command-line...
--  source: Darmian Conway
cnoremap("***", "**/*")

-- Open the current directory
nnoremap("-", "<cmd>e %:h<CR>")

-- Expand %% to current buffer's directory in ex-mode
cnoremap("%%", "expand('%:p:h')", {expr = true})

-- Change to directory of the current file
nnoremap("cd", "<cmd>cd %:p:h<CR>:pwd<CR>")

-- Edit init.lua
nnoremap("<leader>e", "<cmd>edit $MYVIMRC <bar> cd %:p:h<CR>:pwd<CR>")

-- Source current (vim config) file
nnoremap("<leader>s", "<cmd>source %<CR>")

-- Let the pinky rest a bit
inoremap("jj", "<Esc>")
cnoremap("jj", "<Esc>")

-- Sometimes I want to undo without having the cursor moved to have some context
nnoremap('<leader>u', 'u<C-o>')

-- Centric jump
nnoremap('<C-o>', '<C-o>zz')
nnoremap('<C-i>', '<C-i>zz')

-- Sane line-by-line navigation
nnoremap('j', 'gj')
nnoremap('k', 'gk')

-- Fix the behavior of `Y`, to be similar to behavior of `C` and `D`
nmap('Y', 'y$')

-- Make the behaviour of arrow key and C-n/p the same
cnoremap('<C-n>', 'wildmenumode() ? "\\<c-n>" : "\\<down>"', {expr = true})
cnoremap('<C-p>', 'wildmenumode() ? "\\<c-p>" : "\\<up>"', {expr = true})

-- Use somewhat unused H and L key for going to the begining/end of the line
nnoremap('H', '0')
nnoremap('L', '$')

-- Center-wise n and N with absolute direction
--   source: https://superuser.com/a/1430972 + the primeagen
nnoremap('n', "(v:searchforward ? \'nzzzv\' : \'Nzzzv\')", {expr = true})
nnoremap('N', "(v:searchforward ? \'Nzzzv\' : \'nzzzv\')", {expr = true})

-- Stay Where you are when joining lines
nnoremap('J', 'mzJ`z')

-- Quick Fix List mappings + Centered
nnoremap('<right>', '<cmd>cnext<CR>zzzv')
nnoremap('<left>', '<cmd>cprevious<CR>zzzv')
nnoremap('<down>', '<cmd>cnf<CR>zzzv')
nnoremap('<up>', '<cmd>cpf<CR>zzzv')

-- Center-wise vertical navigation
nnoremap('<C-d>', '<C-d>zz')
nnoremap('<C-u>', '<C-u>zz')
nnoremap('<C-f>', '<C-f>zz')
nnoremap('<C-b>', '<C-b>zz')

-- Use the far more useful visual block selection
nnoremap("v", "<C-v>")
nnoremap("<C-v>", "v")
vnoremap("v", "<C-V>")
vnoremap("<C-V>", "v")

-- Make BS/DEL work as expected in visual modes (i.e. delete the selected text)...
xmap('<BS>', 'x')

-- Easily surround stuff in visual mode
vmap("*", "S*")
vmap("_", "S_")
vmap("'", "S'")
vmap('"', 'S"')
vmap("`", "S`")
vmap("(", "S(")
vmap("[", "S[")

-- Undo break points (Don't Undo the whole thing that is typed in insert mode)
inoremap(',', ',<C-g>U')
inoremap('.', '.<C-g>U')
inoremap('!', '!<C-g>U')
inoremap('?', '?<C-g>U')

-- Moving text
vnoremap('J', '<cmd>m \'>+1<CR>gv=gv')
vnoremap('K', '<cmd>m \'<-2<CR>gv=gv')
inoremap('<A-C-j>', '<esc>:m .+1<CR>==a')
inoremap('<A-C-k>', '<esc>:m .-2<CR>==a')
nnoremap('<A-C-k>', '<cmd>m .-2<CR>==')
nnoremap('<A-C-j>', '<cmd>m .+1<CR>==')

-- Replace the last change-command with dot
nnoremap('cn', '*``cgn')
nnoremap('cN', '*``cgN')

-- Get Dictionary meaning of a word (using sdcv)
if vim.fn.executable("sdcv") and vim.fn.executable("vimdic.sh") == 1 then
    nmap('<leader>?', ':!vimdic.sh <C-r><C-w><CR>g')
end

-- Magical search (\v)
nnoremap('/', '/\\v')

-- Throw away in to the black hole! (now, c doesn't put text into yank register)
nnoremap('c', '"_c')
nnoremap('C', '"_C')

-- Stay in visual mode after indenting the selected area
vmap('<', '<gv')
vmap('>', '>gv')

-- Perform dot commands over visual blocks:
vnoremap('.', '<cmd>normal .<CR>')

-- Spell-check set to <leader>o, 'o' for 'orthography':
nnoremap('<leader>o', '<cmd>setlocal spell! spelllang=en_us<CR>', {silent=true})

--- -- Save file as sudo on files that require root permission
--- if vim.fn.has('nvim') == 1 then
-- -- cmd(
--     -- [[ cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit! ]])
--- else
-- -- cmd(
--     -- [[ cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit! ]])
--- end
--- 
--- -- Search & Replace (\<\> is word boundary)
--- -- keymap('n', 'S', 'yiw:%s///g<Left><Left><Left><C-r>"<Right>',
--- --                         {noremap = true})
--- keymap('n', 'S', ':%s///g<Left><Left><Left><C-r><C-w><Right>', {noremap = true})
--- 
--- -- Search in visually selected area
--- keymap('v', '/', '<Esc>/\\%V', {noremap = true})
--- 
--- -- Get rid of accidental jump to ex mode and easily wrap text
--- keymap('', 'Q', 'gq', {})
--- 
--- -- Check shell scripts with shell check
--- keymap('', ',s', ':!clear && shellcheck -x %<CR>', {})
--- 
--- -- Compile document, be it groff/LaTeX/markdown/etc.
--- keymap('', ',c', ':w! \\| !compiler "<c-r>%"<CR>', {})
--- 
--- -- Open corresponding .pdf/.html or preview
--- keymap('', ',p', ':!opout <c-r>%<CR><CR>', {})
--- 
--- -- Toggle numbering
--- cmd([[
--- 
--- function! ToggleNumber()
-- -- if &number == '1' && &relativenumber == '1'
--   -- set rnu! nu!
--   -- echo "Number and relative number disabled"
-- -- elseif &number == '1' && &relativenumber == '0'
--   -- set nu!
--   -- echo "Number disabled"
-- -- else
--   -- set nu! rnu!
--   -- echo "Number and relative number enabled"
-- -- endif
--- endfunction
--- nnoremap <F9> :call ToggleNumber()<CR>
--- 
--- ]])
--- 
--- -- Toggle syntax highlighting
--- cmd([[
--- 
--- map <silent> <F7> :if exists("g:syntax_on") \| syntax off <CR> else \| syntax enable \| endif <CR>
--- 
--- ]])
--- 
--- -- Zap trailing whitespaces
--- --     source: wincent
--- cmd([[
--- 
--- function! Zap_trailing_white_space() abort
--- let l:pos=getcurpos()
--- let l:search=@/
--- keepjumps %substitute/\s\+$//e
--- let @/=l:search
--- nohlsearch
--- call setpos('.', l:pos)
--- endfunction
--- 
--- nnoremap <silent> <leader>zz :call Zap_trailing_white_space()<CR>
--- 
--- ]])
