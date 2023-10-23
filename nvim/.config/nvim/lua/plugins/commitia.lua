return {
  'rhysd/committia.vim',
  lazy = true,
  ft = "gitcommit",
  config = function()
    vim.g.committia_min_window_width = 90
    vim.g.committia_edit_window_width = 68
  end
}
