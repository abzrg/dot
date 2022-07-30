local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local group = augroup("GnuplotFtDetect", { clear = true })
autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.gp", "*.gnuplot", "*.gnu", "*.plot", "*.plt" },
  callback = function() vim.opt_local.filetype = "gnuplot" end,
  group = group
})
