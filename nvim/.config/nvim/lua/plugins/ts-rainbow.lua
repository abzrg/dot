require'nvim-treesitter.configs'.setup {
  rainbow = {
    enable = true,
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = 1000, -- Do not enable for files with more than n lines, int
    -- colors = {  -- table of hex strings (default)
    --     "#cc241d", -- 6th level of nesting color
    --     "#a89984", -- 3th level of nesting color
    --     "#b16286", -- 0th level of nesting color
    --     "#d79921", -- 4th level of nesting color
    --     "#689d6a", -- 1th level of nesting color
    --     "#d65d0e", -- 5th level of nesting color
    --     "#458588"  -- 2th level of nesting color
    -- },
    -- termcolors = {} -- table of colour name strings
    disable = {
        "html"
    }
  }
}
