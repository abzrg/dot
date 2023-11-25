return {

  -- Misc.
  'lewis6991/gitsigns.nvim',
  'tpope/vim-surround',
  'tpope/vim-endwise',
  'tpope/vim-repeat',
  'tpope/vim-unimpaired',
  'tpope/vim-rsi',

  {
    'tpope/vim-dispatch',
    lazy = true,
    cmd = { 'Dispatch', 'Make', 'Focus', 'Start' }
  },



  'ironhouzi/starlite-nvim',
  'nacro90/numb.nvim',
  'NvChad/nvim-colorizer.lua',
  'rhysd/clever-f.vim',

  { 'folke/zen-mode.nvim', lazy = true, cmd = { 'ZenMode' } },
  { 'folke/twilight.nvim', lazy = true, cmd = { 'Twilight' } },

  {
    'simrat39/symbols-outline.nvim',
    config = function ()
      require("symbols-outline").setup()
    end
  },

  -- latest python stubs
  {
      "microsoft/python-type-stubs",
      cond = false
  },

  {
    'Mofiqul/vscode.nvim',
    -- config = function()
    --   vim.cmd.colorscheme("vscode")
    -- end
  },

  {
    'drgarcia1986/python-compilers.vim'
  },

  {
    'craftzdog/solarized-osaka.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      transparent = false, -- Enable this to disable setting the background color
      terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
      styles = {
        -- Style to be applied to different syntax groups
        -- Value is any valid attr-list value for `:help nvim_set_hl`
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
        -- Background styles. Can be "dark", "transparent" or "normal"
        sidebars = "dark",          -- style for sidebars, see below
        floats = "dark",            -- style for floating windows
      },
      sidebars = { "qf", "help" },  -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
      day_brightness = 0.3,         -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
      hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
      dim_inactive = false,         -- dims inactive windows
      lualine_bold = false,         -- When `true`, section headers in the lualine theme will be bold

      --- You can override specific color groups to use other groups or a hex color
      --- function will be called with a ColorScheme table
      ---@param colors ColorScheme
      on_colors = function(colors) end,

      --- You can override specific highlights to use other groups or a hex color
      --- function will be called with a Highlights and ColorScheme table
      ---@param highlights Highlights
      ---@param colors ColorScheme
      on_highlights = function(highlights, colors) end,
    },
  },
}
