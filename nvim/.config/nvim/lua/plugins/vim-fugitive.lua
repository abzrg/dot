--  FUGITIVE
-- s :: stage
-- U :: unstage
-- :Gcommit :: commit canges
-- :Gpush :: to push the unpushed changes
vim.api.nvim_set_keymap('n', '<leader>gs', ':G<CR>', { noremap = true })

-- Vim Diff:
-- dv :: go to diff mode to resolve conflicts
-- when cursor is on the <<<<<<< HEAD
-- get diff from the right window (b)
vim.api.nvim_set_keymap('n', '<leader>gl', ':diffget //3<CR>', { noremap = true })
-- get diff from the left window (a)
vim.api.nvim_set_keymap('n', '<leader>gh', ':diffget //2<CR>', { noremap = true })
-- do 'CTRL-w O' to jump back after the diff page

vim.api.nvim_set_keymap('n', '<M-g>', ':0G<CR>', { noremap = true })
