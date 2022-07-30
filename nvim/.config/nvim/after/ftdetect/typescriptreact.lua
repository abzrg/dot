local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local group = augroup("TypescriptReactFtDetect", { clear = true })
autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.tsx",
  callback = function() vim.opt_local.filetype = "typescriptreact" end,
  group = group
})
