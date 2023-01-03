-- Check it is installed first
if vim.g.loaded_committia ~= 1 then
  return
end

vim.g.committia_min_window_width = 90
vim.g.committia_edit_window_width = 68
