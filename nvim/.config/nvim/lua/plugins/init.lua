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

  'simrat39/symbols-outline.nvim',
  {
    'Mofiqul/vscode.nvim',
    -- config = function()
    --   vim.cmd.colorscheme("vscode")
    -- end
  },
}
