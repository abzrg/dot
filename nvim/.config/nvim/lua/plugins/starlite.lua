vim.api.nvim_set_keymap('n', '*', ':lua require\'starlite\'.star()<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'g*', ':lua require\'starlite\'.g_star()<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '#', ':lua require\'starlite\'.hash()<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'g#', ':lua require\'starlite\'.g_hash()<cr>', { noremap = true, silent = true })
