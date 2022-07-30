-- Check it is installed first
local status_ok = pcall(require, "nvim-treesitter")
if not status_ok then
    return
end

-- Setup
require('nvim-treesitter.configs').setup {
    highlight = {
        enable = true,
        -- disable = { "bash", "make", "html", "vim", "tex", "latex", "yaml" },
    },

    indent = {
        enable = false,  -- Affects = command?
        -- disable = { "bash" },
    },

    -- List of languages
    ensure_installed = {
        "c",
        "cpp",
        "cmake",
        "json",
        "yaml",
        "foam",
        "latex",
        "bibtex",
        "html",
        "css",
        "javascript",
        "python",
        "lua",
        "rust",
        "go",
        "perl",
        "fortran",
    },

    -- Playground config
    playground = {
        enable = true,
        disable = {},
        updatetime = 25,  -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false,  -- Whether the query persists across vim sessions
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

    -- Plugins
    endwise = {
        enable = true,
    },
}
