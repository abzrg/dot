local telescope = require('telescope')
local actions = require('telescope.actions')

telescope.setup {

    extensions = {
        file_browser = {
            mappings = {
                ["i"] = {
                    -- your custom insert mode mappings
                },
                ["n"] = {
                    -- your custom normal mode mappings
                },
            },
        },
    },
    defaults = {
        theme = "dropdown",
        border = {},
        vimgrep_arguments = {
            "rg", "--color=never", "--no-heading", "--with-filename", "--line-number",
            "--column", "--smart-case", "--hidden"
        },
        prompt_prefix = "> ",
        selection_caret = "> ",
        sorting_strategy = "ascending",
        color_devicons = true,
        layout_config = {
            prompt_position = "top",
            horizontal = {
                width_padding = 0.04,
                height_padding = 0.1,
                preview_width = 0.6
            },
            vertical = {
                width_padding = 0.05,
                height_padding = 1,
                preview_height = 0.5
            }
        },
        mappings = {
            i = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous
                -- ["<Esc>"] = actions.close
            },
            n = {["q"] = actions.close, ["<Esc>"] = actions.close}
        },
        -- borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└"}
    },
    pickers = {
        man_pages = { sections = { "1" } }
    }
}

-- Custom functions (in lua/ali/telescope)
Custom_functions = require('utils.telescope')

-- git_branches
vim.api.nvim_set_keymap("n", "<leader>gb",
[[<Cmd>lua require'telescope.builtin'.git_branches()<CR>]],
{noremap = true, silent = true})

-- git_status - <tab> to toggle staging
-- vim.api.nvim_set_keymap(
--  "n",
--  "gs",
--  [[<Cmd>lua require'telescope.builtin'.git_status()<CR>]],
--  { noremap = true, silent = true }
-- )

-- live-grep
vim.api.nvim_set_keymap('n', ';r', '<Cmd>Telescope live_grep<CR>', {silent = true, noremap = true})

-- Find files (including hidden) with gitfiles & fallback on find_files
vim.api.nvim_set_keymap("n", ";f", [[<Cmd>lua Custom_functions.project_files()<CR>]], {noremap = true, silent = true})

-- buffers
vim.api.nvim_set_keymap('n', '<leader>j', [[<Cmd>lua require'telescope.builtin'.buffers({sort_lastused = true})<CR>]], {noremap = true})

-- help_tags
vim.api.nvim_set_keymap('n', ';;', '<Cmd>Telescope help_tags<CR>', {silent = true, noremap = true})

-- man_pages
vim.api.nvim_set_keymap('n', ';h', '<Cmd>Telescope man_pages<CR>', {silent = true, noremap = true})

-- man_pages section 3 (C++)
vim.api.nvim_set_keymap('n', ';c', '<Cmd>Telescope man_pages sections=3,3<CR>', {silent = true, noremap = true})

-- find_files
vim.api.nvim_set_keymap('n', '<leader>f', '<Cmd>Telescope find_files<CR>', {silent = true, noremap = true})

-- ketmaps
vim.api.nvim_set_keymap("n", ";k", [[<Cmd>lua require'telescope.builtin'.keymaps()<CR>]], {noremap = true, silent = true})

-- marks
-- vim.api.nvim_set_keymap("n", ";m", [[<Cmd>lua require'telescope.builtin'.marks()<CR>]], {noremap = true, silent = true})

-- oldfiles
vim.api.nvim_set_keymap("n", ";o", [[<Cmd>lua Custom_functions.old_files()<CR>]], {noremap = true, silent = true})

-- find notes files
vim.api.nvim_set_keymap("n", "<leader>nf", [[<Cmd>lua Custom_functions.find_notes()<CR>]], {noremap = true, silent = true})

-- browse notes
vim.api.nvim_set_keymap("n", "<leader>nb", [[<Cmd>lua Custom_functions.browse_notes()<CR>]], {noremap = true, silent = true})

-- search through notes
vim.api.nvim_set_keymap("n", "<leader>ng", [[<Cmd>lua Custom_functions.grep_notes()<CR>]], {noremap = true, silent = true})

-- find neovim configs
vim.api.nvim_set_keymap("n", "<leader>vf", [[<Cmd>lua Custom_functions.find_nvim_config()<CR>]], {noremap = true, silent = true})

-- grep neovim configs
vim.api.nvim_set_keymap("n", "<leader>vg", [[<Cmd>lua Custom_functions.grep_nvim_config()<CR>]], {noremap = true, silent = true})

-- find script files
vim.api.nvim_set_keymap('n', ';s', [[<Cmd>lua Custom_functions.find_scripts()<CR>]], {noremap = true, silent = true})

-- find dot files
vim.api.nvim_set_keymap('n', ';d', [[<Cmd>lua Custom_functions.find_dot_files()<CR>]], {noremap = true, silent = true})

