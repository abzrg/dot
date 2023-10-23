return {

  'christoomey/vim-tmux-navigator',
  config = function()
    -- -- Activate autoupdate on exit
    -- vim.g.tmux_navigator_save_on_switch = 1

    -- Disable vim->tmux navigation when the Vim pane is zoomed in tmux
    vim.g.tmux_navigator_disable_when_zoomed = 1

    -- If the Vim pane is zoomed, stay zoomed when moving to another tmux pane
    vim.g.tmux_navigator_preserve_zoom = 1


    -- [ Custom mapping ] -----------------------------------

    vim.g.tmux_navigator_no_mappings = 1

    vim.keymap.set("", "<C-h>", "<C-h>", { silent = true })
    vim.keymap.set("", "<C-j>", "<C-j>", { silent = true })
    vim.keymap.set("", "<C-k>", "<C-k>", { silent = true })
    vim.keymap.set("", "<C-l>", "<C-l>", { silent = true })
    vim.keymap.set("", "<M-h>", ":TmuxNavigateLeft<cr>", { silent = true })
    vim.keymap.set("", "<M-j>", ":TmuxNavigateDown<cr>", { silent = true })
    vim.keymap.set("", "<M-k>", ":TmuxNavigateUp<cr>", { silent = true })
    vim.keymap.set("", "<M-l>", ":TmuxNavigateRight<cr>", { silent = true })
    vim.keymap.set("", "<C-\\>", ":TmuxNavigatePrevious<cr>", { silent = true })

    -- Intuitive buffer navigation + bufferline plugin
    vim.keymap.set({ "n", "v" }, "<C-h>", "<cmd>bp<cr>", { noremap = true })
    vim.keymap.set({ "n", "v" }, "<C-l>", "<cmd>bn<cr>", { noremap = true })
  end
}
