return {
  { 'tpope/vim-surround' },
  -- { 'tpope/vim-endwise' },  --- No, No, No, Noooo, God, ..., Noooooooooooooooooh
  -- + 'enuch' or whatever it is called too creates the problem with blink while pressing <cr>
  { 'tpope/vim-speeddating' },
  { 'tpope/vim-sleuth' },
  { 'tpope/vim-repeat' },
  { 'tpope/vim-unimpaired' },
  { 'tpope/vim-rsi' },
  {
    'tpope/vim-dispatch',
    lazy = true,
    cmd = { 'Dispatch', 'Make', 'Focus', 'Start' }
  },
  {
    'vladdoster/remember.nvim',
    config = function()
      require('remember')
    end
  },
  {
    'tommason14/lammps.vim'
  },
  {
    'rhysd/committia.vim',
    lazy = true,
    ft = "gitcommit",
    config = function()
      vim.g.committia_min_window_width = 90
      vim.g.committia_edit_window_width = 50
      vim.g.committia_status_window_min_height = 100
    end
  }
}
