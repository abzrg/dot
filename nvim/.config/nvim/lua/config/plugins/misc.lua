return {
  { 'tpope/vim-surround' },
  -- { 'tpope/vim-endwise' },  --- No, No, No, Noooo, God, ..., Noooooooooooooooooh
  -- + 'enuch' or whatever it is called too creates the problem with blink while pressing <cr>
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
}
