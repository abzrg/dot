vim.cmd([[
  highlight! link ColorColumn DiffDelete
]])
vim.fn.matchadd("ColorColumn", "\\%81v", 100)
