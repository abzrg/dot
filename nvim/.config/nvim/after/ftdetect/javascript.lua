local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local group = augroup("JsFtDetect", { clear = true })
autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.es6", "*.flow" },
  callback = function() vim.opt_local.filetype = "javascript" end,
  group = group
})
