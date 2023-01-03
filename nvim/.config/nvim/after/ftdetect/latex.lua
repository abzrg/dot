local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local group = augroup("LatexFtDetect", { clear = true })
autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.tex",
  callback = function() vim.opt_local.filetype = "tex" end,
  group = group
})
