-- Check it is installed first
if vim.g.loaded_tmux_navigator ~= 1 then
    return
end

-- [ Custom options ] -----------------------------

-- -- Activate autoupdate on exit
-- vim.g.tmux_navigator_save_on_switch = 1

-- Disable vim->tmux navigation when the Vim pane is zoomed in tmux
--let g:tmux_navigator_disable_when_zoomed = 1

-- If the Vim pane is zoomed, stay zoomed when moving to another tmux pane
vim.g.tmux_navigator_preserve_zoom = 1


-- [ Custom mapping ] -----------------------------------
local nnoremap = require("reverseila.utils.keymap").nnoremap

vim.g.tmux_navigator_no_mappings = 1

nnoremap("<M-h>", ":TmuxNavigateLeft<cr>", {silent = true})
nnoremap("<M-j>", ":TmuxNavigateDown<cr>", {silent = true})
nnoremap("<M-k>", ":TmuxNavigateUp<cr>", {silent = true})
nnoremap("<M-l>", ":TmuxNavigateRight<cr>", {silent = true})
nnoremap("<C-\\>", ":TmuxNavigatePrevious<cr>", {silent = true})

