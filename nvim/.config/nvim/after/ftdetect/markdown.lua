local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local group = augroup("MarkdownFtDetect", { clear = true })
autocmd({ "BufRead" }, {
  pattern = "*.md",
  callback = function() vim.bo.filetype = "markdown" end,
  group = group
})
