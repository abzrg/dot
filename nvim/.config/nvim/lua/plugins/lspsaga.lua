local status, lspsaga = pcall(require, "lspsaga")
if (not status) then return end

lspsaga.init_lsp_saga {
  code_action_prompt = { enable = false },
  error_sign = '',
  warn_sign = '',
  hint_sign = '',
  infor_sign = '',
  border_style = "single"
}

lspsaga.setup { -- defaults ...
  debug = false,
  use_saga_diagnostic_sign = true,
  -- diagnostic sign
  error_sign = "",
  warn_sign = "",
  hint_sign = "",
  infor_sign = "",
  diagnostic_header_icon = "   ",
  -- code action title icon
  code_action_icon = " ",
  code_action_prompt = {
    enable = true,
    sign = true,
    sign_priority = 40,
    virtual_text = true,
  },
  finder_definition_icon = "  ",
  finder_reference_icon = "  ",
  max_preview_lines = 10,
  finder_action_keys = {
    open = "o",
    vsplit = "s",
    split = "i",
    quit = "q",
    scroll_down = "<C-f>",
    scroll_up = "<C-b>",
  },
  code_action_keys = {
    quit = "q",
    exec = "<CR>",
  },
  rename_action_keys = {
    quit = "<C-c>",
    exec = "<CR>",
  },
  definition_preview_icon = "  ",
  border_style = "round",
  rename_prompt_prefix = "➤",
  server_filetype_map = {},
  diagnostic_prefix_format = "%d. ",
}

vim.api.nvim_set_keymap('n', '<C-n>', '<Cmd>Lspsaga diagnostic_jump_next<CR>',
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-p>', '<Cmd>Lspsaga diagnostic_jump_prev<CR>',
                        {noremap = true, silent = true})
-- If inside a vim file use K to open help files and not lsp hover
vim.api.nvim_set_keymap('n', 'K', '(&filetype ==# "vim" || &filetype ==# "help") ? "K" : "<Cmd>Lspsaga hover_doc<CR>"',
                        {noremap = true, silent = true, expr = true})
-- vim.api.nvim_set_keymap('i', '<C-k>', '<Cmd>Lspsaga hover_doc<CR>',
--                         {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'gh', '<Cmd>Lspsaga lsp_finder<CR>',
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>ca', ':Lspsaga code_action<CR>',
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '<leader>ca',
                        ':<C-U>Lspsaga range_code_action<CR>',
                        {noremap = true, silent = true})
-- scroll down hover doc or scroll in definition preview
vim.api.nvim_set_keymap('n', '<C-d>',
                        '<cmd>lua require(\'lspsaga.action\').smart_scroll_with_saga(1)<CR>',
                        {noremap = true, silent = true})
-- scroll up hover doc
vim.api.nvim_set_keymap('n', '<C-u>',
                        '<cmd>lua require(\'lspsaga.action\').smart_scroll_with_saga(-1)<CR>',
                        {noremap = true, silent = true})
-- show signature help
vim.api.nvim_set_keymap('n', 'gs', ':Lspsaga signature_help<CR>',
                        {noremap = true, silent = true})
-- close rename win use <C-c> in insert mode or `q` in noremal mode or `:q`
vim.api.nvim_set_keymap('n', '<M-r>', ':Lspsaga rename<CR>',
                        {noremap = true, silent = true})
-- definition peek?
vim.api.nvim_set_keymap('n', '<leader>d', ':Lspsaga preview_definition<CR>',
                        {noremap = true, silent = true})

