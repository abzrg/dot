vim.cmd.colorscheme("vscode")
  -- vim.opt.background = "light"
  -- vim.cmd.highlight("BufferLineBufferSelected cterm=none gui=none guifg=#d4d4d4 guibg=#1e1e1e")
  -- vim.cmd.highlight("Normal guibg=None")
  vim.cmd.highlight("Title guifg=#569cd6")


-- vim.cmd.colorscheme("neovim_purple")
--   vim.cmd.highlight("LspReferenceWrite guibg=#343b41")
--   vim.cmd.highlight("LspReferenceRead guibg=#343b41")
--   vim.cmd.highlight("LspReferenceText guibg=#343b41")
--   vim.cmd.highlight("@textReference guifg=#ce9178")
--
--   vim.cmd.highlight("CursorLine cterm=underline guibg=#1f1f3f")
--   vim.cmd.highlight("Normal guibg=#2d2b59")
--   vim.cmd.highlight("SignColumn guibg=#28284b")
--   vim.cmd.highlight("LineNr guibg=#28284b guifg=#a399e3")
--   vim.cmd.highlight("CursorLineNr guifg=#c6c6c6 guibg=#28284b")
--
--   vim.cmd.highlight("GitSignsAdd    guibg=#28284b")
--   vim.cmd.highlight("GitSignsChange guibg=#28284b")
--   vim.cmd.highlight("GitSignsDelete guibg=#28284b")
--
--   vim.cmd.highlight("Visual guibg=#6e4aaa")
--
--   vim.cmd.highlight("Comment gui=italic")


--
--   -- background
--   vim.cmd.highlight("Normal guibg=None")
--
--   -- signcolumn area
--   vim.cmd.highlight('DiffChange guibg=None')
--   vim.cmd.highlight('DiffAdd guibg=None')

-- vim.cmd.colorscheme "default"

--[[

require("catppuccin").setup({
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    background = { -- :h background
        light = "latte",
        dark = "mocha",
    },
    transparent_background = false, -- disables setting the background color.
    show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
    term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
    dim_inactive = {
        enabled = false, -- dims the background color of inactive window
        shade = "dark",
        percentage = 0.15, -- percentage of the shade to apply to the inactive window
    },
    no_italic = false, -- Force no italic
    no_bold = true, -- Force no bold
    no_underline = false, -- Force no underline
    styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
        comments = { "italic" }, -- Change the style of comments
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
    },
    color_overrides = {},
    custom_highlights = {},
    integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        telescope = true,
        notify = false,
        mini = false,
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
    },
})
--]]

-- setup must be called before loading
-- vim.cmd.colorscheme "catppuccin"
