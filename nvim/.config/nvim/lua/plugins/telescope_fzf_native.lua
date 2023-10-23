return {
  'nvim-telescope/telescope-fzf-native.nvim',
  dependencies = {
    'nvim-telescope/telescope.nvim'
  },
  lazy = true,
  build = 'make',
  cond = vim.fn.executable 'make' == 1
}
