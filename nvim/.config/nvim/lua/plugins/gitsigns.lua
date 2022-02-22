local present, gitsigns = pcall(require, "gitsigns")
if not present then return end

gitsigns.setup {
    signs = {
        add = {
            hl = 'GitSignsAdd',
            text = '┃',
            numhl = 'GitSignsAddNr',
            linehl = 'GitSignsAddLn'
        },
        change = {
            hl = 'GitSignsChange',
            text = '┃',
            numhl = 'GitSignsChangeNr',
            linehl = 'GitSignsChangeLn'
        },
        delete = {
            hl = 'GitSignsDelete',
            text = '┃',
            numhl = 'GitSignsDeleteNr',
            linehl = 'GitSignsDeleteLn'
        },
        topdelete = {
            hl = 'GitSignsDelete',
            text = '┃',
            numhl = 'GitSignsDeleteNr',
            linehl = 'GitSignsDeleteLn'
        },
        changedelete = {
            hl = 'GitSignsChange',
            text = '┃',
            numhl = 'GitSignsChangeNr',
            linehl = 'GitSignsChangeLn'
        }
    },
    numhl = false,
    linehl = false,
    watch_gitdir = {interval = 1000, follow_files = true},
    current_line_blame = true,

    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol',
        delay = 1000
    },
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    word_diff = false,
}

-- Highlight Groups
vim.cmd([[ hi GitSignsCurrentLineBlame guifg = #666666 ]])
vim.cmd([[ hi GitSignsAddLn guifg=Green ]])
vim.cmd([[ hi GitSignsChangeLn guifg=Yellow ]])
vim.cmd([[ hi GitSignsDeleteLn guifg=Red ]])

vim.cmd([[ hi GitSignsChange        guifg=Yellow  ]])
vim.cmd([[ hi GitSignsAdd           guifg=Green  ]])
vim.cmd([[ hi GitSignsDelete        guifg=Red  ]])
vim.cmd([[ hi GitSignsAddInline     guifg=DarkGreen  ]])
vim.cmd([[ hi GitSignsDeleteInline  guifg=DarkRed  ]])
vim.cmd([[ hi GitSignsChangeInline  guifg=DarkYellow  ]])
vim.cmd([[ hi GitSignsAddLnVirtLn   guifg=LightGreen  ]])
vim.cmd([[ hi GitSignsChangeVirtLn  guifg=LightYellow  ]])
vim.cmd([[ hi GitSignsDeleteVirtLn  guifg=LightRed  ]])
