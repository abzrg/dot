local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local group = augroup("MarkdownFtDetect", { clear = true })
autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.md",
  callback = function() vim.opt_local.filetype = "markdown" end,
  group = group
})
