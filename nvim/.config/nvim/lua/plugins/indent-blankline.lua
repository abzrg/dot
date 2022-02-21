local status_ok, indent_blankline = pcall(require, "indent_blankline")
if not status_ok then
	return
end

indent_blankline.setup {
    space_char_blankline = " ",
    -- show_current_context = true,
    buftype_exclude = { "terminal", "nofile" },
    filetype_exclude = {
        "startify",
        "dashboard",
        "packer",
        "neogitstatus",
        "NvimTree",
        "Trouble",
        "help",
    },
    blankline_char = "▏", -- "│" ▏
    show_trailing_blankline_indent = false,
    show_first_indent_level = true,
    -- use_treesitter = true,
    -- context_patterns = {
    --     "class",
    --     "return",
    --     "function",
    --     "method",
    --     "^if",
    --     "^while",
    --     "jsx_element",
    --     "^for",
    --     "^object",
    --     "^table",
    --     "block",
    --     "arguments",
    --     "if_statement",
    --     "else_clause",
    --     "jsx_element",
    --     "jsx_self_closing_element",
    --     "try_statement",
    --     "catch_clause",
    --     "import_statement",
    --     "operation_type",
    -- }
}

-- HACK: work-around for https://github.com/lukas-reineke/indent-blankline.nvim/issues/59
vim.wo.colorcolumn = "99999"
