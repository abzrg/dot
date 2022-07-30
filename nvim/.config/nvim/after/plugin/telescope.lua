-- Check it is installed
local status_ok, telescope = pcall(require, "telescope")
if (not status_ok) then
    return
end

local actions = require('telescope.actions')

-- Setup
telescope.setup {
    extensions = {
        file_browser = {},
    },

    defaults = {
        -- UI
        theme = "dropdown",
        border = {},
        prompt_prefix = "> ",
        selection_caret = "> ",
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

        -- Vimgrep using ripgrep
        vimgrep_arguments = {
            "rg", "--color=never", "--no-heading", "--with-filename", "--line-number",
            "--column", "--smart-case", "--hidden"
        },

        -- Sort strategy
        sorting_strategy = "ascending",

        -- Mappings
        mappings = {
            i = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous
            },
            n = {["q"] = actions.close, ["<Esc>"] = actions.close}
        },
    },
    pickers = {
        man_pages = { sections = { "1" } }
    }
}


-- [ Mappings ] -----------------------------------------------

-- Helper function
local nnoremap = require("reverseila.utils.keymap").nnoremap

-- Live Grep
nnoremap('<leader>rg', "<Cmd>Telescope live_grep<CR>", {silent = true, noremap = true})

-- Buffers (last used sorted first)
nnoremap('<leader>b', "<Cmd>lua require'telescope.builtin'.buffers({sort_lastused = true})<CR>")

-- Help tags
nnoremap('<leader>h', "<Cmd>Telescope help_tags<CR>")

-- Man pages
nnoremap('<leader>tm', "<Cmd>Telescope man_pages<CR>")
-- vim.api.nvim_set_keymap('n', '<leader>tm', '<Cmd>Telescope man_pages sections=3,3<CR>', {silent = true, noremap = true})

-- Ketmaps
nnoremap("<leader>tk", "<Cmd>Telescope keymaps<CR>")

-- Oldfiles
nnoremap("<leader>to", "<Cmd>Telescope oldfiles<CR>")


-- [ Custom functions ] ---------------------------------------

-- Find files (including hidden) with gitfiles & fallback to find_files
nnoremap("<leader>f", "<Cmd>lua require('reverseila.utils.telescope').project_files()<CR>")

-- Find notes files
nnoremap("<leader>nf", "<Cmd>lua require('reverseila.utils.telescope').find_notes()<CR>")

-- Search through notes
nnoremap("<leader>ng", "<Cmd>lua require('reverseila.utils.telescope').grep_notes()<CR>")

-- Find script files
nnoremap('<leader>ts', "<Cmd>lua require('reverseila.utils.telescope').find_scripts()<CR>")
