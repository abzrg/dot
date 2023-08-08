-- [ Helper functions ] --------------------------------------
local opts = { noremap = true, silent = true }


-- [ Leader key ] -----------------------------------------

vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'


-- [ Bindings ] --------------------------------------------

-- Temporarily remove annoying highlighted search item
vim.keymap.set("n", '<BS>', '<cmd>nohl<CR>', opts)

-- Exit vim without using :
vim.keymap.set("n", "<leader>q", "<cmd>q!<cr>", opts)
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", opts)

-- Maintain the cursor position when yanking a visual selection
--   source: https://youtu.be/434tljD-5C8
vim.keymap.set("v", "y", "myy`y", opts)
vim.keymap.set("v", "Y", "myY`y", opts)

-- Create new notes (Only if the env NOTES_DIR is set)
local notes_dir = os.getenv("NOTES_DIR")
if notes_dir == nil then
  vim.keymap.set("n", '<leader>nn', '', {
    callback = function()
      print("The env variable 'NOTES_DIR' is not set.")
    end
  })
else
  vim.keymap.set("n", '<leader>nn', ":edit " .. notes_dir .. "<C-d>")
end

-- Create new english notes
vim.keymap.set("n", '<leader>ne', ":edit ~/Git/projects/english/<C-d>")

-- Delete the current buffer
vim.keymap.set("n", '<leader>k', '<cmd>bd<CR>', opts)

-- Add *** as **/* on command-line...
--  source: Darmian Conway
vim.keymap.set("c", "***", "**/*", opts)

-- Open the current directory
vim.keymap.set("n", "-", "<cmd>e %:h<CR>", opts)

-- Expand %% to current buffer's directory in ex-mode
vim.keymap.set("c", "%%", "expand('%:p:h', opts)", { expr = true })

-- Change to directory of the current file
vim.keymap.set("n", "cd", "<cmd>cd %:p:h<CR>:pwd<CR>", opts)

-- Edit init.lua
vim.keymap.set("n", "<leader>e", "<cmd>silent! edit $MYVIMRC <bar> cd %:p:h<CR>:pwd<CR>", opts)

-- -- Enter command mode with leader
-- nmap("<leader>;", ":")
-- vmap("<leader>;", ":")

-- Source current (vim config) file
vim.keymap.set("n", "<leader>s", "<cmd>source %<CR>", opts)

-- -- Let the pinky rest a bit
-- vim.keymap.set("i", "jj", "<Esc>", opts)
-- vim.keymap.set("c", "jj", "<Esc>", opts)

-- Sometimes I want to undo without having the cursor moved to have some context
vim.keymap.set("n", '<leader>u', 'u<C-o>', opts)

-- Centric jump
vim.keymap.set("n", '<C-o>', '<C-o>zz', opts)
vim.keymap.set("n", '<C-i>', '<C-i>zz', opts)

-- Sane line-by-line navigation
vim.keymap.set("n", 'j', 'gj', { silent = true }, opts)
vim.keymap.set("n", 'k', 'gk', { silent = true }, opts)

-- Fix the behavior of `Y`, to be similar to behavior of `C` and `D`
vim.keymap.set("n", 'Y', 'y$')

-- Make the behaviour of arrow key and C-n/p the same
vim.keymap.set("c", '<C-n>', '<Down>', {}, opts)
vim.keymap.set("c", '<C-p>', '<Up>', {}, opts)

-- Use somewhat unused H and L key for going to the begining/end of the line
vim.keymap.set("n", 'H', '0', opts)
vim.keymap.set("n", 'L', '$', opts)

-- Center-wise n and N with absolute direction
--   source: https://superuser.com/a/1430972 + the primeagen
vim.keymap.set("n", 'n', "(v:searchforward ? \'nzzzv\' : \'Nzzzv\')", { expr = true })
vim.keymap.set("n", 'N', "(v:searchforward ? \'Nzzzv\' : \'nzzzv\')", { expr = true })

-- Stay Where you are when joining lines
vim.keymap.set("n", 'J', 'mzJ`z', opts)

-- Quick Fix List mappings + Centered
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", '<right>', '<cmd>cnext<CR>zzzv', opts)
vim.keymap.set("n", '<left>', '<cmd>cprevious<CR>zzzv', opts)
vim.keymap.set("n", '<down>', '<cmd>cnf<CR>zzzv', opts)
vim.keymap.set("n", '<up>', '<cmd>cpf<CR>zzzv', opts)

-- Center-wise vertical navigation
vim.keymap.set("n", '<C-d>', '<C-d>zz', opts)
vim.keymap.set("n", '<C-u>', '<C-u>zz', opts)
vim.keymap.set("n", '<C-f>', '<C-f>zz', opts)
vim.keymap.set("n", '<C-b>', '<C-b>zz', opts)

-- Use the far more useful visual block selection
vim.keymap.set("n", "v", "<C-v>", opts)
vim.keymap.set("n", "<C-v>", "v", opts)
vim.keymap.set("v", "v", "<C-V>", opts)
vim.keymap.set("v", "<C-V>", "v", opts)

-- Make BS/DEL work as expected in visual modes (i.e. delete the selected text)...
vim.keymap.set("x", '<BS>', 'x')

-- Easily surround stuff in visual mode
vim.keymap.set("v", "*", "S*")
vim.keymap.set("v", "_", "S_")
vim.keymap.set("v", "'", "S'")
vim.keymap.set("v", '"', 'S"')
vim.keymap.set("v", "`", "S`")
vim.keymap.set("v", "(", "S(")
vim.keymap.set("v", "[", "S[")

-- Undo break points (Don't Undo the whole thing that is typed in insert mode)
vim.keymap.set("i", ',', ',<C-g>U', opts)
vim.keymap.set("i", '.', '.<C-g>U', opts)
vim.keymap.set("i", '!', '!<C-g>U', opts)
vim.keymap.set("i", '?', '?<C-g>U', opts)

-- Moving text
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", opts)
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", opts)
vim.keymap.set("n", "<A-C-j>", "<esc>:m .+1<CR>==i", opts)
vim.keymap.set("n", "<A-C-j>", "<esc>:m .-2<CR>==i", opts)
vim.keymap.set("n", '<A-C-k>', '<cmd>m .-2<CR>==', opts)
vim.keymap.set("n", '<A-C-j>', '<cmd>m .+1<CR>==', opts)

-- Replace the last change-command with dot
vim.keymap.set("n", 'cn', '*``cgn', opts)
vim.keymap.set("n", 'cN', '*``cgN', opts)

-- Get Dictionary meaning of a word (using sdcv)
if vim.fn.executable("sdcv") and vim.fn.executable("vimdic.sh") == 1 then
  vim.keymap.set('n', '<leader>?', ':!vimdic.sh <C-r><C-w><CR>g', opts)
end

-- Magical search (\v)
vim.keymap.set("n", '/', '/\\v', { noremap = true })

-- Throw away in to the black hole! (now, c doesn't put text into yank register)
vim.keymap.set("n", 'c', '"_c', opts)
vim.keymap.set("n", 'C', '"_C', opts)

-- Stay in visual mode after indenting the selected area
vim.keymap.set("v", '<', '<gv')
vim.keymap.set("v", '>', '>gv')

-- Perform dot commands over visual blocks:
vim.keymap.set("v", '.', '<cmd>normal .<CR>', opts)

-- Spell-check set to <leader>o, 'o' for 'orthography':
vim.keymap.set("n", "<leader>o", "<cmd>setlocal spell! spelllang=en_us<cr>", { silent = true }, opts)

--- -- Save file as sudo on files that require root permission
--- if vim.fn.has('nvim') == 1 then
-- -- cmd(
--     -- [[ cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit! ]])
--- else
-- -- cmd(
--     -- [[ cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit! ]])
--- end

-- Search & Replace (\<\> is word boundary)
vim.keymap.set("n", "S", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")

-- Make it executable
vim.keymap.set("n", "<leader>X", "<cmd>!chmod +x %<CR>", { silent = true })

--- -- Check shell scripts with shell check
--- keymap('', ',s', ':!clear && shellcheck -x %<CR>', {})

-- Zap trailing whitespaces
-- source: wincent
vim.keymap.set("n", "<leader>zz",
  function()
    local pos = vim.fn.getcurpos()
    local search = vim.fn.getreg("/")
    vim.cmd([[keepjumps %substitute/\s\+$//e]])
    vim.fn.setreg("/", search)
    vim.cmd("nohlsearch")
    vim.fn.setpos(".", pos)
  end,
  opts)

vim.keymap.set("n", "gh", "<cmd>TSHighlightCapturesUnderCursor<cr>", {})

-- Disable annoying space behaviour (moving one character forward with delay)
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })


-- toggle between treee condition
--
-- * nu
-- * nu + rnu
-- * nonu + nornu
vim.keymap.set(
  { 'n', 'v' },
  '<leader>N', function()
    if vim.wo.number == true and vim.wo.relativenumber == true then
      vim.wo.number = false
      vim.wo.relativenumber = false
    elseif vim.wo.number == true and vim.wo.relativenumber == false then
      vim.wo.relativenumber = true
    elseif vim.wo.number == false and vim.wo.relativenumber == true then
      vim.wo.relativenumber = false
    else
      vim.wo.number = true
      vim.wo.relativenumber = false
    end
  end,
  {
    silent = true,
    noremap = true
  }
)

-- To turn one line into title caps, make every first letter of a word uppercase
-- src: :help change.txt
vim.keymap.set('n', 'gtt', [[<cmd>:s/\v<(.)(\w*)/\u\1\L\2/g | nohlsearch<cr>]], { noremap = true })


--
vim.keymap.set("n", '<leader>M', "<cmd>Make<cr>", {noremap = true})
vim.keymap.set("n", '<leader>mm', ":set makeprg=", {noremap = true})
