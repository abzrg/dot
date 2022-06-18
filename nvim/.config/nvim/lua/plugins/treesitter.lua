local status = pcall(require, "nvim-treesitter")
if (not status) then
    return
end

require('nvim-treesitter.configs').setup {
    highlight = {
        enable = true,
        disable = {"bash", "make", "html", "vim", "tex", "latex", "yaml", "markdown"},
    },
    indent = {
        enable = false,
        -- disable = {"c","bash","cpp"},
        disable = {"bash"},
    },
    ensure_installed = {'c', 'cpp', 'lua', 'json', 'yaml'},
    ignore_install = { "jsonc", "d" },
    playground = {
        enable = true,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false, -- Whether the query persists across vim sessions
        keybindings = {
            toggle_query_editor = 'o',
            toggle_hl_groups = 'i',
            toggle_injected_languages = 't',
            toggle_anonymous_nodes = 'a',
            toggle_language_display = 'I',
            focus_language = 'f',
            unfocus_language = 'F',
            update = 'R',
            goto_node = '<cr>',
            show_help = '?',
        },
    },
    endwise = {
        enable = true,
    },
}
