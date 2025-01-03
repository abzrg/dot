local opts = { noremap = true, silent = true }

vim.api.nvim_set_keymap("n", "j", "v:count ? 'j' : 'gj'", { noremap = true, expr = true }) -- Sane line-by-line navigation
vim.api.nvim_set_keymap("n", "k", "v:count ? 'k' : 'gk'", { noremap = true, expr = true }) -- Sane line-by-line navigation
vim.keymap.set("c", "%%", "expand('%:p:h', opts)", { expr = true })                        -- Expand %% to current buffer's directory in ex-mode


vim.keymap.set("n", "-", "<cmd>e %:h<CR>", opts)            -- Open the current directory
vim.keymap.set("n", "cd", "<cmd>silent cd %:p:h<CR>", opts) -- Change to directory of the current file


vim.keymap.set("n", '<BS>', '<cmd>nohl<CR>', opts)    -- Temporarily remove annoying highlighted search item
vim.keymap.set("n", "<leader>q", "<cmd>q!<cr>", opts) -- Exit
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", opts)  -- Save
vim.keymap.set("v", "y", "myy`y", opts)               -- Maintain the cursor position when yanking a visual selection
vim.keymap.set("v", "Y", "myY`y", opts)               --   source: https://youtu.be/434tljD-5C8
vim.keymap.set("n", '<leader>k', '<cmd>bd<CR>', opts) -- Delete the current buffer
vim.keymap.set("c", "***", "**/*", opts)              -- Add *** as **/* on command-line... (src: Darmian Conway)
vim.keymap.set("n", '<leader>u', 'u<C-o>', opts)      -- Sometimes I want to undo without having the cursor moved to have some context
vim.keymap.set("n", '<C-o>', '<C-o>zz', opts)         -- Centric jump backward
vim.keymap.set("n", '<C-i>', '<C-i>zz', opts)         -- Centric jump forward
vim.keymap.set("n", 'J', 'mzJ`z', opts)               -- Stay Where you are when joining lines
vim.keymap.set("x", '<BS>', 'x')                      -- Make BS/DEL work as expected in visual modes (i.e. delete the selected text)...


vim.keymap.set("n", '<right>', '<cmd>cnext<CR>zzzv', opts) -- Quick Fix List mappings + Centered
vim.keymap.set("n", '<left>', '<cmd>cprevious<CR>zzzv', opts)
vim.keymap.set("n", '<down>', '<cmd>cnf<CR>zzzv', opts)
vim.keymap.set("n", '<up>', '<cmd>cpf<CR>zzzv', opts)

vim.keymap.set("n", '<C-d>', '<C-d>zz', opts) -- Center-wise vertical navigation
vim.keymap.set("n", '<C-u>', '<C-u>zz', opts)
vim.keymap.set("n", '<C-f>', '<C-f>zz', opts)
vim.keymap.set("n", '<C-b>', '<C-b>zz', opts)

vim.keymap.set("n", "v", "<C-v>", opts) -- Use the far more useful visual block selection
vim.keymap.set("n", "<C-v>", "v", opts)
vim.keymap.set("v", "v", "<C-V>", opts)
vim.keymap.set("v", "<C-V>", "v", opts)

vim.keymap.set("x", "_", "S_") -- Easily surround stuff in visual mode
vim.keymap.set("x", "'", "S'")
vim.keymap.set("x", "`", "S`")
vim.keymap.set("x", "(", "S(")
vim.keymap.set("x", "[", "S[")
vim.keymap.set("x", "*", "S*") -- Caused me a lot of trouble typing ", as with this mapping in visual/select mode will cause a havoc in snippet expansion
vim.keymap.set("x", '"', 'S"')

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", opts) -- Moving text
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", opts)

vim.keymap.set("n", 'cn', '*``cgn', opts) -- Replace the last change-command with dot
vim.keymap.set("n", 'cN', '*``cgN', opts)

-- Get Dictionary meaning of a word (using sdcv)
if vim.fn.executable("sdcv") and vim.fn.executable("vimdic.sh") == 1 then
	vim.keymap.set('n', '<leader>?', ':!vimdic.sh <C-r><C-w><CR>g', opts)
end

-- Throw away in to the black hole! (now, c doesn't put text into yank register)
vim.keymap.set("n", 'c', '"_c', opts)
vim.keymap.set("n", 'C', '"_C', opts)

-- Stay in visual mode after indenting the selected area
vim.keymap.set("v", '<', '<gv')
vim.keymap.set("v", '>', '>gv')

-- Perform dot commands over visual blocks:
vim.keymap.set("v", '.', '<cmd>normal .<CR>', opts)

-- Spell-check set to <leader>o, 'o' for 'orthography':
vim.keymap.set("n", "<leader>o", "<cmd>setlocal spell!<cr>", { silent = true })

-- Make it executable
vim.keymap.set("n", "<leader>X", "<cmd>!chmod +x %<CR>", { silent = true })

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

-- Disable annoying space behaviour (moving one character forward with delay)
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Correcting spelling mistakes on the fly
-- src: https://castel.dev/post/lecture-notes-1/
vim.keymap.set('i', '<C-l>', '<c-g>u<Esc>[s1z=`]a<c-g>u')

-- Undo break points (Don't Undo the whole thing that is typed in insert mode)
--
-- for the opening bracket: I add the undo-point before inserting the character.
-- This results in what I consider preferable behaviour whereby a whole bracket
-- group is removed at once when undoing, rather than leaving the opening
-- bracket.
-- src: https://jonathanh.co.uk/blog/writing-prose-in-vim/
vim.keymap.set('i', '!', '!<C-g>u', opts)
vim.keymap.set('i', ',', ',<C-g>u', opts)
vim.keymap.set('i', '.', '.<C-g>u', opts)
vim.keymap.set('i', ':', ':<C-g>u', opts)
vim.keymap.set('i', ';', ';<C-g>u', opts)
vim.keymap.set('i', '?', '?<C-g>u', opts)
vim.keymap.set('i', '(', '<C-g>u(', opts)
vim.keymap.set('i', ')', ')<C-g>u', opts)

-- Better history navigation in command mode
vim.cmd [[
  cnoremap <C-N> <Down>
  cnoremap <C-P> <Up>
]]

vim.keymap.set('n', '<space><space>', '<cmd>b#<cr>', opts)
